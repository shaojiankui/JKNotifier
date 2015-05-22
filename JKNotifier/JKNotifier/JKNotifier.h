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

+(JKNotifierBar*)showNotiferRemain:(NSString*)note;

+(JKNotifierBar*)showNotiferRemain:(NSString*)note
                              name:(NSString*)appName;


+(JKNotifierBar*)showNotifer:(NSString*)note;

+ (JKNotifierBar*)showNotifer:(NSString *)note
                      dismissAfter:(NSTimeInterval)delay;

+(JKNotifierBar*)showNotifer:(NSString*)note
                           name:(NSString*)appName
                           icon:(UIImage*)appIcon;

+(JKNotifierBar*)showNotifer:(NSString*)note
                           name:(NSString*)appName
                           icon:(UIImage*)appIcon
                   dismissAfter:(NSTimeInterval)delay;

+ (void)dismiss;

- (void)dismiss;

+ (void)dismissAfter:(NSTimeInterval)delay;

+(void)handleClickAction:(JKNotifierBarClickBlock)notifierBarClickBlock;

@end
