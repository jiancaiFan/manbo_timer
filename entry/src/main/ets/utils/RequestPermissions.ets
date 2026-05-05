import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl';
import common from '@ohos.app.ability.common';
import bundleManager from '@ohos.bundle.bundleManager';
import notificationManager from '@ohos.notificationManager';

export default class PermissionUtil {
  /**
   * 1. 检查是否已经授予了该普通权限
   * @param permission 具体的权限，例如：'ohos.permission.CAMERA'
   * @returns true: 已授权; false: 未授权
   */
  public static async checkAccessToken(permission: Permissions): Promise<boolean> {
    let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    let grantStatus: abilityAccessCtrl.GrantStatus = abilityAccessCtrl.GrantStatus.PERMISSION_DENIED;

    try {
      // 获取当前应用的 accessTokenId
      let bundleInfo: bundleManager.BundleInfo =
        await bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
      let appInfo: bundleManager.ApplicationInfo = bundleInfo.appInfo;
      let tokenId = appInfo.accessTokenId;

      // 校验权限状态
      grantStatus = await atManager.checkAccessToken(tokenId, permission);
    } catch (error) {
      console.error(`PermissionUtil checkAccessToken failed, error: ${JSON.stringify(error)}`);
    }

    return grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED;
  }

  /**
   * 2. 动态申请普通权限（会拉起系统弹窗）
   * @param context UIAbility 的上下文对象
   * @param permissions 需要申请的权限数组，例如：['ohos.permission.CAMERA']
   * @returns true: 所有权限申请成功; false: 存在被拒绝的权限
   */
  public static async requestPermissions(
    context: common.UIAbilityContext,
    permissions: Array<Permissions>
  ): Promise<boolean> {
    if (!permissions || permissions.length === 0) {
      return true;
    }

    let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();

    try {
      // 拉起权限弹窗申请权限
      let grantResult = await atManager.requestPermissionsFromUser(context, permissions);
      let authResults: Array<number> = grantResult.authResults;

      // 判断是否数组里的每一个权限都被成功授予 (0 代表 PERMISSION_GRANTED)
      let isAllGranted = authResults.every(status => status === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED);

      if (isAllGranted) {
        console.info('PermissionUtil: 所有普通权限申请成功');
        return true;
      } else {
        console.warn('PermissionUtil: 用户拒绝了部分或全部普通权限');
        return false;
      }
    } catch (error) {
      console.error(`PermissionUtil requestPermissions failed, error: ${JSON.stringify(error)}`);
      return false;
    }
  }

  /**
   * 3. 二次封装：自动检查并申请普通权限
   * @param context UIAbility 上下文
   * @param permissions 权限数组
   * @returns 最终是否获得了所有权限
   */
  public static async checkAndRequestPermissions(
    context: common.UIAbilityContext,
    permissions: Array<Permissions>
  ): Promise<boolean> {
    // 过滤出还没被授权的权限
    let needRequestPermissions: Array<Permissions> = [];
    for (let permission of permissions) {
      let isGranted = await PermissionUtil.checkAccessToken(permission);
      if (!isGranted) {
        needRequestPermissions.push(permission);
      }
    }

    // 如果所有权限都已经授予过了，直接返回 true
    if (needRequestPermissions.length === 0) {
      return true;
    }

    // 对未授权的权限发起弹窗申请
    return await PermissionUtil.requestPermissions(context, needRequestPermissions);
  }

  /**
   * 4. 检查并申请通知权限 (Notification)
   * 注意：通知权限与普通权限不同，不需要在 module.json5 中声明
   * @param context UIAbility 上下文
   * @returns true: 已开启通知; false: 未开启通知
   */
  public static async checkAndRequestNotification(context: common.UIAbilityContext): Promise<boolean> {
    try {
      // 检查是否已经开启了通知权限
      let isEnabled = await notificationManager.isNotificationEnabled();

      if (isEnabled) {
        console.info('PermissionUtil: 通知权限已开启');
        return true;
      }

      // 如果未开启，请求开启通知权限（系统会拉起询问是否允许发送通知的弹窗）
      await notificationManager.requestEnableNotification(context);

      // 弹窗结束后，再次检查用户的选择结果
      let finalState = await notificationManager.isNotificationEnabled();
      if (finalState) {
        console.info('PermissionUtil: 用户同意了通知权限');
        return true;
      } else {
        console.warn('PermissionUtil: 用户拒绝了通知权限');
        return false;
      }
    } catch (error) {
      console.error(`PermissionUtil checkAndRequestNotification failed, error: ${JSON.stringify(error)}`);
      return false;
    }
  }
}