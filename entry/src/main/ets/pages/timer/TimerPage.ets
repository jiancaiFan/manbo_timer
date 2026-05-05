import { TimerViewModel } from "../../viewmodel/TimerViewModel"
import { TimerTopActionBar } from "./TimerTopActionBar"
import { TimerTopProgressCard } from "./TimerTopProgressCard";
import { TimerImmersiveDial } from "./TimerImmersiveDial";

@ComponentV2
struct TimerPage {
  private viewModel: TimerViewModel = new TimerViewModel();

  build() {
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