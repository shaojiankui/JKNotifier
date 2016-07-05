//
//  RootViewController.m
//  JKNotifier
//
//  Created by Jakey on 15/5/21.
//  Copyright (c) 2015年 Jakey. All rights reserved.
//

#import "RootViewController.h"
#import "JKNotifier.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   self.title = @"Some Demo of JKNotifier";
}
 
- (IBAction)showAutoHiddenTouched:(id)sender {
    [JKNotifier showNotifer:[NSString stringWithFormat:@"亲,您收到了一条自动隐藏的消息哦!%@",[self random]]];
    
    [JKNotifier handleClickAction:^(NSString *name,NSString *detail, JKNotifier *notifier) {
        [notifier dismiss];
        NSLog(@"AutoHidden JKNotifierBar clicked");

    }];
  
}

- (IBAction)remainTouched:(id)sender {
    JKNotifierBar *bar =  [JKNotifier showNotiferRemain:[NSString stringWithFormat:@"亲,您收到了一条长存消息哦!点击可以在block中关闭我哦!%@",[self random]]];
    
    [bar handleClickAction:^(NSString *name,NSString *detail,JKNotifier *notifer) {
        [notifer dismiss];
        NSLog(@"remain JKNotifierBar clicked");
        
    }];
}

- (IBAction)customTitleTouched:(id)sender {
    [JKNotifier showNotifer:[NSString stringWithFormat:@"亲,你收亲,你收到了一条消息哦!亲,你收到了一条消息哦!亲,你收到了一条消息哦!亲,你收到了一条消息哦!亲,你收到了一条消息哦!亲,你收到了一条消息哦!亲,你收到了一条消息哦!亲,你收到了一条消息哦!亲,你收到了一条消息哦!亲,你收到了一条消息哦!亲,你收到,你收到了一条消息哦!亲,你收到了一条消息哦!亲,你收到了一条消息哦!亲,你收到了一条消息哦!亲,你收到了一条消息哦!亲,你收到了一条消息哦!亲,息哦!你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲你收到了一条消息哦!亲%@",[self random]] name:@"亲你收到了一条,超长自动隐藏消息哦,点击立即关闭哦" icon:nil];
    [JKNotifier handleClickAction:^(NSString *name,NSString *detail, JKNotifier *notifier) {
        [notifier dismiss];
        NSLog(@"customTitle clicked");
        
    }];
}

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

-(NSString*)random{
   
    NSInteger count = 8;
    char chars[] = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLOMNOPQRSTUVWXYZ";
    char codes[count];
    
    for(int i=0;i<count; i++){
        codes[i]= chars[arc4random()%62];
    }
    
    NSString *text = [[NSString alloc] initWithBytes:codes
                                              length:count encoding:NSUTF8StringEncoding];
    return text;
}
@end
