import { HdsNavigation } from '@kit.UIDesignKit';
import { MainState } from '../../redux/main/MainState';
import { MainViewModel } from '../../viewmodel/MainViewModel';
import { HomeViewBuilder } from '../home/HomePage';
import { MineViewBuilder } from '../mine/MinePage';
import { TimerViewBuilder } from '../timer/TimerPage';
import { MainBottomNavBar } from './MainBottomNavBar';

@ComponentV2
export struct MainPage {
  @Provider('pageInfos') pageInfos: NavPathStack = new NavPathStack();
  private viewModel: MainViewModel = new MainViewModel();
  private state: MainState = this.viewModel.mainState;

  aboutToAppear(): void {
    this.viewModel.fetchTabList();
  }

  build() {
    HdsNavigation(this.pageInfos) {
      Stack({ alignContent: Alignment.Bottom }) {
        Tabs({ barPosition: BarPosition.End, index: this.state.uiModel.currentTab }) {
          TabContent() { HomeViewBuilder() }
          TabContent() { TimerViewBuilder() }
          TabContent() { MineViewBuilder() }
        }
        .barHeight(0)
        .scrollable(false)
        .animationDuration(0)
        .onChange((index: number) => {
          this.viewModel.onTabSelected(index);
        })

        MainBottomNavBar({
          viewModel: this.viewModel
        })
      }
      .width('100%')
      .height('100%')
    }
    .mode(NavigationMode.Stack)
    .hideTitleBar(true)
    .hideToolBar(true)
    .hideBackButton(true)
  }
}