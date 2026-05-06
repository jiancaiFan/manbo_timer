import { common } from '@kit.AbilityKit';
import { preferences } from '@kit.ArkData';
import { TTSManager } from './TTSManager';
import { PromptSoundManager } from './PromptSoundManager';
import { VibrationManager } from './VibrationManager';
import TimerAction from '../redux/timer/TimerAction';
import { TimerStore } from '../redux/timer/TimerStore';
import { ProjectItem } from '../model/home/HomeUIModel';
import { ServiceRecord } from '../model/timer/TimerUIModel';
import { CountdownReminderManager } from './CountdownReminderManager';
import { CountdownLiveViewManager } from './CountdownLiveViewManager';

export enum CountdownState {
  IDLE,
  RUNNING,
  PAUSED,
  FINISHED
}

interface SavedCountdownData {
  state: CountdownState;
  targetEndTime: number;
  remainingSeconds: number;
  currentItem: ProjectItem | undefined;
}

const PREF_NAME = 'countdown_store';
const KEY_STATE = 'saved_state';

@ObservedV2
export class CountdownManager {
  @Trace public state: CountdownState = CountdownState.IDLE;
  @Trace public remainingSeconds: number = 0;
  @Trace public currentItem: ProjectItem | undefined = undefined;

  private context: common.UIAbilityContext;
  private timerId: number = -1;
  private targetEndTime: number = 0;
  private lastFeedbackSeconds: number = 0;

  private ttsManager: TTSManager = new TTSManager();
  private promptManager: PromptSoundManager = new PromptSoundManager();
  private reminderManager: CountdownReminderManager = new CountdownReminderManager();
  private liveViewManager: CountdownLiveViewManager;

  private static instance: CountdownManager | undefined = undefined;

  public static getInstance(context: common.UIAbilityContext): CountdownManager {
    if (CountdownManager.instance === undefined) {
      CountdownManager.instance = new CountdownManager(context);
    }
    return CountdownManager.instance;
  }

  constructor(context: common.UIAbilityContext) {
    this.context = context;
    this.liveViewManager = new CountdownLiveViewManager(context);
  }

  @Computed
  public get totalSeconds(): number {
    if (this.currentItem === undefined) {
      return 0;
    }
    return this.currentItem.projectTotalDuration * 60;
  }

  @Computed
  public get elapsedSeconds(): number {
    if (this.state === CountdownState.IDLE) {
      return 0;
    }
    return this.totalSeconds - this.remainingSeconds;
  }

  @Computed
  public get formattedRemainingTime(): string {
    let sec = this.remainingSeconds < 0 ? 0 : this.remainingSeconds;
    let m = Math.floor(sec / 60).toString().padStart(2, '0');
    let s = (sec % 60).toString().padStart(2, '0');
    return `${m}:${s}`;
  }

  public async init(): Promise<void> {
    await this.ttsManager.init();
    await this.promptManager.init(this.context);
    await this.restoreStateFromDisk();
  }

  public start(item: ProjectItem): void {
    let isAlreadyActive = (this.state === CountdownState.RUNNING || this.state === CountdownState.PAUSED);

    this.stopEngine();
    this.currentItem = item;
    this.remainingSeconds = item.projectTotalDuration * 60;
    this.targetEndTime = Date.now() + this.remainingSeconds * 1000;
    this.lastFeedbackSeconds = this.remainingSeconds;
    this.state = CountdownState.RUNNING;

    this.ttsManager.speak(`开始项目 ${item.projectName}`);
    this.startEngine();
    this.saveStateToDisk();

    if (isAlreadyActive) {
      this.liveViewManager.updateLiveView(item.projectName, this.remainingSeconds, false);
    } else {
      this.liveViewManager.startLiveView(item.projectName, this.remainingSeconds);
    }
  }

  public pause(): void {
    if (this.state === CountdownState.RUNNING) {
      this.state = CountdownState.PAUSED;
      this.stopEngine();
      this.ttsManager.speak("已暂停");
      this.saveStateToDisk(); // 存盘

      let projName = this.currentItem?.projectName ?? "服务";
      this.liveViewManager.updateLiveView(projName, this.remainingSeconds, true);
    }
  }

  public resume(): void {
    if (this.state === CountdownState.PAUSED) {
      this.state = CountdownState.RUNNING;
      this.targetEndTime = Date.now() + this.remainingSeconds * 1000;
      this.startEngine();
      this.ttsManager.speak("继续计时");
      this.saveStateToDisk(); // 存盘

      let projName = this.currentItem?.projectName ?? "服务";
      this.liveViewManager.updateLiveView(projName, this.remainingSeconds, false);
    }
  }

  public cancel(): void {
    this.state = CountdownState.IDLE;
    this.remainingSeconds = 0;
    this.stopEngine();
    this.ttsManager.speak("已取消");
    this.saveStateToDisk(); // 存盘

    this.liveViewManager.stopLiveView();
  }

  public finish(): void {
    if (this.state === CountdownState.FINISHED) {
      return;
    }

    this.state = CountdownState.FINISHED;
    this.remainingSeconds = 0;
    this.stopEngine();

    VibrationManager.vibrateAlarm(1000);
    this.promptManager.play();

    const projName = this.currentItem?.projectName ?? "服务";
    this.ttsManager.speak(`${projName} 已完成`);

    if (this.currentItem !== undefined) {
      let record: ServiceRecord = {
        projectName: this.currentItem.projectName,
        durationMinutes: this.currentItem.projectTotalDuration,
        amount: this.currentItem.projectAmount,
        serviceDate: Date.now()
      };
      TimerStore.dispatch(TimerAction.TimerServiceRecordAdd.setPayload(record));
    }

    this.saveStateToDisk(); // 存盘
    this.liveViewManager.stopLiveView();
  }

  public release(): void {
    this.stopEngine();
    this.ttsManager.release();
    this.promptManager.release();
    // 删除了主动 stopLiveView，交由系统回收机制处理
  }

  private startEngine(): void {
    let projName = this.currentItem?.projectName ?? "服务";
    let intervalSec = (this.currentItem?.projectIntervalDuration ?? 10) * 60;

    this.reminderManager.scheduleReminders(this.remainingSeconds, intervalSec, projName);

    this.timerId = setInterval(() => {
      this.syncCurrentTime();
    }, 1000);
  }

  private stopEngine(): void {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
    this.reminderManager.cancelAll();
  }

  public syncCurrentTime(): void {
    if (this.state !== CountdownState.RUNNING) {
      return;
    }

    let remainingMs = this.targetEndTime - Date.now();

    if (remainingMs <= 0) {
      this.finish();
      return;
    }

    this.remainingSeconds = Math.ceil(remainingMs / 1000);

    let intervalSec = (this.currentItem?.projectIntervalDuration ?? 10) * 60;
    if (this.remainingSeconds !== this.lastFeedbackSeconds &&
      this.remainingSeconds > 0 &&
      this.remainingSeconds % intervalSec === 0) {

      this.lastFeedbackSeconds = this.remainingSeconds;
      this.triggerIntervalFeedback();
    }
  }

  private triggerIntervalFeedback(): void {
    VibrationManager.vibrateAlarm(500);
    this.promptManager.play();
    let min = Math.floor(this.remainingSeconds / 60);
    this.ttsManager.speak(`剩余 ${min} 分钟`);
  }

  private async saveStateToDisk(): Promise<void> {
    try {
      let pref = await preferences.getPreferences(this.context, PREF_NAME);

      // 1. 定义外层的字典数据格式（完全避免 any 和 unknown）
      let dataToSave: Record<string, number | Record<string, string | number> | undefined> = {
        "state": this.state as number,
        "targetEndTime": this.targetEndTime,
        "remainingSeconds": this.remainingSeconds,
        "currentItem": undefined
      };

      // 2. 提取响应式数据到纯字典中
      if (this.currentItem !== undefined) {
        let itemRecord: Record<string, string | number> = {
          "projectName": this.currentItem.projectName,
          "projectTotalDuration": this.currentItem.projectTotalDuration,
          "projectAmount": this.currentItem.projectAmount
        };

        // 针对可能为 undefined 的属性单独安全赋值
        if (this.currentItem.projectIntervalDuration !== undefined) {
          itemRecord["projectIntervalDuration"] = this.currentItem.projectIntervalDuration;
        }

        dataToSave["currentItem"] = itemRecord;
      }

      // 3. 直接将 Record 序列化并存盘
      await pref.put(KEY_STATE, JSON.stringify(dataToSave));
      await pref.flush();
    } catch (e) {
      console.error(`CountdownManager: 存盘失败`);
    }
  }

  private async restoreStateFromDisk(): Promise<void> {
    try {
      let pref = await preferences.getPreferences(this.context, PREF_NAME);
      let val = await pref.get(KEY_STATE, "") as string;
      if (!val) {
        return;
      }

      let data = JSON.parse(val) as SavedCountdownData;

      if (data.state === CountdownState.IDLE || data.state === CountdownState.FINISHED) {
        return;
      }

      this.currentItem = data.currentItem;
      this.state = data.state;
      let projName = data.currentItem?.projectName ?? "服务";

      if (data.state === CountdownState.RUNNING) {
        this.targetEndTime = data.targetEndTime;
        let remainingMs = this.targetEndTime - Date.now();

        if (remainingMs <= 0) {
          this.finish();
        } else {
          this.remainingSeconds = Math.ceil(remainingMs / 1000);
          this.startEngine();
          this.liveViewManager.startLiveView(projName, this.remainingSeconds);
        }
      } else if (data.state === CountdownState.PAUSED) {
        this.remainingSeconds = data.remainingSeconds;
        this.targetEndTime = data.targetEndTime;
        this.liveViewManager.startLiveView(projName, this.remainingSeconds);
        this.liveViewManager.updateLiveView(projName, this.remainingSeconds, true);
      }
    } catch (e) {
      console.error(`CountdownManager: 读盘恢复失败`);
    }
  }
}