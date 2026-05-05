import { liveViewManager } from '@kit.LiveViewKit';
import { Want, wantAgent, WantAgent, common } from '@kit.AbilityKit';

export class CountdownLiveViewManager {
  private static readonly LIVE_VIEW_ID = 10086;
  private context: common.UIAbilityContext;

  constructor(context: common.UIAbilityContext) {
    this.context = context;
  }

  // 1. 启动实况窗
  public async startLiveView(projectName: string, remainingSeconds: number): Promise<void> {
    try {
      let isEnabled: boolean = await liveViewManager.isLiveViewEnabled();
      if (!isEnabled) {
        return;
      }
      let viewData: liveViewManager.LiveView = await this.buildTimerView(projectName, remainingSeconds, false);
      await liveViewManager.startLiveView(viewData);
    } catch (error) {
      console.error('CountdownLiveView start error');
    }
  }

  // 2. 暂停/恢复实况窗
  public async updateLiveView(projectName: string, remainingSeconds: number, isPaused: boolean): Promise<void> {
    try {
      let isEnabled: boolean = await liveViewManager.isLiveViewEnabled();
      if (!isEnabled) {
        return;
      }
      let viewData: liveViewManager.LiveView = await this.buildTimerView(projectName, remainingSeconds, isPaused);
      await liveViewManager.updateLiveView(viewData);
    } catch (error) {
      console.error('CountdownLiveView update error');
    }
  }

  // 3. 停止实况窗
  public async stopLiveView(): Promise<void> {
    try {
      let isEnabled: boolean = await liveViewManager.isLiveViewEnabled();
      if (!isEnabled) {
        return;
      }
      let viewData: liveViewManager.LiveView = await this.buildTimerView("结束", 0, true);
      await liveViewManager.stopLiveView(viewData);
    } catch (error) {
      console.error('CountdownLiveView stop error');
    }
  }

  // 构造实况窗请求体，严格对标官方 timer 规范
  private async buildTimerView(projectName: string, remainingSeconds: number,
    isPaused: boolean): Promise<liveViewManager.LiveView> {
    // 首先利用对象字面量完美构造基础视图，消除类型推导报错
    let view: liveViewManager.LiveView = {
      id: CountdownLiveViewManager.LIVE_VIEW_ID,
      event: "TIMER",
      timer: {
        time: remainingSeconds * 1000, // 鸿蒙原生 timer 需要毫秒
        isCountdown: true, // 开启倒计时模式
        isPaused: isPaused             // 是否暂停
      },
      liveViewData: {
        primary: {
          title: projectName,
          content: [
            { text: "剩余时间 " },
            // 原生占位符：系统会自动接管跳秒
            { text: "${placeholder.timer}", textColor: "#FFFF0000" }
          ]
        }
      }
    };

    // 规范的 try...catch 拦截异常，消除 throws 警告
    try {
      let targetWant: Want = {
        bundleName: this.context.abilityInfo.bundleName,
        abilityName: this.context.abilityInfo.name
      };

      let wantAgentInfo: wantAgent.WantAgentInfo = {
        wants: [targetWant],
        operationType: wantAgent.OperationType.START_ABILITY,
        requestCode: 0,
        wantAgentFlags: [wantAgent.WantAgentFlags.UPDATE_PRESENT_FLAG]
      };

      let agent: WantAgent = await wantAgent.getWantAgent(wantAgentInfo);

      // 创建成功后，再动态挂载到点击事件上
      view.liveViewData.primary.clickAction = agent;
    } catch (error) {
      console.error('CountdownLiveView buildWantAgent error');
    }

    return view;
  }
}