import { vibrator } from '@kit.SensorServiceKit';

export class VibrationManager {

  /**
   * 模式一：倒计时/闹钟提醒振动 (按时长控制)
   * 适用场景：倒计时到达间隔时间、倒计时完成。
   * @param durationMs 振动时长，默认 500ms
   */
  public static async vibrateAlarm(durationMs: number = 500): Promise<void> {
    try {
      await vibrator.startVibration({
        type: 'time',
        duration: durationMs
      }, {
        id: 0,
        usage: 'alarm' // 声明为闹钟/提醒类用途
      });
      console.info('VibrationManager: 提醒振动触发成功');
    } catch (err) {
      console.error(`VibrationManager: 提醒振动失败 ${JSON.stringify(err)}`);
    }
  }

  /**
   * 模式二：UI 交互的线性马达触感反馈
   * 适用场景：点击按钮、切换 Tab、拨动开关组件。
   */
  public static async vibrateClick(): Promise<void> {
    try {
      // 优先调用系统预置的线性马达触觉反馈效果（haptic.effect.soft 适合轻量级UI点击）
      await vibrator.startVibration({
        type: 'preset',
        effectId: 'haptic.effect.soft',
        count: 1
      }, {
        id: 0,
        usage: 'touch' // 声明为触控交互用途
      });
      console.info('VibrationManager: 线性马达触感触发成功');
    } catch (err) {
      console.warn(`VibrationManager: 预置触感失败(设备可能不支持)，开始降级兼容: ${JSON.stringify(err)}`);

      // 降级方案：如果设备不支持预置的线性马达效果，则用 30ms 的极短时间振动来模拟触感
      try {
        await vibrator.startVibration({
          type: 'time',
          duration: 30
        }, {
          id: 0,
          usage: 'touch'
        });
      } catch (fallbackErr) {
        console.error(`VibrationManager: 降级触感振动也失败 ${JSON.stringify(fallbackErr)}`);
      }
    }
  }
}