import HomeAction from "../redux/home/HomeAction";
import { HomeStore } from "../redux/home/HomeStore";

export class HomeViewModel {

  homeState = HomeStore.getState();

  public fetchHomeProjectList() {
    HomeStore.dispatch(HomeAction.HOmeProjectListFetch)
  }
}