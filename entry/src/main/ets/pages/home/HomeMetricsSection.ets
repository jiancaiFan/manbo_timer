import { TodayMetricCard } from "../../components/TodayMetricCard"
import { HomeState } from "../../redux/home/HomeState"

@ComponentV2
export struct HomeTodayMetricsSection {
  @Param @Require state: HomeState

  build() {
    Row({ space: 16 }) {
      TodayMetricCard({
        icon: $r('sys.symbol.timer_circle_fill'),
        iconBgColor: '#51deb872',
        valueText: this.state.uiModel.serviceHoursToday.toFixed(1),
        unitText: '时',
        labelText: '服务时长'
      })

      TodayMetricCard({
        icon: $r('sys.symbol.person_3_fill'),
        iconBgColor: '#34718cd6',
        valueText: this.state.uiModel.receptionsToday.toString().padStart(2, '0'),
        unitText: '人',
        labelText: '接待人数'
      })

      TodayMetricCard({
        icon: $r('sys.symbol.wallet_fill'),
        iconBgColor: '#436fdeab',
        valueText: this.state.uiModel.incomeToday.toFixed(2),
        unitText: '元',
        labelText: '今日收入'
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}