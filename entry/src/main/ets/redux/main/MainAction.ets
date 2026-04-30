import { StateStore, Action } from "@hadss/state_store";

export default class MainAction {
  static MainTabListFetch: Action = StateStore.createAction('mainTabListFetch');
  static MainTabSelect: Action = StateStore.createAction('mainTabSelect');
};