import { GlobalContext } from "../../common/GlobalContext";
import HomeAction from "./HomeAction";
import { HomeMapper } from "./HomeMapper";
import { HomeStore } from "./HomeStore";

export class HomeSideEffect{

  public static fetchHomeProjectList() {

    HomeMapper.toHomeProjectsUIModel(GlobalContext.getInstance().getContext()).then(
      (data) => {
        HomeStore.dispatch(HomeAction.HomeProjectListLoad.setPayload(data))
      }
    )
  }
}