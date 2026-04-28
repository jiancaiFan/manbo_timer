import { TabItem } from "../../model/main/MainUIModel";
import { MainViewModel } from "../../viewmodel/MainViewModel";
import { curves } from "@kit.ArkUI";

@ComponentV2
export struct MainBottomNavBar {
  @Param @Require viewModel: MainViewModel;
  private state = this.viewModel.mainState;

  build() {
    Row() {
      ForEach(this.state.uiModel.tabList, (item: TabItem, index: number) => {
        Stack({ alignContent: Alignment.Center }) {
          if (this.state.uiModel.currentTab === index) {
            Stack()
              .width('100%')
              .height('100%')
              .backgroundColor('#1D1D1F')
              .borderRadius(9999)
              .shadow({ radius: 30, color: 'rgba(0,0,0,0.2)', offsetY: 15 })
              .transition(TransitionEffect.IDENTITY)
              .geometryTransition('activeNavBg')
          }

          Row({ space: 6 }) {
            SymbolGlyph(this.state.uiModel.currentTab === index ? item.selectedIcon : item.normalIcon)
              .fontSize(20)
              .fontWeight(this.state.uiModel.currentTab === index ? FontWeight.Bolder : FontWeight.Medium)
              .fontColor([this.state.uiModel.currentTab === index ? Color.White : 'rgba(29, 29, 31, 0.3)'])

            if (this.state.uiModel.currentTab === index) {
              Text(item.title)
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
                .letterSpacing(1.5)
                .transition(
                  TransitionEffect.OPACITY.combine(TransitionEffect.scale({ x: 0.9, y: 0.9 }))
                )
            }
          }
          .zIndex(1)
        }
        .height('100%')
        .layoutWeight(this.state.uiModel.currentTab === index ? 1.6 : 1)
        .onClick(() => {
          this.getUIContext().animateTo({
            curve: curves.springMotion(0.45, 0.8)
          }, () => {
            this.viewModel.onTabSelected(index);
          });
        })
      })
    }
    .width('calc(100% - 64px)')
    .height(68)
    .padding(8)
    .backgroundColor('rgba(255, 255, 255, 0.4)')
    .backdropBlur(45)
    .borderRadius(56)
    .border({ width: 1, color: 'rgba(255, 255, 255, 0.8)' })
    .shadow({ radius: 70, color: 'rgba(0,0,0,0.08)', offsetY: 30 })
  }
}