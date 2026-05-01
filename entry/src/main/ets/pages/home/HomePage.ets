import { HomeState } from "../../redux/home/HomeState";
import { HomeViewModel } from "../../viewmodel/HomeViewModel"
import { HomeTodayMetricsSection } from "./HomeMetricsSection";
import { HomeProjectHeader } from "./HomeProjectHeader";
import { HomeProjectList } from "./HomeProjectList";
import { HomeQuickStartCard } from "./HomeQuickStartCard";
import { HomeTopActionBar } from "./HomeTopActionBar";

@ComponentV2
struct HomePage {
  private viewModel: HomeViewModel = new HomeViewModel();
  private state: HomeState = this.viewModel.homeState;

  build() {
    Column({ space: 48 }) {
      HomeTopActionBar({
        mode: this.state.uiModel.serverMode
      })
      HomeTodayMetricsSection({ state: this.state })
      HomeQuickStartCard()
      HomeProjectHeader()
      HomeProjectList({
        viewModel: this.viewModel
      })
    }
    .width('100%')
    .height('100%')
    .padding({
      right: 16,
      left: 16,
      bottom: 16
    })
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Start)
  }
}

@Builder
export function HomeViewBuilder() {
  HomePage()
}