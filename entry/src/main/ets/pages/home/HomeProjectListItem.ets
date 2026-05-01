import { ProjectItem, ProjectType } from "../../model/home/HomeUIModel";
import { curves } from "@kit.ArkUI";

@ComponentV2
export struct HomeProjectListItem {
  @Param @Require item: ProjectItem;
  @Param @Require index: number;
  @Param @Require isAppeared: boolean;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row() {
        Stack() {
          SymbolGlyph(
            this.item.projectType === ProjectType.GUA_SHA ? $r('sys.symbol.waveform') :
              this.item.projectType === ProjectType.CUPPING ? $r('sys.symbol.target_ceremony') :
                this.item.projectType === ProjectType.FOOT_SPA ? $r('sys.symbol.heart') :
                  $r('sys.symbol.bolt') // 默认 MASSAGE
          )
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            // 【直接写在具体位置】：文字颜色判断
            .fontColor([
              this.item.projectType === ProjectType.GUA_SHA ? '#059669' :
                this.item.projectType === ProjectType.CUPPING ? '#E11D48' :
                  this.item.projectType === ProjectType.FOOT_SPA ? '#2563EB' :
                    '#D97706'
            ])
        }
        .width(64)
        .height(64)
        // 【直接写在具体位置】：背景颜色判断
        .backgroundColor(
          this.item.projectType === ProjectType.GUA_SHA ? '#ECFDF5' :
            this.item.projectType === ProjectType.CUPPING ? '#FFF1F2' :
              this.item.projectType === ProjectType.FOOT_SPA ? '#EFF6FF' :
                '#FFFBEB'
        )
        .borderRadius(28)

        // 中间文字信息
        Column() {
          Text(this.item.projectName)
            .fontSize(17)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .letterSpacing(-0.5)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .margin({ bottom: 6 })

          Row({ space: 8 }) {
            Text(`${this.item.projectTotalDuration}分钟`)
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor('rgba(0,0,0,0.4)')
              .padding({
                left: 10,
                right: 10,
                top: 4,
                bottom: 4
              })
              .backgroundColor('rgba(0,0,0,0.03)')
              .borderRadius(999)
              .border({ width: 1, color: 'rgba(0,0,0,0.02)' })

            Text(`${this.item.projectIntervalDuration}分钟提醒`)
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor('rgba(0,0,0,0.4)')
              .padding({
                left: 10,
                right: 10,
                top: 4,
                bottom: 4
              })
              .backgroundColor('rgba(0,0,0,0.03)')
              .borderRadius(999)
              .border({ width: 1, color: 'rgba(0,0,0,0.02)' })
          }
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 20, right: 8 })

        // 右侧价格
        Text(`￥${this.item.projectAmount}`)
          .fontSize(19)
          .fontWeight(FontWeight.Bolder)
          .fontColor(Color.Black)
          .letterSpacing(-1)
      }
      .width('100%')
      .padding({
        left: 16,
        right: 24,
        top: 16,
        bottom: 16
      })
      .backgroundColor(Color.White)
      .borderRadius(40)
      .border({ width: 1, color: 'rgba(0,0,0,0.03)' })
      .shadow({ radius: 24, color: 'rgba(0,0,0,0.015)', offsetY: 4 })

      // 左侧彩色饰边
      Stack()
        .width(4)
        .height(32)
        // 【直接写在具体位置】：饰边颜色同文字颜色
        .backgroundColor(
          this.item.projectType === ProjectType.GUA_SHA ? '#059669' :
            this.item.projectType === ProjectType.CUPPING ? '#E11D48' :
              this.item.projectType === ProjectType.FOOT_SPA ? '#2563EB' :
                '#D97706'
        )
        .opacity(0.4)
        .borderRadius({ topRight: 999, bottomRight: 999 })
    }
    .width('100%')
    .stateStyles({
      normal: {
        .scale({ x: 1.0, y: 1.0 })
      },
      pressed: {
        .scale({ x: 0.98, y: 0.98 })
      }
    })
    .animation({ curve: curves.springMotion(0.4, 0.8) })
    .opacity(this.isAppeared ? 1 : 0)
    .translate({ x: 0, y: this.isAppeared ? 0 : 24 })
    .animation({
      delay: this.index * 100,
      curve: curves.springMotion(0.5, 0.8)
    })
  }
}