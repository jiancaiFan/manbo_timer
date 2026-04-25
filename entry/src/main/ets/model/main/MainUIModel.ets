@ObservedV2
export class MainUIModel {
  @Trace tabList: TabItem[] | undefined
  @Trace currentTab: number | undefined
  public static Empty = new MainUIModel(undefined, undefined)

  constructor(tabList: TabItem[]|undefined, currentTab: number|undefined) {
    this.tabList = tabList;
    this.currentTab = currentTab;
  }
}

export class TabItem {
  title: string|undefined;
  normalIcon: Resource|undefined;
  selectedIcon: Resource|undefined;
}