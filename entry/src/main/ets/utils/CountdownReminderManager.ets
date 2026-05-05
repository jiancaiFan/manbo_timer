import { reminderAgentManager } from '@kit.BackgroundTasksKit';

export class CountdownReminderManager {
  private reminderIds: number[] = [];

  // 一次性注册所有需要的间隔提醒和结束提醒
  public async scheduleReminders(remainingSeconds: number, intervalSeconds: number,
    projectName: string): Promise<void> {
    await this.cancelAll(); // 注册新任务前先清理旧任务

    try {
      let count = Math.floor(remainingSeconds / intervalSeconds);

      // 1. 循环注册每一个“间隔提醒”
      for (let i = 1; i <= count; i++) {
        let triggerSeconds = remainingSeconds - (remainingSeconds - i * intervalSeconds);
        let remainMin = Math.floor((remainingSeconds - triggerSeconds) / 60);

        if (triggerSeconds > 0 && triggerSeconds < remainingSeconds) {
          let reqTimer: reminderAgentManager.ReminderRequestTimer = {
            reminderType: reminderAgentManager.ReminderType.REMINDER_TYPE_TIMER,
            triggerTimeInSeconds: triggerSeconds, // 多少秒后触发
            title: '间隔提醒',
            content: `${projectName} 还剩 ${remainMin} 分钟`,
            ringDuration: 3 // 系统会自动播放 3 秒铃声
          };
          let id = await reminderAgentManager.publishReminder(reqTimer);
          this.reminderIds.push(id);
        }
      }

      // 2. 注册最终的“倒计时结束提醒”
      if (remainingSeconds > 0) {
        let reqFinish: reminderAgentManager.ReminderRequestTimer = {
          reminderType: reminderAgentManager.ReminderType.REMINDER_TYPE_TIMER,
          triggerTimeInSeconds: remainingSeconds,
          title: '倒计时结束',
          content: `${projectName} 已完成`,
          ringDuration: 5
        };
        let finishId = await reminderAgentManager.publishReminder(reqFinish);
        this.reminderIds.push(finishId);
      }
    } catch (error) {
      console.error(`CountdownReminderManager error`);
    }
  }

  // 清除所有已注册的系统提醒，防止取消任务后系统依然瞎叫
  public async cancelAll(): Promise<void> {
    for (let id of this.reminderIds) {
      try {
        await reminderAgentManager.cancelReminder(id);
      } catch (error) {
        // 静默忽略清理失败
      }
    }
    this.reminderIds = [];
  }
}