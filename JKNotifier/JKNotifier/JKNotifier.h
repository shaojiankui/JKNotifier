//
//  JKNotifier.h
//  JKNotifier
//
//  Created by Jakey on 15/5/21.
//  Copyright (c) 2015年 Jakey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JKNotifierBar.h"
@interface JKNotifier : NSObject
+ (JKNotifier*)shareInstance;
/**
 *  显示一个Notifer，需要手动点击关闭
 *
 *  @param note Notifer 内容
 *
 *  @return JKNotifierBar
 */
+ (JKNotifierBar*)showNotiferRemain:(NSString*)note;
/**
 *  显示一个Notifer，需要手动点击关闭
 *
 *  @param note    Notifer 内容
 *  @param appName Notifer 自定义APP名称 默认读取CFBundleName
 *
 *  @return JKNotifierBar
 */
+ (JKNotifierBar*)showNotiferRemain:(NSString*)note
                              name:(NSString*)appName;
/**
 *  显示一个Notifer,2秒后自动关闭
 *
 *  @param note Notifer 内容
 *
 *  @return JKNotifierBar
 */
+ (JKNotifierBar*)showNotifer:(NSString*)note;
/**
 *  显示一个Notifer,delay秒后自动关闭
 *
 *  @param note  Notifer 内容
 *  @param delay 自动关闭时间
 *
 *  @return JKNotifierBar
 */
+ (JKNotifierBar*)showNotifer:(NSString *)note
                      dismissAfter:(NSTimeInterval)delay;
/**
 *  显示一个Notifer,内容，名称，图标
 *
 *  @param note    Notifer 内容
 *  @param appName APP名称
 *  @param appIcon APP图标
 *
 *  @return JKNotifierBar
 */
+ (JKNotifierBar*)showNotifer:(NSString*)note
                           name:(NSString*)appName
                           icon:(UIImage*)appIcon;
/**
 *  显示一个Notifer,内容，名称，图标，关闭时间
 *
 *  @param note    Notifer 内容
 *  @param appName APP名称
 *  @param appIcon APP图标
 *  @param delay   自动关闭时间
 *
 *  @return JKNotifierBar
 */
+ (JKNotifierBar*)showNotifer:(NSString*)note
                           name:(NSString*)appName
                           icon:(UIImage*)appIcon
                   dismissAfter:(NSTimeInterval)delay;
/**
 *  关闭Notifer
 */
+ (void)dismiss;
/**
 *  关闭Notifer
 */
- (void)dismiss;
/**
 *  延迟关闭Notifer
 *
 *  @param delay 延迟关闭时间
 */
+ (void)dismissAfter:(NSTimeInterval)delay;
/**
 *  点击Notifer的回调
 *
 *  @param notifierBarClickBlock 点击Notifer的回调
 */
+ (void)handleClickAction:(JKNotifierBarClickBlock)notifierBarClickBlock;

@end
