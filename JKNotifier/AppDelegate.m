//
//  AppDelegate.m
//  JKNotifier
//
//  Created by Jakey on 15/5/21.
//  Copyright (c) 2015年 Jakey. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "JKNotifier.h"
@interface AppDelegate ()
@end

@implementation AppDelegate
+(AppDelegate*)APP{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    self.rooViewController = [[RootViewController alloc] init];
    self.navgationController = [[UINavigationController alloc]initWithRootViewController:self.rooViewController];
    self.window.rootViewController = self.navgationController;
    [self.window makeKeyAndVisible];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else
    {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
    
    
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    if (application.applicationState == UIApplicationStateActive) {
        [JKNotifier showNotifer:notification.alertBody];
        
    }
}
@end
