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
typedef void(^JKNotifierBarClickBlock)(NSString *name,NSString *detail,JKNotifier *notifier);
@interface JKNotifierBar : UIWindow
{
    JKNotifierBarClickBlock _notifierBarClickBlock;
}
-(void)show:(NSString*)note name:(NSString*)appName icon:(UIImage*)appIcon;

-(void)handleClickAction:(JKNotifierBarClickBlock)notifierBarClickBlock;
@end
