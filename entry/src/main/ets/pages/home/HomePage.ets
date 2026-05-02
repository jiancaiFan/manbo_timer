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
    Scroll() {
      Column({ space: 40 }) {
        HomeTopActionBar({
          mode: this.state.uiModel.serverMode
        })
        HomeTodayMetricsSection({ state: this.state })
        HomeQuickStartCard()
        HomeProjectHeader()

        HomeProjectList({
          state: this.state,
          onFetchProjectsClick: () => {
            this.viewModel.fetchHomeProjectList();
          }
        })
      }
      .width('100%')
      .padding({ right: 16, left: 16, bottom: 120 })
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
    .align(Alignment.Top)
    .edgeEffect(EdgeEffect.Spring)
  }
}

@Builder
export function HomeViewBuilder() {
  HomePage()
}