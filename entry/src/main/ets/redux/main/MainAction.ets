import { StateStore, Action } from "@hadss/state_store";

export default class MainAction {
  static FetchTabList: Action = StateStore.createAction('fetchTabList');
  static SelectTab: Action = StateStore.createAction('selectTab');
};