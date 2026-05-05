import { textToSpeech } from '@kit.CoreSpeechKit';

export class TTSManager {
  private ttsEngine: textToSpeech.TextToSpeechEngine | null = null;

  public async init(): Promise<void> {
    let createParams: textToSpeech.CreateEngineParams = {
      language: 'zh-CN', // 语种：中文
      person: 0,         // 发音人：0 代表默认发音人
      online: 1,         // 模式：1 代表本地离线引擎
      extraParams: {
        "style": 'interaction-broadcast',
        "locate": 'CN',
        "name": 'EngineName'
      }
    };

    return new Promise<void>((resolve, reject) => {
      try {
        textToSpeech.createEngine(createParams, (err, engine) => {
          if (!err && engine) {
            this.ttsEngine = engine;
            console.info('TTSManager: 引擎初始化成功');

            // 设置播报回调监听
            this.ttsEngine.setListener({
              onStart(requestId: string, response: textToSpeech.StartResponse) {
                console.info(`TTS播报开始: ${requestId}`);
              },
              onComplete(requestId: string, response: textToSpeech.CompleteResponse) {
                console.info(`TTS播报完成: ${requestId}`);
              },
              onStop(requestId: string, response: textToSpeech.StopResponse) {
                console.info(`TTS播报停止: ${requestId}`);
              },
              onData(requestId: string, audio: ArrayBuffer, response: textToSpeech.SynthesisResponse) {},
              onError(requestId: string, errorCode: number, errorMessage: string) {
                console.error(`TTS播报错误: ${errorCode} ${errorMessage}`);
              }
            });

            resolve();
          } else {
            console.error(`TTSManager: 引擎初始化失败: ${JSON.stringify(err)}`);
            reject(err);
          }
        });
      } catch (err) {
        console.error(`TTSManager: 引擎创建异常: ${JSON.stringify(err)}`);
        reject(err);
      }
    });
  }

  public speak(text: string): void {
    if (this.ttsEngine !== null) {
      this.ttsEngine.speak(text, {
        requestId: Date.now().toString(),
        extraParams: { "speed": 1, "volume": 2, "pitch": 1 }
      });
    } else {
      console.error('TTSManager: 引擎未初始化或已销毁');
    }
  }

  public release(): void {
    if (this.ttsEngine !== null) {
      this.ttsEngine.shutdown();
      this.ttsEngine = null;
    }
  }
}