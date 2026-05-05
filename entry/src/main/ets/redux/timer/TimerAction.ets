import { StateStore, Action } from "@hadss/state_store";

export default class TimerAction {
  public static TimerServiceRecordAdd: Action = StateStore.createAction('timerServiceRecordAdd');
};