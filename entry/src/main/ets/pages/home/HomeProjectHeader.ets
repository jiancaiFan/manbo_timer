@ComponentV2
export struct HomeProjectHeader {
  @Event onAddClick: () => void

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
      .width(40)
      .height(40)
      .backgroundColor($r('sys.color.background_primary'))
      .shadow({
        radius: 10,
        color: $r('sys.color.sheet_mask_color'),
        offsetX: 0,
        offsetY: 4
      })
      .onClick(() => {
        this.onAddClick()
      })
    }
    .width('100%')
    .height(LayoutPolicy.wrapContent).alignItems(VerticalAlign.Center)
  }
}