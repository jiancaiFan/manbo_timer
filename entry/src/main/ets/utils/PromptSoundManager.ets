import { media } from '@kit.MediaKit';
import { common } from '@kit.AbilityKit';

export class PromptSoundManager {
  private avPlayer: media.AVPlayer | null = null;
  private isReady: boolean = false;

  public async init(context: common.UIAbilityContext): Promise<void> {
    try {
      this.avPlayer = await media.createAVPlayer();

      this.avPlayer.on('stateChange', (state: string) => {
        if (state === 'initialized') {
          // prepare 是异步的，必须加上 catch
          this.avPlayer?.prepare().catch((err: Error) => {
            console.error(`PromptSoundManager: prepare失败 ${err.message}`);
          });
        } else if (state === 'prepared') {
          this.isReady = true;
          console.info('PromptSoundManager: 提示音准备就绪');
        } else if (state === 'completed') {
          this.avPlayer?.seek(0);
        }
      });

      this.avPlayer.on('error', (err) => {
        console.error(`PromptSoundManager: 播放器发生错误 ${JSON.stringify(err)}`);
        this.isReady = false;
      });

      let fileDescriptor = await context.resourceManager.getRawFd('prompt.mp3');
      if (this.avPlayer !== null) {
        this.avPlayer.fdSrc = fileDescriptor;
      }

    } catch (e) {
      console.error(`PromptSoundManager: 初始化失败 ${JSON.stringify(e)}`);
    }
  }

  public play(): void {
    if (this.avPlayer !== null && this.isReady) {
      this.avPlayer.play().catch((err: Error) => {
        console.error(`PromptSoundManager: 播放异常 ${err.message}`);
      });
    }
  }

  public release(): void {
    if (this.avPlayer !== null) {
      this.isReady = false;
      // 严格模式下的链式释放
      this.avPlayer.stop().catch(() => {}).finally(() => {
        this.avPlayer?.release().catch(() => {});
        this.avPlayer = null;
      });
    }
  }
}