import { curves } from '@kit.ArkUI';
import { TodayMetricCard } from "../../components/TodayMetricCard"
import { HomeState } from "../../redux/home/HomeState"

@ComponentV2
export struct HomeTodayMetricsSection {
  @Param @Require state: HomeState

  @Local isGroupLifted: boolean = false;

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
    // 利用三元表达式优雅控制状态： Lifted 时 -12，否则 0
    .translate({ y: this.isGroupLifted ? -12 : 0 })
    .onVisibleAreaChange([0.0, 0.3], (isAreaVisible: boolean) => {
      if (isAreaVisible) {
        // 直接使用 animateTo 的 delay 属性，完美替代 setTimeout
        this.getUIContext().animateTo({
          delay: 700, // 等待子组件 700ms
          curve: curves.springMotion(0.35, 0.8)
        }, () => {
          this.isGroupLifted = true;
        });
      } else {
        // 滑出屏幕时，直接修改状态，瞬间重置位置，无需清理定时器
        this.isGroupLifted = false;
      }
    })
  }
}