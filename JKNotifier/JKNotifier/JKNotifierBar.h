//
//  JKNotifierBar.h
//  JKNotifier
//
//  Created by Jakey on 15/5/21.
//  Copyright (c) 2015年 Jakey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JKNotifier;
@class JKNotifierBar;

#define  LESS_IOS0_AND_ORIENTATION_PORTRAIT   [[UIDevice currentDevice].systemVersion  floatValue] <9.0 && \
[UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait


typedef void(^JKNotifierBarClickBlock)(NSString *name,NSString *detail,JKNotifier *notifier);
@interface JKNotifierBar : UIWindow
{
    JKNotifierBarClickBlock _notifierBarClickBlock;
}
@property(nonatomic,assign)BOOL isDissiming;
@property(nonatomic,assign)UIInterfaceOrientation orientation;
- (void)show:(NSString*)note name:(NSString*)appName icon:(UIImage*)appIcon;

- (void)handleClickAction:(JKNotifierBarClickBlock)notifierBarClickBlock;
@end
