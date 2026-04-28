import { curves } from '@kit.ArkUI';

@ComponentV2
export struct HomeProjectHeader {
  @Event onAddClick: () => void

  @Local isVisible: boolean = false;

  build() {
    Row() {
      Text('项目管理')
        .fontSize($r('sys.float.Title_S'))
        .fontWeight(FontWeight.Bold)
        .fontColor($r('sys.color.ohos_id_color_primary'))

      Blank()

      Button() {
        SymbolGlyph($r('sys.symbol.plus'))
          .fontSize($r('sys.float.ohos_id_text_size_body1'))
          .fontColor([$r('sys.color.ohos_id_color_text_primary')])
      }
      .type(ButtonType.Normal)
      .borderRadius(14)
      .width(40)
      .height(40)
      .backgroundColor($r('sys.color.background_primary'))
      .shadow({
        radius: 10,
        color: $r('sys.color.sheet_mask_color'),
        offsetX: 0,
        offsetY: 4
      })
      .stateStyles({
        normal: {
          .scale({ x: 1.0, y: 1.0 })
          .rotate({ angle: 0 })
        },
        pressed: {
          .scale({ x: 0.95, y: 0.95 })
          .rotate({ angle: 5 })
        }
      })
      .animation({ curve: curves.springMotion(0.3, 0.8) })
      .onClick(() => {
        this.onAddClick();
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .opacity(this.isVisible ? 1.0 : 0.0)
    .translate({ x: this.isVisible ? 0 : -16 })
    .onVisibleAreaChange([0.0, 1.0], (isVisible: boolean) => {
      if (isVisible) {
        // 【修复点】：使用 this.getUIContext().animateTo 代替全局 animateTo
        this.getUIContext().animateTo({ delay: 250, curve: curves.springMotion(0.4, 0.8) }, () => {
          this.isVisible = true;
        });
      } else {
        this.isVisible = false;
      }
    })
  }
}