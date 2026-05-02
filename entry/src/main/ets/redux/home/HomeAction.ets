import { StateStore, Action } from "@hadss/state_store";

export default class HomeAction {
  public static HomeServiceStatusSelect: Action = StateStore.createAction('homeServiceStatusSelect');
  public static HOmeProjectListFetch: Action = StateStore.createAction('homeProjectListFetch')
  public static HomeProjectListLoad: Action = StateStore.createAction('homeProjectListLoad')
};