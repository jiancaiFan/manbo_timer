import { curves } from '@kit.ArkUI';
import { ServiceMode } from '../../model/home/HomeUIModel';

@ComponentV2
export struct HomeTopActionBar {

  @Param @Require mode: ServiceMode
  @Local isVisible: boolean = false;
  @Local dotScale: number = 1.0;
  @Local dotOpacity: number = 1.0;

  build() {
    Row() {
      Row({ space: 12 }) {
        Text('林 沐')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('sys.color.ohos_id_color_text_primary'))
          .letterSpacing(-1)
          .margin({ bottom: -2 })

        Row({ space: 6 }) {
          Circle()
            .width(6).height(6)
            .fill(this.mode === ServiceMode.SERVING ? '#E5484D' : '#58B68A')
            .scale({ x: this.dotScale, y: this.dotScale })
            .opacity(this.dotOpacity)
            .onAppear(() => {
              this.getUIContext().animateTo({
                duration: 1500,
                curve: Curve.EaseInOut,
                iterations: -1,
                playMode: PlayMode.Alternate
              }, () => {
                this.dotScale = 1.4;
                this.dotOpacity = 0.4;
              });
            })

          Text(this.mode === ServiceMode.SERVING ? '服务中' : '空闲中')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.mode === ServiceMode.SERVING ? '#E5484D' : '#58B68A')
            .letterSpacing(1)
        }
        .padding({ left: 10, right: 10, top: 4, bottom: 4 })
        .backgroundColor(this.mode === ServiceMode.SERVING ? '#FDECEE' : '#E8F7EF')
        .border({ width: 1, color: this.mode === ServiceMode.SERVING ? '#FCE8EB' : '#D1FAE5' })
        .borderRadius(20)
        .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })
        .stateStyles({
          normal: {
            .scale({ x: 1.0, y: 1.0 })
          },
          pressed: {
            .scale({ x: 0.92, y: 0.92 })
          }
        })
        .animation({ curve: curves.springMotion(0.3, 0.8) })
        .margin({ bottom: 2 })
      }
      .alignItems(VerticalAlign.Bottom)

      Stack() {
        Image('https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=200&auto=format&fit=crop')
          .width('100%')
          .height('100%')
          .objectFit(ImageFit.Cover)
          .borderRadius(21)
      }
      .width(48)
      .height(48)
      .padding(2)
      .backgroundColor(Color.White)
      .borderRadius(24)
      .border({ width: 1, color: 'rgba(0,0,0,0.05)' })
      .shadow({ radius: 15, color: 'rgba(0,0,0,0.1)', offsetY: 5 })
      .stateStyles({
        normal: {
          .scale({ x: 1.0, y: 1.0 })
          .rotate({ angle: 0 })
        },
        pressed: {
          .scale({ x: 1.1, y: 1.1 })
          .rotate({ angle: 5 })
        }
      })
      .animation({ curve: curves.springMotion(0.3, 0.8) })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Bottom)
    .opacity(this.isVisible ? 1.0 : 0.0)
    .translate({ x: 0, y: this.isVisible ? 0 : -24 })
    .onVisibleAreaChange([0.0, 0.3], (isAreaVisible: boolean) => {
      if (isAreaVisible) {
        this.getUIContext().animateTo({
          delay: 100,
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