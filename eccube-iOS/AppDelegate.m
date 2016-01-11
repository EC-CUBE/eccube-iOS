//
//  AppDelegate.m
//  eccube-iOS
//

#import "AppDelegate.h"
//@FIXME: Appiearies importコメント外す
//#import <AppiariesSDK/AppiariesSDK.h>
#import "WebViewController.h"

@interface AppDelegate () <UIAlertViewDelegate>

@end

@implementation AppDelegate
{
    //@FIXME: Appieariesコメント外す
//    ABPushMessage *_msg; // 最後に受信した通知メッセージ
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //SDKを有効化する
    //@FIXME: Appieariesセッティング値修正し、コメントを外す
//    baas.config.datastoreID = @"_sandbox";
//    baas.config.applicationID = @"APP_ID";
//    baas.config.applicationToken = @"APP_TOKEN";
//    [baas activate];
    
    // APNs: プッシュ通知機能利用登録（デバイストークン発行要求）
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
#ifdef __IPHONE_8_0
        // iOS8以降のプッシュ通知登録処理
        UIUserNotificationType types = UIUserNotificationTypeBadge |  UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *notifSettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:notifSettings];
#endif
    } else {
        // iOS8以前のプッシュ通知登録処理
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }

    // アプリが起動していない場合も必要に応じて通知を捕捉する
    NSDictionary *userInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    [self handlePushIfNeeded:userInfo];

    //タブの設定
    UITabBarController *tabBarController = [[UITabBarController alloc]init];
    tabBarController.viewControllers = @[
                                        [self initialWebViewController:@"/" iconTitle:@"Home" iconImageName:@"tab_home"],
                                        [self initialWebViewController:@"/mypage" iconTitle:@"マイページ" iconImageName:@"tab_user"],
                                        [self initialWebViewController:@"/products/list" iconTitle:@"商品一覧" iconImageName:@"tab_list"],
                                        [self initialWebViewController:@"/cart" iconTitle:@"カート" iconImageName:@"tab_cart"],
                                        [self initialWebViewController:@"/mypage/favorite" iconTitle:@"お気に入り" iconImageName:@"tab_favorite"],
                                         ];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = tabBarController;

    return YES;
}

- (WebViewController*)initialWebViewController:(NSString*)path iconTitle:(NSString*)iconTitle iconImageName:(NSString*)iconImageName {
    WebViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateInitialViewController];
    vc.initialPath = path;
    vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:iconTitle image:[UIImage imageNamed:iconImageName] selectedImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_on", iconImageName]]];
    return vc;
}

#ifdef __IPHONE_8_0
// ユーザ通知設定登録完了時ハンドラ (iOS8用)
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}
#endif

// APNs: デバイストークン発行成功時ハンドラ
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"APNs: デバイストークン発行成功 [デバイストークン:%@]", [deviceToken description]);
    const char *devTokenData = [deviceToken bytes];
    NSMutableString *devTokenString = [NSMutableString string];
    for (int i = 0; i < [deviceToken length]; i++) {
        [devTokenString appendFormat:@"%02.2hhX", devTokenData[i]];
    }
    //UserDefaultsに保存
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:devTokenString forKey:@"deviceToken"];
    
    // デバイスを登録する
    //@FIXME: Appieariesコメント外す
//    ABDevice *device = [ABDevice deviceWithRawDeviceToken:deviceToken];
//    [baas.device register:device block:^(ABResult *ret, NSError *error){
//        if (error == nil) {
//            NSLog(@"SUCCESS: registered device token: %@", device.deviceToken);
//        } else {
//            NSLog(@"ERROR: %@", error.description);
//        }
//    }];
}

// APNs: デバイストークン発行失敗時ハンドラ
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"APNs: デバイストークン発行失敗 [原因:%@]", [error localizedDescription]);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // リモートプッシュ通知を受信した際に通知を捕捉する
    [self handlePushIfNeeded:userInfo];
}

// プッシュ通知を受信した場合
- (void)handlePushIfNeeded:(NSDictionary *)userInfo {
    NSDictionary *aps = userInfo[@"aps"];
    if (!aps) return;

    //通知のバッジを消す
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    // インスタンス変数にプッシュ通知メッセージを保存しておく
    //@FIXME: Appieariesコメント外す
//    _msg = [baas.push messageWithDictionary:userInfo];
//    
//    // プッシュ通知メッセージを表示
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:_msg[@"subject"]
//                                                        message:_msg.message
//                                                       delegate:self
//                                              cancelButtonTitle:@"キャンセル"
//                                              otherButtonTitles:@"既読", nil];
//    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //@FIXME: Appieariesコメント外す
//    if (buttonIndex == 1) {
//        if (_msg.pushId) {
//            // 開封通知 (非同期)
//            [_msg openWithBlock:^(ABResult *result, ABError *error){
//                if (error == nil) {
//                    NSLog(@"SUCCESS: status=%ld", result.code);
//                } else {
//                    NSLog(@"ERROR: %@", error.description);
//                }
//            }];
//        }
//    }
}
@end
