import { common } from "@kit.AbilityKit";

export class GlobalContext {

  private static instance: GlobalContext;
  private context:common.UIAbilityContext|undefined;

  private constructor() {}

  public static getInstance() {
    if (!GlobalContext.instance) {
      GlobalContext.instance = new GlobalContext();
    }

    return GlobalContext.instance;
  }

  public initContext(context: common.UIAbilityContext) {
    this.context = context;
  }

  public getContext(): common.UIAbilityContext {
    return this.context!;
  }
}