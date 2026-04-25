import { MainUIModel } from "../../model/main/MainUIModel";

export class MainMapper{

  public static toUIModel(): MainUIModel {
    return new MainUIModel([
      {
        title: '首页',
        normalIcon: $r('sys.symbol.house'),
        selectedIcon: $r('sys.symbol.house_fill')
      },
      {
        title: '发现',
        normalIcon: $r('sys.symbol.circle_2'),
        selectedIcon: $r('sys.symbol.circle_fill')
      },
      {
        title: '我的',
        normalIcon: $r('sys.symbol.person'),
        selectedIcon: $r('sys.symbol.person_fill')
      }
    ], 0);
  }
}