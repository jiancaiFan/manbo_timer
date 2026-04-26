import {
  hdsMaterial,
  HdsNavigation,
  HdsNavigationTitleMode,
  HdsTabs,
  HdsTabsController,
  ScrollEffectType
} from '@kit.UIDesignKit';
import { MainState } from '../../redux/main/MainState';
import { SymbolGlyphModifier } from '@kit.ArkUI';
import { MainViewModel } from '../../viewmodel/MainViewModel';
import { TabItem } from '../../model/main/MainUIModel';
import { HomeViewBuilder } from '../home/HomePage';
import { MineViewBuilder } from '../mine/MinePage';
import { TimerViewBuilder } from '../timer/TimerPage';

@ComponentV2
export struct MainPage {
  @Provider('pageInfos') pageInfos: NavPathStack = new NavPathStack();
  private scroller: Scroller = new Scroller();
  private tabsController: HdsTabsController = new HdsTabsController();
  private viewModel: MainViewModel = new MainViewModel();
  private state: MainState = this.viewModel.mainState;

  aboutToAppear(): void {
    this.viewModel.fetchTabList();
  }

  build() {
    HdsNavigation(this.pageInfos) {
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
                  selectedColor: $r('sys.color.ohos_id_color_activated')
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
        .scrollable(true)
        .barMode(BarMode.Fixed)
        .onChange((index: number) => {
          this.viewModel.onTabSelected(index);
        })
      }
      .width('100%')
      .height('100%')
    }
    .titleBar({
      enableComponentSafeArea: true,
      style: {
        scrollEffectOpts: {
          enableScrollEffect: true,
          scrollEffectType: ScrollEffectType.COMMON_BLUR,
        },
      },
      content: {
        title: {
          mainTitle: 'MainTitle',
        },
        menu: {
          value: [{
            content: {
              label: 'menu1',
              icon: $r('sys.symbol.ohos_wifi'),
              isEnabled: true,
              action: () => {
                console.info(`HDS_NAV HELLO 1`);
              }
            }
          }]
        },
      }
    })
    .titleMode(HdsNavigationTitleMode.MINI)
    .hideBackButton(true)
    .bindToScrollable([this.scroller])
  }
}