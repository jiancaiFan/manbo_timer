import { StateStore, Store } from "@hadss/state_store";
import { homeReducer } from "./HomeReducer";
import { HomeState } from "./HomeState";

export const HOME_STORE_ID = 'homeStore';

export const HomeStore: Store<HomeState> =
  StateStore.createStore(HOME_STORE_ID, new HomeState(), homeReducer, []);