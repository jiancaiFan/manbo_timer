import { liveViewManager } from '@kit.LiveViewKit';
import { Want, wantAgent, WantAgent, common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';

export class CountdownLiveViewManager {
  private static readonly LIVE_VIEW_ID: number = 8;
  private context: common.UIAbilityContext;
  private sequence: number = 0;

  constructor(context: common.UIAbilityContext) {
    this.context = context;
  }

  // 1. 启动实况窗
  public async startLiveView(projectName: string, remainingSeconds: number): Promise<void> {
    try {
      let isEnabled: boolean = await liveViewManager.isLiveViewEnabled();
      if (!isEnabled) return;

      this.sequence = 1;
      let viewData: liveViewManager.LiveView = await this.buildTimerView(projectName, remainingSeconds, false);
      await liveViewManager.startLiveView(viewData);
    } catch (error) {
      let err = error as BusinessError;
      console.error(`CountdownLiveView start error: ${err.code} ${err.message}`);
    }
  }

  // 2. 暂停/恢复实况窗
  public async updateLiveView(projectName: string, remainingSeconds: number, isPaused: boolean): Promise<void> {
    try {
      let isEnabled: boolean = await liveViewManager.isLiveViewEnabled();
      if (!isEnabled) return;

      this.sequence += 1;
      let viewData: liveViewManager.LiveView = await this.buildTimerView(projectName, remainingSeconds, isPaused);
      await liveViewManager.updateLiveView(viewData);
    } catch (error) {
      let err = error as BusinessError;
      console.error(`CountdownLiveView update error: ${err.code} ${err.message}`);
    }
  }

  // 3. 停止实况窗
  public async stopLiveView(): Promise<void> {
    try {
      let isEnabled: boolean = await liveViewManager.isLiveViewEnabled();
      if (!isEnabled) return;

      this.sequence += 1;
      let viewData: liveViewManager.LiveView = await this.buildTimerView("已结束", 0, true);

      viewData.liveViewData.capsule = {
        type: liveViewManager.CapsuleType.CAPSULE_TYPE_TEXT,
        status: 1,
        title: "已结束"
      };

      await liveViewManager.stopLiveView(viewData);
    } catch (error) {
      let err = error as BusinessError;
      console.error(`CountdownLiveView stop error: ${err.code} ${err.message}`);
    }
  }

  // 构造实况窗请求体：极简视觉优化版
  private async buildTimerView(projectName: string, remainingSeconds: number, isPaused: boolean): Promise<liveViewManager.LiveView> {
    let view: liveViewManager.LiveView = {
      id: CountdownLiveViewManager.LIVE_VIEW_ID,
      event: "TIMER",
      sequence: this.sequence,
      isMute: false,
      timer: {
        time: remainingSeconds * 1000,
        isCountdown: true,
        isPaused: isPaused
      },
      liveViewData: {
        primary: {
          title: projectName,
          content: [
            // 【美化 1】：用极其克制的单点占位符，代替啰嗦的“正在倒计时”，让左侧留白
            { text: isPaused ? "已暂停" : "专注中..." }
          ],
          keepTime: 15,
          layoutData: {
            layoutType: liveViewManager.LayoutType.LAYOUT_TYPE_PICKUP,
            title: "剩余时间",
            content: '${placeholder.timer}',
            // 【美化 2】：把那条难看的蓝/绿色下划线彻底变透明！
            underlineColor: '#00000000',
            descPic: 'timer.png'
          },
          extensionData: {
            type: liveViewManager.ExtensionType.EXTENSION_TYPE_DEFAULT
          }
        },
        capsule: {
          type: liveViewManager.CapsuleType.CAPSULE_TYPE_TIMER,
          status: 1,
          icon: 'capsule_timer.png',
          // 【美化 3】：换成更高级的沉稳黑蓝色系 (或者你App的主题色)
          backgroundColor: '#FF1E1E1E',
          time: remainingSeconds * 1000,
          isCountdown: true,
          isPaused: isPaused
        }
      }
    };

    try {
      let targetWant: Want = {
        bundleName: this.context.abilityInfo.bundleName,
        abilityName: this.context.abilityInfo.name
      };

      let wantAgentInfo: wantAgent.WantAgentInfo = {
        wants: [targetWant],
        actionType: wantAgent.OperationType.START_ABILITIES,
        requestCode: 0,
        actionFlags: [wantAgent.WantAgentFlags.UPDATE_PRESENT_FLAG]
      };

      let agent: WantAgent = await wantAgent.getWantAgent(wantAgentInfo);
      view.liveViewData.primary.clickAction = agent;
    } catch (error) {
      console.error('CountdownLiveView buildWantAgent error');
    }

    return view;
  }
}