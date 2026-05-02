import { ProjectItem } from "../../model/home/HomeUIModel";
import { HomeState } from "../../redux/home/HomeState";
import { HomeProjectListItem } from "./HomeProjectListItem";

@ComponentV2
export struct HomeProjectList {
  @Param @Require state: HomeState;
  @Event onFetchProjectsClick: () => void;

  aboutToAppear(): void {
    this.onFetchProjectsClick();
  }

  build() {
    Column({ space: 16 }) {
      Repeat<ProjectItem>(this.state.uiModel.projectList)
        .each((obj: RepeatItem<ProjectItem>) => {
          HomeProjectListItem({
            item: obj.item,
            index: obj.index
          })
        })
    }
    .width('100%')
  }
}