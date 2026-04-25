import { hdsMaterial, HdsTabs, HdsTabsController } from '@kit.UIDesignKit';
import { MainState } from '../../redux/main/MainState';
import { SymbolGlyphModifier } from '@kit.ArkUI';
import { MainViewModel } from '../../viewmodel/MainViewModel';
import { TabItem } from '../../model/main/MainUIModel';

@ComponentV2
export struct MainPage {

  private tabsController: HdsTabsController = new HdsTabsController();
  private viewModel: MainViewModel = new MainViewModel();
  @Local state: MainState = this.viewModel.mainState;

  aboutToAppear(): void {
    this.viewModel.fetchTabList();
  }

  build() {
    Stack() {
      HdsTabs({ controller: this.tabsController }) {
        ForEach(this.state.uiModel.tabList, (item: TabItem, index: number) => {
          TabContent() {
            Column() {
              Text(`${this.state.uiModel.currentTab}`)
              this.tabContentBuilder(index)
            }
          }
          .tabBar(
            new BottomTabBarStyle({
              normal: new SymbolGlyphModifier(item.normalIcon)
                .fontColor([$r('sys.color.ohos_id_color_bottom_tab_icon_off')]),
              selected: new SymbolGlyphModifier(item.selectedIcon)
                .fontColor([$r('sys.color.ohos_id_color_activated')])
            }, item.title)
              .labelStyle({
                selectedColor: $r('sys.color.black')
              })
          )
        })
      }
      .barOverlap(true)
      .barPosition(BarPosition.End)
      .vertical(false)
      .barFloatingStyle({
        systemMaterialEffect: {
          materialType: hdsMaterial.MaterialType.ADAPTIVE,
          materialLevel: hdsMaterial.MaterialLevel.ADAPTIVE
        }
      })
      .animationDuration(200)
      .scrollable(false)
      .barMode(BarMode.Fixed)
      .onChange((index: number) => {
        this.viewModel.onTabSelected(index);
      })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  tabContentBuilder(index: number) {
    Column() {
      if (index === 0) {
        this.HomeView()
      } else if (index === 1) {
        this.DiscoverView()
      } else if (index === 2) {
        this.MineView()
      }
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  HomeView() {
    Column() {
      Text('首页内容')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  DiscoverView() {
    Column() {
      Text('发现内容')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  MineView() {
    Column() {
      Text('我的页面')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}