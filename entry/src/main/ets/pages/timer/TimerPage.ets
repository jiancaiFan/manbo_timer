import { GlobalContext } from "../../common/GlobalContext"
import { CountdownManager, CountdownState } from "../../utils/CountdownManager";
import { TimerTopActionBar } from "./TimerTopActionBar"

@ComponentV2
struct TimerPage {

  @Local manager: CountdownManager = CountdownManager.getInstance(GlobalContext.getInstance().getContext());

  private getStateText(): string {
    switch (this.manager.state) {
      case CountdownState.IDLE: return '请在首页选择项目开始';
      case CountdownState.RUNNING: return '服务进行中';
      case CountdownState.PAUSED: return '服务已暂停';
      case CountdownState.FINISHED: return '服务已完成';
      default: return '';
    }
  }

  build() {
    Column() {
      TimerTopActionBar()
      Text(this.getStateText())
        .fontSize(16)
        .fontColor(this.manager.state === CountdownState.RUNNING ? '#10B981' : '#8E8E93')
      Text(this.manager.formattedRemainingTime)
        .fontSize(64)
        .fontWeight(FontWeight.Bolder)
        .fontFamily('HarmonyOS Sans')
        .fontColor(this.manager.state === CountdownState.PAUSED ? '#F59E0B' : '#1D1D1F')
        .lineHeight(72)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
  }
}

@Builder
export function TimerViewBuilder() {
  TimerPage()
}