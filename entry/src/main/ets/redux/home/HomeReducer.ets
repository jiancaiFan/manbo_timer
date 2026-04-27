import { Reducer, Action } from "@hadss/state_store";
import HomeAction from "./HomeAction";
import { HomeState } from "./HomeState";

export const homeReducer: Reducer<HomeState> = (state: HomeState, action: Action) => {

  switch (action.type) {
    case HomeAction.SelectServiceStatus.type:
      return async () => { state.uiModel.serverMode = action.payload }
  }
  return null;
};