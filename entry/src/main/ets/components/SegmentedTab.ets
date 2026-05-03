import { curves } from "@kit.ArkUI";

@ComponentV2
export struct SegmentedTab {
  @Param tabs: string[] = [];
  @Param selectedIndex: number = 0;
  @Event selectedIndexChange: (index: number) => void = () => {
  };

  build() {
    Row() {
      Stack({ alignContent: Alignment.TopStart }) {
        // 底层滑动高亮白块 (带轻微阴影)
        Row()
          .width(`${100 / this.tabs.length}%`)
          .height('100%')
          .backgroundColor($r('sys.color.comp_background_list_card'))
          .borderRadius(12)
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.05)', offsetY: 2 })
          .position({ x: `${this.selectedIndex * (100 / this.tabs.length)}%`, y: 0 })
          .animation({ duration: 300, curve: curves.springMotion(0.35, 0.8) })

        // 表层文字
        Row() {
          ForEach(this.tabs, (type: string, index: number) => {
            Text(type)
              .width(`${100 / this.tabs.length}%`)
              .height('100%')
              .textAlign(TextAlign.Center)
              .fontSize(13)
              .fontWeight(FontWeight.Bolder)
              .fontColor(this.selectedIndex === index ? "#000000" : 'rgba(0,0,0,0.4)')
              .animation({ duration: 200 })
              .onClick(() => this.selectedIndexChange(index))
          })
        }.width('100%').height('100%')
      }.width('100%').height(44)
    }
    .width('100%')
    .padding(4)
    .backgroundColor('rgba(0,0,0,0.05)')
    .borderRadius(16)
  }
}