@ComponentV2
struct HomePage{

  build() {
    Column() {
      Text('首页内容')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}

@Builder
export function HomeViewBuilder() {
  HomePage()
}