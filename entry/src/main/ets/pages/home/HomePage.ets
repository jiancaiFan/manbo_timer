import { buildNewCreateProjectDialog, DialogParams } from "../../components/NewCreateProjectDialog";
import { ProjectItem } from "../../model/home/HomeUIModel";
import { HomeState } from "../../redux/home/HomeState";
import { HomeViewModel } from "../../viewmodel/HomeViewModel"
import { HomeTodayMetricsSection } from "./HomeMetricsSection";
import { HomeProjectHeader } from "./HomeProjectHeader";
import { HomeProjectList } from "./HomeProjectList";
import { HomeQuickStartCard } from "./HomeQuickStartCard";
import { HomeTopActionBar } from "./HomeTopActionBar";
import { ComponentContent } from "@kit.ArkUI";

@ComponentV2
struct HomePage {
  private viewModel: HomeViewModel = new HomeViewModel();
  private state: HomeState = this.viewModel.homeState;
  private dialogContent: ComponentContent<DialogParams> | null = null;

  openDialog() {
    const uiContext = this.getUIContext();
    const promptAction = uiContext.getPromptAction();

    const closeDialog = () => {
      if (this.dialogContent !== null) {
        promptAction.closeCustomDialog(this.dialogContent);
        this.dialogContent = null;
      }
    };

    const params = new DialogParams();
    params.onClose = closeDialog;
    params.onConfirm = (project: ProjectItem) => {
      console.info("接收到新增项目:", project.projectName);
      closeDialog();
    };

    this.dialogContent = new ComponentContent(
      uiContext,
      wrapBuilder(buildNewCreateProjectDialog),
      params
    );

    // 呼出系统原生对话框，完全适配 V2
    promptAction.openCustomDialog(this.dialogContent, {
      alignment: DialogAlignment.Bottom, // 从屏幕底部升起
      maskColor: 'rgba(0,0,0,0.4)',      // 灰色半透明遮罩
      autoCancel: true,                  // 允许点击遮罩关闭
      onWillDismiss: (dismissAction) => {
        // 允许通过物理返回键或点击遮罩关闭
        if (dismissAction.reason === DismissReason.TOUCH_OUTSIDE || dismissAction.reason === DismissReason.PRESS_BACK) {
          closeDialog();
        }
      }
    });
  }

  build() {
    Scroll() {
      Column({ space: 40 }) {
        HomeTopActionBar({
          mode: this.state.uiModel.serverMode
        })
        HomeTodayMetricsSection({ state: this.state })
        HomeQuickStartCard()
        HomeProjectHeader({
          onAddClick: () => {
            this.openDialog();
          }
        })
        HomeProjectList({
          state: this.state,
          onFetchProjectsClick: () => {
            this.viewModel.fetchHomeProjectList();
          }
        })
      }
      .width('100%')
      .padding({ right: 16, left: 16, bottom: 120 })
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
    .align(Alignment.Top)
    .edgeEffect(EdgeEffect.Spring)
  }
}

@Builder
export function HomeViewBuilder() {
  HomePage()
}