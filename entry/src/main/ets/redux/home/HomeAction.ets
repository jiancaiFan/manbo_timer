import { StateStore, Action } from "@hadss/state_store";

export default class HomeAction {
  static SelectServiceStatus: Action = StateStore.createAction('selectServiceStatus');
};