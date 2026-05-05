import { Reducer, Action } from "@hadss/state_store";
import TimerAction from "./TimerAction";
import { TimerState } from "./TimerState";

export const timerReducer: Reducer<TimerState> = (state: TimerState, action: Action) => {
  switch (action.type) {
    case TimerAction.TimerServiceRecordAdd.type:
      return async () => {
        state.uiModel.serviceRecords.push(action.payload);
        console.info(`Timer: 新增服务记录, 当前记录数 ${state.uiModel.serviceRecords.length}`);
      }
  }
  return null;
};