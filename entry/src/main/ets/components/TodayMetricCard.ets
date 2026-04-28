import { curves } from '@kit.ArkUI';

@ComponentV2
export struct TodayMetricCard {
  @Param @Require index: number
  @Param @Require icon: Resource
  @Param @Require iconBgColor: ResourceColor
  @Param @Require iconColor: ResourceColor
  @Param @Require valueText: string
  @Param @Require unitText: string
  @Param @Require labelText: string

  @Local isVisible: boolean = false;
  @Local isPressed: boolean = false;

  build() {
    Column() {
      // 1. 顶部图标
      Row() {
        SymbolGlyph(this.icon)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor([this.iconColor])
      }
      .width(32)
      .height(32)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(this.iconBgColor)
      .borderRadius(12)
      .margin({ bottom: 10 })

      // 2. 数据与单位同行
      Row({ space: 2 }) {
        Text(this.valueText)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('sys.color.ohos_id_color_text_primary'))
          .letterSpacing(-1)

        Text(this.unitText)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('sys.color.ohos_id_color_text_secondary'))
          .margin({ bottom: 2 })
      }
      .alignItems(VerticalAlign.Bottom)

      // 3. 底部标签
      Text(this.labelText)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('sys.color.ohos_id_color_text_secondary'))
        .letterSpacing(-0.5)
        .margin({ top: 2 })
    }
    .layoutWeight(1)
    .padding($r('sys.float.padding_level4'))
    .alignItems(HorizontalAlign.Center)
    .backgroundColor($r('sys.color.ohos_id_color_background'))
    .borderRadius(32)
    .border({ width: 1, color: 'rgba(0,0,0,0.03)' })
    .translate({
      x: 0,
      y: (this.isVisible ? 0 : 20) + (this.isPressed ? -4 : 0)
    })
    .scale({
      x: this.isVisible ? 1.0 : 0.92,
      y: this.isVisible ? 1.0 : 0.92
    })
    .opacity(this.isVisible ? 1.0 : 0.0)
    .shadow({
      radius: this.isPressed ? 30 : 20,
      color: this.isPressed ? 'rgba(0,0,0,0.05)' : 'rgba(0,0,0,0.02)',
      offsetX: 0,
      offsetY: this.isPressed ? 12 : 8
    })
    .onTouch((event: TouchEvent) => {
      if (event.type === TouchType.Down) {
        this.getUIContext().animateTo({ curve: curves.springMotion(0.3, 0.8) }, () => {
          this.isPressed = true;
        });
      } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
        this.getUIContext().animateTo({ curve: curves.springMotion(0.3, 0.8) }, () => {
          this.isPressed = false;
        });
      }
    })
    .onVisibleAreaChange([0.0, 0.3], (isAreaVisible: boolean) => {
      if (isAreaVisible) {
        this.getUIContext().animateTo({
          delay: 200 + (this.index * 80),
          curve: curves.springMotion(0.4, 0.8)
        }, () => {
          this.isVisible = true;
        });
      } else {
        this.isVisible = false;
      }
    })
  }
}