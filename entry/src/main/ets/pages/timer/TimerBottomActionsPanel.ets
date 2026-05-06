import { curves } from "@kit.ArkUI";

@ComponentV2
export struct TimerBottomActionsPanel {
  @Param isRunning: boolean = false;
  @Event onCancel: () => void = () => {
  };
  @Event onTogglePlayPause: () => void = () => {
  };
  @Event onFinish: () => void = () => {
  };

  build() {
    Row() {
      Stack() {
        SymbolGlyph($r('sys.symbol.xmark'))
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .stateStyles({
            normal: {
              .fontColor(['#515154'])
            },
            pressed: {
              .fontColor(['#F97316'])
            }
          })
          .animation({ duration: 200, curve: Curve.FastOutSlowIn })
      }
      .width(64)
      .height(64)
      .borderRadius(32)
      .backgroundColor('#FAFAF9')
      .border({ width: 1, color: '#F4F4F5' })
      .shadow({ radius: 4, color: 'rgba(0,0,0,0.05)', offsetY: 2 })
      .stateStyles({
        normal: {
          .scale({ x: 1, y: 1 })
        },
        pressed: {
          .scale({ x: 0.95, y: 0.95 })
        }
      })
      .animation({ duration: 200, curve: Curve.Friction })
      .onClick(() => this.onCancel())

      Stack() {
        SymbolGlyph(this.isRunning ? $r('sys.symbol.pause_fill') : $r('sys.symbol.play_fill'))
          .fontSize(32)
          .fontColor(['#FFFFFF'])
      }
      .width(96)
      .height(80)
      .borderRadius(40)
      .backgroundColor('#1D1D1F')
      .shadow({ radius: 25, color: 'rgba(0,0,0,0.4)', offsetY: 15 })
      .stateStyles({
        normal: {
          .scale({ x: 1.1, y: 1.1 }).rotate({ angle: 0 })
        },
        pressed: {
          .scale({ x: 0.92, y: 0.92 }).rotate({ angle: -2 })
        }
      })
      .animation({ duration: 350, curve: curves.springMotion(0.4, 0.8) })
      .onClick(() => this.onTogglePlayPause())

      Stack() {
        SymbolGlyph($r('sys.symbol.checkmark_circle'))
          .fontSize(24)
          .fontWeight(FontWeight.Regular)
          .stateStyles({
            normal: {
              .fontColor(['#515154'])
            },
            pressed: {
              .fontColor(['#10B981'])
            }
          })
          .animation({ duration: 200, curve: Curve.FastOutSlowIn })
      }
      .width(64)
      .height(64)
      .borderRadius(32)
      .backgroundColor('#FAFAF9')
      .border({ width: 1, color: '#F4F4F5' })
      .shadow({ radius: 4, color: 'rgba(0,0,0,0.05)', offsetY: 2 })
      .stateStyles({
        normal: {
          .scale({ x: 1, y: 1 })
        },
        pressed: {
          .scale({ x: 0.95, y: 0.95 })
        }
      })
      .animation({ duration: 200, curve: Curve.Friction })
      .onClick(() => this.onFinish())
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding(12)
    .backgroundColor('rgba(255,255,255,0.85)')
    .backgroundBlurStyle(BlurStyle.Thick)
    .borderRadius(48)
    .border({ width: 1, color: 'rgba(255,255,255,0.5)' })
    .shadow({ radius: 30, color: 'rgba(0,0,0,0.08)', offsetY: 15 })
  }
}