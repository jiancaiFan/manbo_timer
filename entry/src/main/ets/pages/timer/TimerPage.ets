import { TimerViewModel } from "../../viewmodel/TimerViewModel"
import { TimerTopActionBar } from "./TimerTopActionBar"
import { TimerTopProgressCard } from "./TimerTopProgressCard";
import { TimerImmersiveDial } from "./TimerImmersiveDial";
import { TimerBottomActionsPanel } from "./TimerBottomActionsPanel";

@ComponentV2
struct TimerPage {
  private viewModel: TimerViewModel = new TimerViewModel();

  build() {
    // 1. 在最外层添加 Scroll 组件
    Scroll() {
      Column() {
        TimerTopActionBar()

        TimerTopProgressCard({
          projectName: this.viewModel.projectName,
          statusText: this.viewModel.currentStatusText,
          progress: this.viewModel.currentProgress
        })

        TimerImmersiveDial({
          remainingTime: this.viewModel.formattedRemainingTime,
          totalTime: this.viewModel.formattedTotalTime,
          isRunning: this.viewModel.isRunning
        })

        TimerBottomActionsPanel({
          isRunning: this.viewModel.isRunning,
          onCancel: () => {
            this.viewModel.cancelTimer()
          },
          onTogglePlayPause: () => {
            this.viewModel.togglePlayPause()
          },
          onFinish: () => {
            this.viewModel.finishTimer()
          },
          onAddExtraTime: (minutes: number) => {
            this.viewModel.addExtraTime(minutes)
          }
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .height('100%')
    .align(Alignment.Top)
    .scrollBar(BarState.Off)
  }
}

@Builder
export function TimerViewBuilder() {
  TimerPage()
}