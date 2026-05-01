import { ProjectItem } from "../../model/home/HomeUIModel";
import { HomeState } from "../../redux/home/HomeState";
import { HomeProjectListItem } from "./HomeProjectListItem";
import { HomeViewModel } from "../../viewmodel/HomeViewModel";

@ComponentV2
export struct HomeProjectList {

  @Param @Require viewModel: HomeViewModel
  private state: HomeState = this.viewModel.homeState;
  @Local isAppeared: boolean = false;

  aboutToAppear(): void {
    this.viewModel.fetchHomeProjectList();
  }

  build() {
    Column({ space: 16 }) {

      Text(this.state.uiModel.projectList?.length.toString())

      ForEach(this.state.uiModel.projectList, (item: ProjectItem, index: number) => {
        HomeProjectListItem({
          item: item,
          index: index,
          isAppeared: this.isAppeared
        })
      })
    }
    .width('100%')
    .padding({ bottom: 32 })
    .onAppear(() => {
      this.getUIContext().animateTo({ duration: 0 }, () => {
        this.isAppeared = true;
      });
    })
  }
}