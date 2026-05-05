import { StateStore, Store } from "@hadss/state_store";
import { timerReducer } from "./TimerReducer";
import { TimerState } from "./TimerState";

export const TIMER_STORE_ID = 'timerStore';

export const TimerStore: Store<TimerState> =
  StateStore.createStore(TIMER_STORE_ID, new TimerState(), timerReducer, []);