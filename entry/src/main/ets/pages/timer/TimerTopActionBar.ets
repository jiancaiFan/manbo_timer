@ComponentV2
export struct TimerTopActionBar {
  @Param title: string = '实时服务看板';
  @Event onNavigateSettings: () => void = () => {};

  build() {
    Row() {
      Row()
        .width(44)
        .height(44)
      Text(this.title)
        .fontSize(17)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('sys.color.ohos_id_color_text_primary'))

      Button({ type: ButtonType.Circle }) {
        SymbolGlyph($r('sys.symbol.gearshape'))
          .fontSize(20)
          .fontColor([$r('sys.color.icon_primary')])
      }
      .width(44)
      .height(44)
      .backgroundColor($r('sys.color.ohos_id_color_card_bg'))
      .shadow(ShadowStyle.OUTER_DEFAULT_XS)
      .onClick(() => this.onNavigateSettings())
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor($r('sys.color.ohos_id_color_background_transparent'))
    .backdropBlur(30)
  }
}