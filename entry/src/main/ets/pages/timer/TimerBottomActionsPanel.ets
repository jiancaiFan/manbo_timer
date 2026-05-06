import { curves } from "@kit.ArkUI";

@ComponentV2
export struct TimerBottomActionsPanel {
  @Param isRunning: boolean = false;
  @Event onCancel: () => void;
  @Event onTogglePlayPause: () => void;
  @Event onFinish: () => void;

  build() {
    Row() {
      Stack() {
        SymbolGlyph($r('sys.symbol.xmark'))
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(['#F43F5E'])
      }
      .width(64)
      .height(64)
      .borderRadius(28)
      .backgroundColor($r('sys.color.ohos_id_color_card_bg'))
      .border({ width: 1, color: 'rgba(0,0,0,0.01)' })
      .shadow({ radius: 40, color: 'rgba(0,0,0,0.1)', offsetY: 20 })
      .stateStyles({
        normal: {
          .scale({ x: 1, y: 1 })
        },
        pressed: {
          .scale({ x: 0.94, y: 0.94 })
        }
      })
      .animation({ duration: 300, curve: curves.springMotion(0.5, 0.8) })
      .onClick(() => this.onCancel())

      Stack() {
        SymbolGlyph(this.isRunning ? $r('sys.symbol.pause_fill') : $r('sys.symbol.play_fill'))
          .fontSize(28)
          .fontColor(['#1D1D1F'])
      }
      .width(64)
      .height(64)
      .borderRadius(28)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[$r('sys.color.ohos_id_color_card_bg'), 0], [$r('sys.color.ohos_id_color_card_bg_transparent'), 1]]
      })
      .border({ width: 1, color: 'rgba(0,0,0,0.005)' })
      .shadow({ radius: 40, color: 'rgba(0,0,0,0.15)', offsetY: 20 })
      .stateStyles({
        normal: {
          .scale({ x: 1, y: 1 })
        },
        pressed: {
          .scale({ x: 0.94, y: 0.94 })
        }
      })
      .animation({ duration: 300, curve: curves.springMotion(0.5, 0.8) })
      .onClick(() => this.onTogglePlayPause())

      Stack() {
        SymbolGlyph($r('sys.symbol.checkmark_circle'))
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(['#10B981'])
      }
      .width(64)
      .height(64)
      .borderRadius(28)
      .backgroundColor($r('sys.color.ohos_id_color_card_bg'))
      .border({ width: 1, color: 'rgba(0,0,0,0.01)' })
      .shadow({ radius: 40, color: 'rgba(0,0,0,0.1)', offsetY: 20 })
      .stateStyles({
        normal: {
          .scale({ x: 1, y: 1 })
        },
        pressed: {
          .scale({ x: 0.94, y: 0.94 })
        }
      })
      .animation({ duration: 300, curve: curves.springMotion(0.5, 0.8) })
      .onClick(() => this.onFinish())
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
  }
}