import { MainUIModel } from "../../model/main/MainUIModel";

@ObservedV2
export class MainState{
  @Trace uiModel: MainUIModel = MainUIModel.Empty
}