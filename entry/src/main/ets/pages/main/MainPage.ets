import { hdsMaterial, HdsTabs, HdsTabsController } from '@kit.UIDesignKit';
import { MainState } from '../../redux/main/MainState';
import { SymbolGlyphModifier } from '@kit.ArkUI';
import { MainViewModel } from '../../viewmodel/MainViewModel';
import { TabItem } from '../../model/main/MainUIModel';
import { HomeViewBuilder } from '../home/HomePage';
import { MineViewBuilder } from '../mine/MinePage';
import { TimerViewBuilder } from '../timer/TimerPage';

@ComponentV2
export struct MainPage {
  private tabsController: HdsTabsController = new HdsTabsController();
  private viewModel: MainViewModel = new MainViewModel();
  private state: MainState = this.viewModel.mainState;

  aboutToAppear(): void {
    this.viewModel.fetchTabList();
  }

  build() {
    Stack() {
      HdsTabs({ controller: this.tabsController }) {
        ForEach(this.state.uiModel.tabList, (item: TabItem, index: number) => {
          TabContent() {
            Column() {
              if (index === 0) {
                HomeViewBuilder();
              } else if (index === 1) {
                TimerViewBuilder();
              } else if (index === 2) {
                MineViewBuilder();
              }
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
}