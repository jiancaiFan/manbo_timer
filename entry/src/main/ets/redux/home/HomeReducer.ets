import { Reducer, Action } from "@hadss/state_store";
import HomeAction from "./HomeAction";
import { HomeState } from "./HomeState";
import { HomeSideEffect } from "./HomeSideEffect";

export const homeReducer: Reducer<HomeState> = (state: HomeState, action: Action) => {

  console.log('actionPayload',`home: ${JSON.stringify(action.payload)}`)

  switch (action.type) {
    case HomeAction.HomeServiceStatusSelect.type:
      return async () => { state.uiModel.serverMode = action.payload; }

    case HomeAction.HOmeProjectListFetch.type:
      return async () => { HomeSideEffect.fetchHomeProjectList(); }

    case HomeAction.HomeProjectListLoad.type:
      return async () => { state.uiModel.projectList = action.payload; }
  }
  return null;
};