import { HomeStore } from "../redux/home/HomeStore";

export class HomeViewModel {

  public homeState = HomeStore.getState();
}