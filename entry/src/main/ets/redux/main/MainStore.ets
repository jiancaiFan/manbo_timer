import { StateStore, Store } from "@hadss/state_store";
import { mainReducer } from "./MainReducer";
import { MainState } from "./MainState";

export const MAIN_STORE_ID = 'mainStore';

export const MainStore: Store<MainState> =
  StateStore.createStore(MAIN_STORE_ID, new MainState(), mainReducer, []);