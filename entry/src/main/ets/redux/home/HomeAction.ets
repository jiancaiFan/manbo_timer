import { StateStore, Action } from "@hadss/state_store";

export default class HomeAction {
  static HomeServiceStatusSelect: Action = StateStore.createAction('selectServiceStatus');
  static HOmeProjectListFetch: Action = StateStore.createAction('hOmeProjectListFetch')
};