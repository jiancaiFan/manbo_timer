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

  private async openDialog() {
    const uiContext = this.getUIContext();
    const promptAction = uiContext.getPromptAction();

    const closeDialog = async () => {
      if (this.dialogContent !== null) {
        try {
          await promptAction.closeCustomDialog(this.dialogContent);
        } catch (error) {
          console.error("关闭弹窗失败:", JSON.stringify(error));
        }
        this.dialogContent = null;
      }
    };

    const params = new DialogParams();
    params.onClose = closeDialog;
    params.onConfirm = (project: ProjectItem) => {
      console.info("接收到新增项目:", project.projectName);
      closeDialog();
    };

    try {
      this.dialogContent = new ComponentContent(
        uiContext,
        wrapBuilder(buildNewCreateProjectDialog),
        params
      );

      await promptAction.openCustomDialog(this.dialogContent, {
        alignment: DialogAlignment.Bottom,
        maskColor: 'rgba(0,0,0,0.4)'
      });
    } catch (error) {
      console.error("打开弹窗失败:", JSON.stringify(error));
    }
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