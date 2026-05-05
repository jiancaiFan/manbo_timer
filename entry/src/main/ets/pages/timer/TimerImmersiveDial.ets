@ComponentV2
export struct TimerImmersiveDial {
  @Param @Require remainingTime: string = "00:00";
  @Param @Require totalTime: string = "00:00";
  @Param isRunning: boolean = false;
  @Local breathe: number = 0;
  @Local pulse: number = 0;

  build() {
    Column() {
      Stack() {
        Circle()
          .width('100%')
          .height('100%')
          .fill('rgba(14, 165, 233, 0.3)')
          .blur(40)
          .scale({ x: 0.8 + this.breathe * 0.25, y: 0.8 + this.breathe * 0.25 })
          .opacity(0.1 + this.breathe * 0.4)
          .animation({
            duration: 2000,
            curve: Curve.EaseInOut,
            iterations: -1,
            playMode: PlayMode.Alternate
          })

        Column() {
          Row() {
            Stack() {
              Circle()
                .width(8)
                .height(8)
                .fill('#0ea5e9') // 还原：专属海蓝色
                .scale({ x: 1 + this.pulse, y: 1 + this.pulse })
                .opacity(0.5 - this.pulse * 0.5)
                .animation({
                  duration: 1000,
                  curve: Curve.EaseOut,
                  iterations: -1,
                  playMode: PlayMode.Alternate
                })

              Circle().width(6).height(6).fill('#0ea5e9')
            }.width(8).height(8).margin({ right: 6 })

            Text(this.isRunning ? "理疗进行中" : "理疗已暂停")
              .fontSize(10)
              .fontWeight(FontWeight.Bolder)
              .fontColor('rgba(3, 105, 161, 0.8)') // 还原：特定透明度蓝色
              .letterSpacing(5)
              .textCase(TextCase.UpperCase)
          }
          .margin({ bottom: 20, top: 40 })
          .opacity(0.7 + this.breathe * 0.3)
          .animation({
            duration: 2000,
            curve: Curve.EaseInOut,
            iterations: -1,
            playMode: PlayMode.Alternate
          })

          Text(this.remainingTime)
            .fontSize(92)
            .lineHeight(92)
            .fontWeight(FontWeight.Lighter)
            .fontFamily('HarmonyOS Sans, monospace')
            .fontColor($r('sys.color.font_primary')) // 完美融合：主字号用系统一级文本色
            .letterSpacing(-2)
            .height(100)

          Row() {
            Stack() {
              Circle()
                .width(14)
                .height(14)
                .strokeWidth(2)
                .stroke('rgba(2, 132, 199, 0.4)')
                .fill('transparent')
              Polyline().points([[7, 4], [7, 7], [9, 9]]).strokeWidth(2).stroke('rgba(2, 132, 199, 0.4)')
            }.width(14).height(14).margin({ right: 14 })

            Divider().vertical(true).color('rgba(12, 74, 110, 0.1)').height(12).margin({ right: 14 })

            Text("目标时长")
              .fontSize(11)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('sys.color.font_secondary'))
              .letterSpacing(-0.5)
            Text(this.totalTime)
              .fontSize(11)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('sys.color.font_primary'))
              .margin({ left: 4 })
          }
          .margin({ top: 32 })
          .padding({ left: 28, right: 28, top: 12, bottom: 12 })
          .backgroundColor('rgba(255, 255, 255, 0.4)') // 还原：白色半透明胶囊
          .backgroundBlurStyle(BlurStyle.Thick)
          .clip(true)
          .borderRadius(16)
          .border({ width: 1, color: 'rgba(255, 255, 255, 0.6)' })

        }
        .width('100%')
        .height('100%')

      }
      .width(288)
      .height(288)
      .borderRadius(144)
      .clip(true)
      .backgroundColor('rgba(14, 165, 233, 0.1)')
      .backgroundBlurStyle(BlurStyle.Thin)
      .border({ width: 1, color: 'rgba(255, 255, 255, 0.5)' })
      .shadow({ radius: 30, color: 'rgba(14, 165, 233, 0.2)', offsetY: 15 })
    }
    .width('100%')
    .padding({ top: 16, bottom: 16 })
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .onVisibleAreaChange([0.0, 1.0], (isVisible: boolean) => {
      if (isVisible) {
        this.breathe = 1;
        this.pulse = 1;
      } else {
        this.breathe = 0;
        this.pulse = 0;
      }
    })
  }
}