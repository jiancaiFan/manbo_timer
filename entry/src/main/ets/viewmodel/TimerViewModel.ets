import { GlobalContext } from "../common/GlobalContext";
import { CountdownManager, CountdownState } from "../utils/CountdownManager";
import { TimerStore } from "../redux/timer/TimerStore";
import { TimerState } from "../redux/timer/TimerState";

export class TimerViewModel {
  public timerState: TimerState = TimerStore.getState();
  public manager: CountdownManager = CountdownManager.getInstance(GlobalContext.getInstance().getContext());

  public get projectName(): string {
    return this.manager.currentItem?.projectName ?? "暂无项目";
  }

  public get currentProgress(): number {
    if (this.manager.totalSeconds <= 0) {
      return 0;
    }
    return (this.manager.elapsedSeconds / this.manager.totalSeconds) * 100;
  }

  public get currentStatusText(): string {
    switch (this.manager.state) {
      case CountdownState.RUNNING:
        return "正进行";
      case CountdownState.PAUSED:
        return "已暂停";
      case CountdownState.FINISHED:
        return "已完成";
      default:
        return "未开始";
    }
  }

  public get formattedRemainingTime(): string {
    return this.manager.formattedRemainingTime;
  }

  public get formattedTotalTime(): string {
    let totalSec = this.manager.totalSeconds;
    let m = Math.floor(totalSec / 60).toString().padStart(2, '0');
    let s = (totalSec % 60).toString().padStart(2, '0');
    return `${m}:${s}`;
  }

  public get isRunning(): boolean {
    return this.manager.state === CountdownState.RUNNING;
  }

  public togglePlayPause(): void {
    if (this.manager.state === CountdownState.RUNNING) {
      this.manager.pause();
    } else if (this.manager.state === CountdownState.PAUSED) {
      this.manager.resume();
    }
  }

  public cancelTimer(): void {
    this.manager.cancel();
  }

  public finishTimer(): void {
    this.manager.finish();
  }
}