@ComponentV2
export struct TodayMetricCard {
  @Param @Require icon: Resource
  @Param @Require iconBgColor: ResourceColor
  @Param @Require valueText: string
  @Param @Require unitText: string
  @Param @Require labelText: string

  build() {
    Column() {
      Row() {
        SymbolGlyph(this.icon)
          .fontSize(16)
          .fontColor([$r('sys.color.ohos_id_color_primary')])
      }
      .width(32)
      .height(32)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(this.iconBgColor)
      .borderRadius(14)

      Blank()
        .height(8)

      Column({ space: 2 }) {
        Row({ space: 1 }) {
          Text(this.valueText)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('sys.color.ohos_id_color_text_primary'))

          Text(this.unitText)
            .fontSize(8)
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.ohos_id_color_text_secondary'))
            .margin({ top: 8 })
        }
        .justifyContent(FlexAlign.Center)

        Text(this.labelText)
          .fontSize(8)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('sys.color.ohos_id_color_text_secondary'))
      }
      .alignItems(HorizontalAlign.Center)
    }
    .padding(8)
    .layoutWeight(1)
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor($r('sys.color.ohos_id_color_background'))
    .borderRadius(30)
    .translate({ x: 0, y: -2 })
    .shadow({
      radius: 20,
      color: $r('sys.color.sheet_mask_color'),
      offsetX: 0,
      offsetY: 10
    })
  }
}