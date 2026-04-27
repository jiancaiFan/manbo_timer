import { ServiceMode } from "../model/home/HomeUIModel"

@ComponentV2
export struct ServiceStatusCapsule {
  @Param mode: ServiceMode = ServiceMode.IDLE

  build() {
    Row({ space: 8 }) {
      Circle()
        .width(8)
        .height(8)
        .fill(this.mode === ServiceMode.SERVING ? '#E5484D' : '#58B68A')

      Text(this.mode === ServiceMode.SERVING ? '服务中' : '空闲中')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.mode === ServiceMode.SERVING ? '#E5484D' : '#58B68A')
    }
    .padding({ left: 14, right: 14, top: 8, bottom: 8 })
    .backgroundColor(this.mode === ServiceMode.SERVING ? '#FDECEE' : '#E8F7EF')
    .borderRadius(999)
  }
}