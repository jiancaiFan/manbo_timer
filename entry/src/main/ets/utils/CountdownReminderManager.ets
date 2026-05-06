import { reminderAgentManager } from '@kit.BackgroundTasksKit';

export class CountdownReminderManager {
  private reminderIds: number[] = [];

  public async scheduleReminders(remainingSeconds: number, intervalSeconds: number,
    projectName: string): Promise<void> {
    await this.cancelAll(); // 注册新任务前先清理旧任务和底层残留

    try {
      let count = Math.floor(remainingSeconds / intervalSeconds);

      for (let i = 1; i <= count; i++) {
        let targetRemaining = i * intervalSeconds;

        if (targetRemaining === remainingSeconds) {
          continue;
        }

        let triggerSeconds = remainingSeconds - targetRemaining;
        let remainMin = Math.floor(targetRemaining / 60);

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

  public async cancelAll(): Promise<void> {
    try {
      this.reminderIds = [];

      await reminderAgentManager.cancelAllReminders();

    } catch (error) {
      console.error(`CountdownReminderManager cancelAll error`);
    }
  }
}