import { Reducer, Action } from "@hadss/state_store";
import MainAction from "./MainAction";
import { MainMapper } from "./MainMapper";
import { MainState } from "./MainState";

export const mainReducer: Reducer<MainState> = (state: MainState, action: Action) => {

  console.log('actionPayload',action.payload)

  switch (action.type) {
    case MainAction.FetchTabList.type:
      return async  () => { state.uiModel = MainMapper.toUIModel(); }
    case MainAction.SelectTab.type:
      return async  () => {
        state.uiModel.currentTab = action.payload
      }
  }
  return null;
};