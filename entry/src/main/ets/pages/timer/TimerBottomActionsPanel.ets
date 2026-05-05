@ComponentV2
export struct TimerBottomActionsPanel {
  @Param isRunning: boolean = false;

  @Event onCancel: () => void = () => {};
  @Event onTogglePlayPause: () => void = () => {};
  @Event onFinish: () => void = () => {};
  @Event onAddExtraTime: (minutes: number) => void = () => {};

  build() {
    Column() {
      Column() {
        // 第一层：极简续时区域
        Row({ space: 12 }) {
          this.AddTimeButton(5)
          this.AddTimeButton(15)
          this.AddTimeButton(30)
        }
        .width('100%')
        .margin({ bottom: 20 })

        // 分隔线 - 极细感
        Divider()
          .strokeWidth(1)
          .color($r('sys.color.comp_divider')) // 系统分割线颜色
          .lineCap(LineCapStyle.Round)
          .margin({ bottom: 20 })

        Row() {
          Button({ type: ButtonType.Circle }) {
            SymbolGlyph($r('sys.symbol.xmark'))
              .fontSize(24)
              .fontColor(['#F43F5E']) // 还原 web 设计的 rose-500
              .fontWeight(FontWeight.Bold)
          }
          .width(64)
          .height(64)
          .backgroundColor($r('sys.color.comp_background_tertiary')) // 系统三级背景
          .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.95 })
          .onClick(() => this.onCancel())

          // 中间：核心播放/暂停控制
          Button({ type: ButtonType.Circle }) {
            SymbolGlyph(this.isRunning ? $r('sys.symbol.pause_fill') : $r('sys.symbol.play_fill'))
              .fontSize(32)
              // 图标颜色取系统背景色（浅色白，深色黑）
              .fontColor([$r('sys.color.background_primary')])
          }
          .width(80)
          .height(80)
          // 按钮背景取系统主文字色（浅色黑，深色白），形成高反差
          .backgroundColor($r('sys.color.font_primary'))
          .shadow(ShadowStyle.OUTER_DEFAULT_MD)
          .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.92 })
          .onClick(() => this.onTogglePlayPause())

          // 右侧：完成按钮
          Button({ type: ButtonType.Circle }) {
            SymbolGlyph($r('sys.symbol.checkmark'))
              .fontSize(24)
              .fontColor(['#10B981']) // 还原 web 设计的 emerald-500
              .fontWeight(FontWeight.Bold)
          }
          .width(64)
          .height(64)
          .backgroundColor($r('sys.color.comp_background_tertiary')) // 系统三级背景
          .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.95 })
          .onClick(() => this.onFinish())
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ left: 4, right: 4 })
      }
      .padding(20)
      .backgroundColor(Color.Transparent)
      .backgroundBlurStyle(BlurStyle.Thick) // 系统自带毛玻璃，自动适配深浅色
      .borderRadius(56)
      .border({ width: 1, color: $r('sys.color.comp_divider') }) // 系统边框色
      .shadow(ShadowStyle.OUTER_DEFAULT_LG) // 系统级阴影
    }
    .width('100%')
    .padding({ left: 16, right: 16, bottom: 96, top: 16 })
  }

  @Builder
  AddTimeButton(minutes: number) {
    Column() {
      Text('续时')
        .fontSize(9)
        .fontWeight(FontWeight.Bolder)
        .fontColor($r('sys.color.font_tertiary')) // 系统三级文字辅助色
        .letterSpacing(4)
        .margin({ bottom: 6 })
      Text(`+${minutes}分钟`)
        .fontSize(17)
        .fontWeight(FontWeight.Bolder)
        .fontColor($r('sys.color.font_primary')) // 系统主要文字色
        .letterSpacing(-0.5)
    }
    .layoutWeight(1)
    .padding({ top: 20, bottom: 20 })
    .backgroundColor($r('sys.color.comp_background_secondary')) // 系统二级背景
    .borderRadius(35)
    .border({ width: 1, color: $r('sys.color.comp_divider') })
    .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.95 })
    .onClick(() => this.onAddExtraTime(minutes))
  }
}