@ComponentV2
struct TimerPage {

  build() {
    Column() {
      Text('发现内容')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}

@Builder
export function TimerViewBuilder() {
  TimerPage()
}