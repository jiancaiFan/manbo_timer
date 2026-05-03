import { curves } from "@kit.ArkUI";
import { ProjectItem, ProjectType } from "../model/home/HomeUIModel";
import { FormInputRow } from "./FormInputRow";
import { SegmentedTab } from "./SegmentedTab";

const TYPES = ["按摩", "刮痧", "拔罐", "理疗"];
const TYPE_MAP: Record<string, ProjectType> = {
  "按摩": ProjectType.MASSAGE,
  "刮痧": ProjectType.GUA_SHA,
  "拔罐": ProjectType.CUPPING,
  "理疗": ProjectType.THERAPY
};

@ComponentV2
export struct NewCreateProjectDialog {
  @Event onClose: () => void = () => {
  };
  @Event onConfirm: (project: ProjectItem) => void = () => {
  };
  @Local selectedIndex: number = 0;
  @Local projectName: string = "";
  @Local projectPrice: string = "";
  @Local projectDuration: string = "";
  @Local projectInterval: string = "";
  @Local isCloseBtnPressed: boolean = false;
  @Local isSubmitPressed: boolean = false;
  @Local isVisible: boolean = false;

  build() {
    // ArkTS 严格模式：build() 内不能有任何变量声明，直接写 UI 组件
    Stack({ alignContent: Alignment.Top }) {
      Column() {
        this.Header()

        SegmentedTab({
          tabs: TYPES,
          selectedIndex: this.selectedIndex,
          selectedIndexChange: (index: number) => {
            this.selectedIndex = index;
          }
        })
          .margin({ bottom: 24 })
          .opacity(this.isVisible ? 1 : 0)
          .translate({ y: this.isVisible ? 0 : 20 })
          // Delay: 100ms
          .animation({ curve: curves.springMotion(0.6, 0.8), delay: 100 })

        Column({ space: 16 }) {
          Stack() {
            FormInputRow({
              label: "项目名称",
              placeholder: "请输入服务名称",
              value: this.projectName,
              valueChange: (v) => this.projectName = v
            })
          }
          .opacity(this.isVisible ? 1 : 0).translate({ y: this.isVisible ? 0 : 20 })
          .animation({ curve: curves.springMotion(0.6, 0.8), delay: 100 })

          Stack() {
            FormInputRow({
              label: "项目价格",
              placeholder: "0.00",
              value: this.projectPrice,
              valueChange: (v) => this.projectPrice = v,
              inputType: InputType.NUMBER_DECIMAL
            })
          }
          .opacity(this.isVisible ? 1 : 0).translate({ y: this.isVisible ? 0 : 20 })
          .animation({ curve: curves.springMotion(0.6, 0.8), delay: 150 })

          Stack() {
            FormInputRow({
              label: "服务时长",
              placeholder: "分钟",
              value: this.projectDuration,
              valueChange: (v) => this.projectDuration = v,
              inputType: InputType.Number
            })
          }
          .opacity(this.isVisible ? 1 : 0).translate({ y: this.isVisible ? 0 : 20 })
          .animation({ curve: curves.springMotion(0.6, 0.8), delay: 200 })

          Stack() {
            FormInputRow({
              label: "提醒间隔",
              placeholder: "分钟",
              value: this.projectInterval,
              valueChange: (v) => this.projectInterval = v,
              inputType: InputType.Number
            })
          }
          .opacity(this.isVisible ? 1 : 0).translate({ y: this.isVisible ? 0 : 20 })
          .animation({ curve: curves.springMotion(0.6, 0.8), delay: 250 })
        }.margin({ bottom: 32 })

        // 给包裹按钮的 Stack 添加出场动画，内部 Button ��责点击缩放
        Stack() {
          Button({ type: ButtonType.Normal }) {
            Text("确认添加")
              .fontColor($r('sys.color.comp_background_list_card'))
              .fontSize(16)
              .fontWeight(FontWeight.Bolder)
              .letterSpacing(2)
          }
          .width('100%')
          .height(64)
          .backgroundColor($r('sys.color.black'))
          .borderRadius(32)
          .shadow({ radius: 24, color: 'rgba(0,0,0,0.2)', offsetY: 12 })
          .scale({ x: this.isSubmitPressed ? 0.96 : 1, y: this.isSubmitPressed ? 0.96 : 1 })
          .animation({ curve: curves.springMotion(0.3, 0.6) })
          .onTouch((e) => this.isSubmitPressed = (e.type === TouchType.Down))
          .onClick(() => this.handleSubmit())
        }
        .opacity(this.isVisible ? 1 : 0)
        .translate({ y: this.isVisible ? 0 : 20 })
        .animation({ curve: curves.springMotion(0.6, 0.8), delay: 500 })

      }
      .padding({
        left: 36,
        right: 36,
        top: 36,
        bottom: 40
      })

      Row()
        .width(36)
        .height(4)
        .backgroundColor('rgba(0,0,0,0.1)')
        .borderRadius(2)
        .margin({ top: 12 })
    }
    .width('100%')
    .backgroundColor('rgba(255, 255, 255, 0.95)')
    .backgroundBlurStyle(BlurStyle.Thick)
    .borderRadius({ topLeft: 44, topRight: 44 })
    .border({ width: { top: 1 }, color: 'rgba(255, 255, 255, 0.6)' })
    .shadow({ radius: 80, color: 'rgba(0,0,0,0.15)', offsetY: -15 })
    .onVisibleAreaChange([0.0, 1.0], (isAreaVisible: boolean) => {
      this.isVisible = isAreaVisible;
    })
  }

  @Builder
  Header() {
    Row() {
      Column() {
        Text("添加项目").fontSize(26).fontWeight(FontWeight.Bolder).fontColor($r('sys.color.black')).letterSpacing(-1)
        Row() {
          Circle({ width: 6, height: 6 }).fill('rgba(0,0,0,0.2)').margin({ right: 8 })
          Text("请填写项目详细信息")
            .fontSize(10)
            .fontWeight(FontWeight.Bolder)
            .fontColor('rgba(0,0,0,0.4)')
            .letterSpacing(2)
            .textCase(TextCase.UpperCase)
        }.margin({ top: 4 })
      }.alignItems(HorizontalAlign.Start)

      // 修复：使用标准的关闭图标
      Row() {
        Image($r('sys.media.ohos_ic_public_cancel'))
          .width(20)
          .height(20)
          .fillColor($r('sys.color.black'))
      }
      .width(40)
      .height(40)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('rgba(0,0,0,0.05)')
      .borderRadius(20)
      .shadow({ radius: 2, color: 'rgba(0,0,0,0.05)', offsetY: 1 })
      .scale({ x: this.isCloseBtnPressed ? 0.9 : 1, y: this.isCloseBtnPressed ? 0.9 : 1 })
      .rotate({ angle: this.isCloseBtnPressed ? 90 : 0 })
      .animation({ curve: curves.springMotion(0.4, 0.6) })
      .onTouch((e) => this.isCloseBtnPressed = (e.type === TouchType.Down))
      .onClick(() => this.onClose())
    }
    .width('100%').justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Top).margin({ bottom: 40 })
  }

  handleSubmit() {
    const typeStr = TYPES[this.selectedIndex];
    const newItem = new ProjectItem(
      this.projectName, TYPE_MAP[typeStr] ?? ProjectType.MASSAGE,
      Number(this.projectDuration) || 0, Number(this.projectInterval) || 0, Number(this.projectPrice) || 0
    );
    this.onConfirm(newItem);
  }
}

export class DialogParams {
  onClose: () => void = () => {
  };
  onConfirm: (project: ProjectItem) => void = () => {
  };
}

@Builder
export function buildNewCreateProjectDialog(params: DialogParams) {
  NewCreateProjectDialog({
    onClose: params.onClose,
    onConfirm: params.onConfirm
  })
}