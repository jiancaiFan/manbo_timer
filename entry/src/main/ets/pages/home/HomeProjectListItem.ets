import { ProjectItem, ProjectType } from "../../model/home/HomeUIModel";
import { curves } from "@kit.ArkUI";
import PermissionUtil from "../../utils/RequestPermissions";
import { GlobalContext } from "../../common/GlobalContext";
import { VibrationManager } from "../../utils/VibrationManager";

@ComponentV2
export struct HomeProjectListItem {
  @Param @Require item: ProjectItem;
  @Param index: number = 0;
  @Event onItemClicked: (item: ProjectItem) => void;

  @Local isPressed: boolean = false;
  @Local isVisible: boolean = false;

  private getThemeBg(): string {
    switch (this.item.projectType) {
      case ProjectType.MASSAGE: return '#FFFBEB';
      case ProjectType.GUA_SHA: return '#ECFDF5';
      case ProjectType.CUPPING: return '#FFF1F2';
      case ProjectType.THERAPY: return '#EFF6FF';
      default: return '#FFFBEB';
    }
  }

  private getThemeText(): string {
    switch (this.item.projectType) {
      case ProjectType.MASSAGE: return '#D97706';
      case ProjectType.GUA_SHA: return '#059669';
      case ProjectType.CUPPING: return '#E11D48';
      case ProjectType.THERAPY: return '#2563EB';
      default: return '#D97706';
    }
  }

  private getThemeIcon(): Resource {
    switch (this.item.projectType) {
      case ProjectType.MASSAGE: return $r('sys.symbol.bolt');
      case ProjectType.GUA_SHA: return $r('sys.symbol.waveform');
      case ProjectType.CUPPING: return $r('sys.symbol.target_ceremony');
      case ProjectType.THERAPY: return $r('sys.symbol.heart');
      default: return $r('sys.symbol.bolt');
    }
  }

  build() {
    Row() {
      Row() {
        SymbolGlyph(this.getThemeIcon())
          .fontColor([this.getThemeText()])
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
      }
      .width(64)
      .height(64)
      .borderRadius(28)
      .backgroundColor(this.getThemeBg())
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .flexShrink(0)
      .scale({ x: this.isPressed ? 1.05 : 1, y: this.isPressed ? 1.05 : 1 })
      .rotate({ angle: this.isPressed ? -3 : 0 })
      .animation({ duration: 500, curve: Curve.FastOutSlowIn })

      Column() {
        Text(this.item.projectName)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('sys.color.ohos_id_color_primary'))
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .letterSpacing(-0.5)
          .margin({ bottom: 6 })

        Row({ space: 8 }) {
          this.TagBuilder(`${this.item.projectTotalDuration}分钟`)
          this.TagBuilder(`${this.item.projectIntervalDuration}分钟提醒`)
        }
      }
      .flexShrink(1)
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 20, right: 20 })

      Column() {
        Text(`￥${this.item.projectAmount}`)
          .fontSize(19)
          .fontWeight(900)
          .fontColor($r('sys.color.ohos_id_color_primary'))
          .letterSpacing(-1)
          .lineHeight(19)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.End)

      Column()
        .width(4)
        .height(this.isPressed ? 48 : 32)
        .backgroundColor(this.getThemeText())
        .opacity(0.4)
        .borderRadius({ topRight: 99, bottomRight: 99 })
        .position({ x: 0, y: '50%' })
        .translate({ y: '-50%' })
        .animation({ duration: 500, curve: Curve.FastOutSlowIn })
    }
    .width('100%')
    .padding({ top: 16, bottom: 16, left: 16, right: 24 })
    .backgroundColor($r('sys.color.ohos_fa_list_card_bg'))
    .borderRadius(40)
    .shadow({
      radius: this.isPressed ? 15 : 30,
      color: this.isPressed ? 'rgba(0,0,0,0.12)' : 'rgba(0,0,0,0.08)',
      offsetX: 0,
      offsetY: this.isPressed ? 3 : 8
    })
    .animation({ duration: 500, curve: Curve.FastOutSlowIn })
    .clip(true)
    .opacity(this.isVisible ? 1.0 : 0.0)
    .translate({ y: this.isVisible ? 0 : 24 })
    .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.98 })
    .onTouch((event: TouchEvent) => {
      if (event.type === TouchType.Down) {
        this.isPressed = true;
      } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
        this.isPressed = false;
      }
    })
    .onClick( async  () => {
      try {
        let isGranted = await PermissionUtil.checkAndRequestNotification(GlobalContext.getInstance().getContext());
        if (isGranted) {
          VibrationManager.vibrateClick();
          this.onItemClicked(this.item);
        } else {
          this.getUIContext().getPromptAction().showToast({ message: '通知权限被拒绝，请在设置中开启！' });
        }
      } catch (error) {
        console.error(`Get context or request notification failed: ${JSON.stringify(error)}`);
      }
    })
    .onVisibleAreaChange([0.0, 0.01], (isAreaVisible: boolean, currentRatio: number) => {
      if (isAreaVisible && currentRatio >= 0.01) {

        let delayTime = this.index < 10 ? (650 + this.index * 100) : 0;

        this.getUIContext().animateTo({
          delay: delayTime,
          curve: curves.interpolatingSpring(0, 1, 220, 28)
        }, () => {
          this.isVisible = true;
        });
      } else if (!isAreaVisible && currentRatio <= 0.0) {
        this.isVisible = false;
      }
    })
  }

  @Builder
  private TagBuilder(text: string) {
    Row() {
      Text(text)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('sys.color.ohos_id_color_secondary'))
        .letterSpacing(-0.5)
    }
    .padding({ top: 4, bottom: 4, left: 10, right: 10 })
    .backgroundColor($r('sys.color.ohos_id_color_component_normal_transparent'))
    .border({ width: 1, color: $r('sys.color.comp_divider') })
    .borderRadius(999)
  }
}