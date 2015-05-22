# JKNotifier
JKNotifier,when a notification pushed and app is UIApplicationStateActive,JKNotifier wiil show in statusbar like background push

#Demo
![](https://raw.githubusercontent.com/shaojiankui/JKNotifier/master/demo.gif)

#Useage
##Manual show
	- (IBAction)showAutoHiddenTouched:(id)sender {
    [JKNotifier showNotifer:@"亲,您收到了一条自动隐藏的消息哦!"];
    
    [JKNotifier handleClickAction:^(NSString *name,NSString *detail, JKNotifier *notifier) {
        [notifier dismiss];
        NSLog(@"AutoHidden JKNotifierBar clicked");
    }]; 
    }
##UILocalNotification or UIRemoteNotification
	- (IBAction)localNotificationTouched:(id)sender {
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {
        NSDate *now=[NSDate date];
        notification.fireDate=[now dateByAddingTimeInterval:2];
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.alertBody=@"收到定时本地推送通知！(recived a UILocalNotification)";
        notification.soundName = @"default";
        [notification setApplicationIconBadgeNumber:1];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
    NSLog(@"本地通知2秒后触发");
    }
    
    //appdelegate.m
    
    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
	{
   
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
    
## License

JKNotifier is available under the MIT license.
