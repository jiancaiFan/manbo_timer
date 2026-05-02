import { StateStore, Action } from "@hadss/state_store";

export default class MainAction {
  public static MainTabListFetch: Action = StateStore.createAction('mainTabListFetch');
  public static MainTabSelect: Action = StateStore.createAction('mainTabSelect');
};