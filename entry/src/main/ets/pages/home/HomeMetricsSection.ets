import { TodayMetricCard } from "../../components/TodayMetricCard"
import { HomeState } from "../../redux/home/HomeState"

@ComponentV2
export struct HomeTodayMetricsSection {
  @Param @Require state: HomeState

  build() {
    Row({ space: 16 }) {
      TodayMetricCard({
        icon: $r('sys.symbol.timer'),
        iconBgColor: '#51deb872',
        valueText: this.state.uiModel.serviceHoursToday.toFixed(1),
        unitText: '时',
        labelText: '服务时长'
      })

      TodayMetricCard({
        icon: $r('sys.symbol.person_2'),
        iconBgColor: '#34718cd6',
        valueText: this.state.uiModel.receptionsToday.toString().padStart(2, '0'),
        unitText: '人',
        labelText: '接待人数'
      })

      TodayMetricCard({
        icon: $r('sys.symbol.star'),
        iconBgColor: '#436fdeab',
        valueText: this.state.uiModel.ratingToday.toFixed(1),
        unitText: '分',
        labelText: '综合评分'
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}