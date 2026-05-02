import { curves } from '@kit.ArkUI';

@ComponentV2
export struct HomeQuickStartCard {
  @Event onQuickStartClick: () => void

  @Local isPressed: boolean = false;
  @Local dotOpacity: number = 1.0;

  @Local isVisible: boolean = false;

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Row()
        .width('100%')
        .height(LayoutPolicy.wrapContent)
        .position({ x: 0, y: 0 })
        .borderRadius(26)
        .linearGradient({ angle: 90, colors: [['#33C5A059', 0.0], ['#00C5A059', 1.0]] })
        .blur(24)
        .opacity(this.isPressed ? 1.0 : 0.0)
        .scale({ x: this.isPressed ? 1.03 : 1.0, y: this.isPressed ? 1.05 : 1.0 })
        .animation({ duration: 500, curve: Curve.EaseInOut })
        .hitTestBehavior(HitTestMode.None)

      Stack() {
        Row() {
          Column({ space: 8 }) {
            Row({ space: 8 }) {
              Circle()
                .width(6).height(6).fill('#C5A059')
                .opacity(this.dotOpacity)
                .shadow({ radius: 10, color: '#C5A059', offsetX: 0, offsetY: 0 })
                .animation({ duration: 1200, curve: Curve.EaseInOut, iterations: -1, playMode: PlayMode.Alternate })

              Text('系统就绪')
                .fontSize(10).fontWeight(FontWeight.Bold).letterSpacing(3)
                .fontColor($r('sys.color.ohos_id_color_text_primary_contrary')).opacity(0.80)
            }

            Text('快速开始服务计时')
              .fontSize(16).fontWeight(FontWeight.Bold).letterSpacing(2)
              .fontColor($r('sys.color.ohos_id_color_text_primary_contrary'))

            Text('专注匠心服务 · 智能计时感应')
              .fontSize(11).fontWeight(FontWeight.Medium).letterSpacing(1)
              .fontColor($r('sys.color.ohos_id_color_text_secondary_contrary')).opacity(0.50)
          }
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.Center)
          .layoutWeight(1)

          Row() {
            SymbolGlyph($r('sys.symbol.timer')).fontSize(24).fontColor([Color.White])
          }
          .width(56).height(56)
          .justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
          .borderRadius(22)
          .linearGradient({ angle: 135, colors: [['#C5A059', 0.0], ['#AD8B45', 1.0]] })
          .shadow({ radius: 20, color: this.isPressed ? '#80C5A059' : '#4DC5A059', offsetX: 0, offsetY: 10 })
          .scale({ x: this.isPressed ? 1.05 : 1.0, y: this.isPressed ? 1.05 : 1.0 })
          .animation({ curve: curves.springMotion(0.4, 0.8) })
        }
        .width('100%')
        .padding({ top: 20, bottom: 20, left: 20, right: 20 })
        .zIndex(2)

        Circle()
          .width(128).height(128).fill('#C5A059')
          .opacity(0.1).blur(60)
          .position({ x: '100%', y: 0 })
          .markAnchor({ x: 100, y: 30 })
          .hitTestBehavior(HitTestMode.None)
          .zIndex(1)
      }
      .clip(true)
      .width('100%')
      .borderRadius(26)
      .linearGradient({ angle: 0, colors: [['#1A1A1A', 0.00], ['#1C1C1C', 0.58], ['#23201D', 1.00]] })
      .border({ width: 1, color: '#1AFFFFFF' })
      .shadow({ radius: 30, color: '#73000000', offsetX: 0, offsetY: this.isPressed ? 8 : 15 })
      .scale({ x: this.isPressed ? 0.98 : 1.0, y: this.isPressed ? 0.98 : 1.0 })
      .animation({ curve: curves.springMotion(0.3, 0.8) })
    }
    .width('100%')
    .opacity(this.isVisible ? 1.0 : 0.0)
    .translate({ x: 0, y: this.isVisible ? -8 : 30 })
    .scale({ x: this.isVisible ? 1.0 : 0.98, y: this.isVisible ? 1.0 : 0.98 })
    .onTouch((event: TouchEvent) => {
      if (event.type === TouchType.Down) {
        this.isPressed = true;
      } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
        this.isPressed = false;
        if (event.type === TouchType.Up) this.onQuickStartClick();
      }
    })
    .onVisibleAreaChange([0.0, 1.0], (isAreaVisible: boolean) => {
      if (isAreaVisible) {
        this.dotOpacity = 0.3;
        this.getUIContext().animateTo({ delay: 450, curve: curves.springMotion(0.4, 0.8) }, () => {
          this.isVisible = true;
        });
      } else {
        this.isVisible = false;
      }
    })
  }
}