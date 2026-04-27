@ComponentV2
export struct HomeQuickStartCard {
  @Event onQuickStartClick: () => void

  build() {
    Row() {
      Column({ space: 8 }) {
        Row({ space: 8 }) {
          Circle()
            .width(8)
            .height(8)
            .fill('#C6AF86')

          Text('系统就绪')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.ohos_id_color_text_primary_contrary'))
            .opacity(0.90)
        }

        Text('快速开始服务计时')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('sys.color.ohos_id_color_text_primary_contrary'))

        Text('专注匠心服务 · 智能计时感应')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('sys.color.ohos_id_color_text_secondary_contrary'))
          .opacity(0.92)
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)
      .layoutWeight(1)

      Row() {
        SymbolGlyph($r('sys.symbol.timer'))
          .fontSize(28)
          .fontColor([$r('sys.color.ohos_id_color_text_primary_contrary')])
      }
      .width(68)
      .height(68)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#BDA57D')
      .borderRadius(34)
    }
    .width('100%')
    .padding({ top: 24, bottom: 24, left: 16, right: 16 })
    .borderRadius(26)
    .linearGradient({
      angle: 0,
      colors: [
        ['#1A1A1A', 0.00],
        ['#1C1C1C', 0.58],
        ['#23201D', 1.00]
      ]
    })

    // 悬浮关键：轻微上移
    .translate({ x: 0, y: -3 })

    // 悬浮关键：阴影做“更大更软”
    .shadow({
      radius: 24,
      color: '#30000000',
      offsetX: 0,
      offsetY: 14
    })

    .onClick(() => {
      this.onQuickStartClick();
    })
  }
}