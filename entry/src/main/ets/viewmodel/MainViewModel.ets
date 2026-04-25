import MainAction from "../redux/main/MainAction";
import { MainStore } from "../redux/main/MainStore";

export class MainViewModel{

  public mainState = MainStore.getState()

  public fetchTabList() {
    MainStore.dispatch(MainAction.FetchTabList)
  }

  public onTabSelected(index: number) {
    MainStore.dispatch(MainAction.SelectTab.setPayload(index))
  }
}