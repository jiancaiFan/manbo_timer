import { MainUIModel } from "../../model/main/MainUIModel";

export class MainMapper{

  public static async toUIModel(): Promise<MainUIModel> {
    return new MainUIModel([
      {
        title: '首页',
        normalIcon: $r('sys.symbol.house'),
        selectedIcon: $r('sys.symbol.house_fill')
      },
      {
        title: '计时',
        normalIcon: $r('sys.symbol.timer'),
        selectedIcon: $r('sys.symbol.timer_circle_fill')
      },
      {
        title: '我的',
        normalIcon: $r('sys.symbol.person'),
        selectedIcon: $r('sys.symbol.person_fill')
      }
    ], 0);
  }
}