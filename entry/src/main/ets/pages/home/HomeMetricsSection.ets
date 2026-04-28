import { TodayMetricCard } from "../../components/TodayMetricCard"
import { HomeState } from "../../redux/home/HomeState"

@ComponentV2
export struct HomeTodayMetricsSection {
  @Param @Require state: HomeState

  build() {
    Row({ space: 12 }) {
      TodayMetricCard({
        index: 0,
        icon: $r('sys.symbol.timer'),
        iconBgColor: 'rgba(254, 243, 199, 0.5)',
        iconColor: '#D97706',
        valueText: this.state.uiModel.serviceHoursToday.toFixed(1),
        unitText: '时',
        labelText: '服务时长'
      })

      TodayMetricCard({
        index: 1,
        icon: $r('sys.symbol.person_3_fill'),
        iconBgColor: 'rgba(219, 234, 254, 0.5)',
        iconColor: '#2563EB',
        valueText: this.state.uiModel.receptionsToday.toString().padStart(2, '0'),
        unitText: '人',
        labelText: '接待人数'
      })

      TodayMetricCard({
        index: 2,
        icon: $r('sys.symbol.wallet_fill'),
        iconBgColor: 'rgba(209, 250, 229, 0.5)',
        iconColor: '#059669',
        valueText: this.state.uiModel.incomeToday.toFixed(2),
        unitText: '元',
        labelText: '预计收入'
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}