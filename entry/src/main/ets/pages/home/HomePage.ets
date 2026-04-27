import { ServiceStatusCapsule } from "../../components/ServiceStatusCapsule";
import { HomeState } from "../../redux/home/HomeState";
import { HomeViewModel } from "../../viewmodel/HomeViewModel"
import { HomeTodayMetricsSection } from "./HomeMetricsSection";
import { HomeQuickStartCard } from "./HomeQuickStartCard";

@ComponentV2
struct HomePage {
  private viewModel: HomeViewModel = new HomeViewModel();
  private state: HomeState = this.viewModel.homeState;

  build() {
    Column({space: 32}) {

      ServiceStatusCapsule({ mode: this.state.uiModel.serverMode })

      HomeTodayMetricsSection({ state: this.state })

      HomeQuickStartCard()

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