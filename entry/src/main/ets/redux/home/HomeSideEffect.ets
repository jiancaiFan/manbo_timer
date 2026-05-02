import HomeAction from "./HomeAction";
import { HomeMapper } from "./HomeMapper";
import { HomeStore } from "./HomeStore";

export class HomeSideEffect{

  public static fetchHomeProjectList() {

    HomeMapper.toHomeProjectsUIModel().then(
      (data) => {
        HomeStore.dispatch(HomeAction.HomeProjectListLoad.setPayload(data))
      }
    )
  }
}