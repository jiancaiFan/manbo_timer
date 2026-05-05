import { ProjectItem } from "../../model/home/HomeUIModel";
import { HomeState } from "../../redux/home/HomeState";
import { HomeProjectListItem } from "./HomeProjectListItem";

@ComponentV2
export struct HomeProjectList {
  @Param @Require state: HomeState;
  @Event onFetchProjectsClick: () => void;
  @Event onItemClicked: (item: ProjectItem) => void;

  aboutToAppear(): void {
    this.onFetchProjectsClick();
  }

  build() {
    Column({ space: 16 }) {
      Repeat<ProjectItem>(this.state.uiModel.projectList)
        .each((obj: RepeatItem<ProjectItem>) => {
          HomeProjectListItem({
            item: obj.item,
            index: obj.index,
            onItemClicked: this.onItemClicked
          })
        })
    }
    .width('100%')
  }
}