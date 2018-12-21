//
//  AppDelegate.m
//  lianmeng
//
//  Created by zhuchao on 2018/5/29.
//  Copyright © 2018年 zhuchao. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarController.h"
#import "WechatLoginScene.h"
#import "UserCenter.h"
#import "LMNavigationController.h"
#import <EasyIOS/EasyIOS.h>

#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
// 引入JPush功能所需头文件
#import "JPUSHService.h"
#import <JDSDK/JDKeplerSDK.h>
#import "WelcomeScrollView.h"

#import "FindSplashRequest.h"
#import "ActionSceneModel.h"

#import <Crontab-IOS/CronTabCenter.h>

// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate ()<JPUSHRegisterDelegate>
@end
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    ///www.taotongxue.cn
    ///47.110.40.176:8888/
    //com.bailing.tao
    [Action actionConfigScheme:@"https" host:@"www.taotongxue.cn" client:@"lianmeng-ios"
                       codeKey:@"status" rightCode:200 msgKey:@"msg"];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIViewController *vc = [[TabBarController alloc]init];
    self.window.rootViewController = vc;
    //@weakify(vc);
    /*
    [CronTabCenter addCronJob:@"1 1" forBlock:^{
        NSLog(@"1 1 executed");
        FindSplashRequest *req = [FindSplashRequest Request];
        [[ActionSceneModel sharedInstance] doRequest:req success:^{
            @strongify(vc);
            NSArray *list = [req.output objectAtPath:@"data/pictures"];
            if (list && list.count >0) {
                WelcomeScrollView *welcome = [[WelcomeScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
                [welcome loadImages:list];
                [vc.view addSubview:welcome];
            }
        } error:^{
            
        }];
    }];*/
    [self.window makeKeyAndVisible];
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:@"11c4e4315fb71a9761848183"
                          channel:@"APP store"
                 apsForProduction:true
            advertisingIdentifier:nil];
    // U-Share 平台设置
    [UMConfigure initWithAppkey:@"5b338aa6f29d98333800001c" channel:@"App Store"];
    [self configUSharePlatforms];
    [self confitUShareSettings];
    [self configAli];
    [self configJD];
    return YES;
}
-(void)configJD{
    [[KeplerApiManager sharedKPService]asyncInitSdk:@"57dc2deb3afa4d14a90586bfe8d9809c" secretKey:@"051cb73a61e643ed8d07c36b07b17d7e"
                                     sucessCallback:^(){
                                     }failedCallback:^(NSError *error){
                                     }];
}

-(void)configAli{
    // 百川平台基础SDK初始化，加载并初始化各个业务能力插件
    [[AlibcTradeSDK sharedInstance] asyncInitWithSuccess:^{
    } failure:^(NSError *error) {
        NSLog(@"Init failed: %@", error.description);
    }];
    // 开发阶段打开日志开关，方便排查错误信息
    //默认调试模式打开日志,release关闭,可以不调用下面的函数
    [[AlibcTradeSDK sharedInstance] setDebugLogOpen:YES];
    // 配置全局的淘客参数
    //如果没有阿里妈妈的淘客账号,setTaokeParams函数需要调用
    AlibcTradeTaokeParams *taokeParams = [[AlibcTradeTaokeParams alloc] init];
    taokeParams.pid = @"mm_132592094_0_0"; //mm_XXXXX为你自己申请的阿里妈妈淘客pid
    [[AlibcTradeSDK sharedInstance] setTaokeParams:taokeParams];
    //设置全局的app标识，在电商模块里等同于isv_code
    //没有申请过isv_code的接入方,默认不需要调用该函数
    //[[AlibcTradeSDK sharedInstance] setISVCode:@"your_isv_code"];
    // 设置全局配置，是否强制使用h5
    [[AlibcTradeSDK sharedInstance] setIsForceH5:NO];
}

- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
}

- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx343b0b25574f58f2" appSecret:@"98a0226e1c038606774e380cf385d45d" redirectURL:@"http://mobile.umeng.com/social"];
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if (![[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation]) {
        if (![[AlibcTradeSDK sharedInstance] application:application
                                                     openURL:url
                                           sourceApplication:sourceApplication
                                                  annotation:annotation]) {
                return NO;
        }
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}




@end
