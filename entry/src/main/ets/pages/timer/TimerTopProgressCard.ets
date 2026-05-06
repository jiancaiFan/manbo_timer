import { curves } from '@kit.ArkUI';

@ComponentV2
export struct TimerTopProgressCard {
  @Param projectName: string = "深度穴位点按";
  @Param statusText: string = "正进行";
  @Param progress: number = 65;

  @Local isVisible: boolean = false;
  @Local currentWidth: number = 0;

  @Monitor("progress")
  onProgressChange() {
    this.getUIContext()?.animateTo({ duration: 1000, curve: Curve.Linear }, () => {
      this.currentWidth = this.progress;
    });
  }

  build() {
    Row({ space: 14 }) {
      Stack({ alignContent: Alignment.Center }) {
        SymbolGlyph($r('sys.symbol.bolt'))
          .fontSize(20)
          .fontColor(['rgba(255,255,255,0.9)'])
          .fontWeight(FontWeight.Medium)
      }
      .width(44)
      .height(44)
      .backgroundColor('#1D1D1F')
      .borderRadius(19.2)
      .shadow({ radius: 20, color: 'rgba(0,0,0,0.2)', offsetY: 10 })

      Column() {
        Row() {
          Text(this.projectName)
            .fontSize(14)
            .fontWeight(FontWeight.Bolder)
            .fontColor('#1D1D1F')
            .letterSpacing(-0.5)

          Text(this.statusText)
            .fontSize(9)
            .fontWeight(FontWeight.Bolder)
            .fontColor('#000000')
            .letterSpacing(1)
            .backgroundColor('rgba(0,0,0,0.05)')
            .padding({ left: 8, right: 8, top: 2, bottom: 2 })
            .borderRadius(10)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Bottom)
        .margin({ bottom: 8 })

        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(6)
            .backgroundColor('rgba(244,244,245,0.5)')
            .borderRadius(3)

          Row()
            .width(`${Math.min(Math.max(this.currentWidth, 0), 100)}%`)
            .height(6)
            .borderRadius(3)
            .linearGradient({
              direction: GradientDirection.Right,
              colors: [['#1D1D1F', 0.0], ['#424245', 1.0]]
            })
        }
        .width('100%')
      }
      .layoutWeight(1)
      .padding({ right: 2 })
    }
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(45)
    .shadow({ radius: 35, color: 'rgba(0,0,0,0.03)', offsetY: 15 })
    .opacity(this.isVisible ? 1.0 : 0.0)
    .translate({ y: this.isVisible ? 0 : 40 })
    // 【核心规范】：利用可见区域变化触发真正的入场渲染动画
    .onVisibleAreaChange([0.0, 1.0], (isAreaVisible: boolean) => {
      if (isAreaVisible) {
        let uiContext = this.getUIContext();

        // 1. 卡片整体上浮入场动画
        uiContext?.animateTo({ duration: 800, curve: curves.springMotion(0.4, 0.8) }, () => {
          this.isVisible = true;
        });

        uiContext?.animateTo({ delay: 150, duration: 1200, curve: Curve.Linear }, () => {
          this.currentWidth = this.progress;
        });
      } else {
        this.isVisible = false;
        this.currentWidth = 0;
      }
    })
  }
}