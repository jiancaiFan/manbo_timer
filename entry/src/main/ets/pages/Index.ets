import { MainPage } from './main/MainPage'

@Entry
@ComponentV2
struct Index {

  build() {
    Column() {
      MainPage()
    }.width(LayoutPolicy.matchParent)
  }
}