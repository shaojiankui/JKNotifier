//
//  JKNotifier.m
//  JKNotifier
//
//  Created by Jakey on 15/5/21.
//  Copyright (c) 2015年 Jakey. All rights reserved.
//

#import "JKNotifier.h"
#import <AudioToolbox/AudioToolbox.h>

static NSTimeInterval const defaultDelay =10;

@interface JKNotifier()
@property (nonatomic, strong) JKNotifierBar *notifierBar;
@property (nonatomic, strong) UIImage *defaultIcon;
@property (nonatomic, copy) NSString *appName;

//- (JKNotifierBar*)showNotifer:(NSString*)note name:(NSString*)appName icon:(UIImage*)appIcon{

@property (nonatomic,copy)NSString *note;

@end

@implementation JKNotifier

+ (JKNotifier*)shareInstance {
    static dispatch_once_t onceToken;
    static JKNotifier *notifier;
    dispatch_once(&onceToken, ^ {
        notifier = [[self alloc] init];
    });
    return notifier;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifierOrientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];

    }
    return self;
}
#pragma --mark getter
- (NSString*)appName{
    if (!_appName) {
        _appName =  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]?:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
    }
    return _appName;
}
- (UIImage*)defaultIcon{
    if (!_defaultIcon) {
        
        _defaultIcon = [self loadPlistIcon] ?:[UIImage imageNamed:@"AppIcon"] ?:[UIImage imageNamed:@"AppIcon-1"] ?:[UIImage imageNamed:@"AppIcon-2"] ?:[UIImage imageNamed:@"AppIcon-3"] ?:[UIImage imageNamed:@"JKNotifier_default_icon"];
    }
    return _defaultIcon;
}
- (JKNotifierBar*)notifierBar{
    if (!_notifierBar) {
        _notifierBar = [[JKNotifierBar alloc] init];
        
        if (LESS_IOS0_AND_ORIENTATION_PORTRAIT) {
            
            CGRect frame = _notifierBar.frame;
            frame.origin.x +=frame.size.width;
            
        }else{
            
            CGRect frame = _notifierBar.frame;
            frame.origin.y = -frame.size.height;
            _notifierBar.frame = frame;
        }
    }
    return _notifierBar;
}
+ (void)handleClickAction:(JKNotifierBarClickBlock)notifierBarClickBlock{
   [[self shareInstance].notifierBar handleClickAction:notifierBarClickBlock];
}

#pragma --mark class method
+ (JKNotifierBar*)showNotiferRemain:(NSString*)note{
    return [JKNotifier showNotiferRemain:note name:nil];
}

+ (JKNotifierBar*)showNotiferRemain:(NSString*)note
                              name:(NSString*)appName{
    return [JKNotifier showNotifer:note name:appName icon:nil dismissAfter:-1];
}

+ (JKNotifierBar*)showNotifer:(NSString*)note{
    return [JKNotifier showNotifer:note dismissAfter:defaultDelay];
}

+ (JKNotifierBar*)showNotifer:(NSString*)note name:(NSString*)appName icon:(UIImage*)appIcon{
    return [JKNotifier showNotifer:note name:appName icon:appIcon dismissAfter:defaultDelay];
}

+ (JKNotifierBar*)showNotifer:(NSString *)note
                    dismissAfter:(NSTimeInterval)delay{
    return [self showNotifer:note name:nil icon:nil dismissAfter:delay];
}
+ (JKNotifierBar*)showNotifer:(NSString*)note
                           name:(NSString*)appName
                           icon:(UIImage*)appIcon
                   dismissAfter:(NSTimeInterval)delay{
    
    [self shareInstance].note=note;
    [self shareInstance].appName=appName;
//    [self shareInstance].appIcon=appIcon;

    JKNotifierBar *bar =  [[self shareInstance] showNotifer:note
                                        name:appName?:[self shareInstance].appName
                                        icon:appIcon?:[self shareInstance].defaultIcon];
    [self dismissAfter:delay];
    return bar;
}
+ (void)dismiss{
    [[self shareInstance] dismiss];
}
+ (void)dismissAfter:(NSTimeInterval)delay;
{
    if(delay<0)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:[self shareInstance]  selector:@selector(dismiss) object:nil];
    }else
    {
        [[self shareInstance] performSelector:@selector(dismiss) withObject:nil afterDelay:delay];
    }

}
#pragma --instance method
- (JKNotifierBar*)showNotifer:(NSString*)note name:(NSString*)appName icon:(UIImage*)appIcon{
    
    
    [self.notifierBar.layer removeAllAnimations];
    self.notifierBar.userInteractionEnabled = YES;
    [self.notifierBar removeFromSuperview];
    self.notifierBar = nil;
    
    AudioServicesPlaySystemSound(1007);

    [self.notifierBar show:note name:appName icon:appIcon];
    [UIView animateWithDuration:(0.4) animations:^{
        self.notifierBar.alpha = 1.0;
        
        
        if (LESS_IOS0_AND_ORIENTATION_PORTRAIT) {
            
            CGRect frame = _notifierBar.frame;
            frame.origin.x -=frame.size.width;
            
        }else{
            
            CGRect frame = _notifierBar.frame;
            frame.origin.y = 0.;
            _notifierBar.frame = frame;
        }

    }];
    return self.notifierBar;
}

- (void)dismiss
{
    [self dismissWithAnimation:YES];
}
- (void)dismissWithAnimation:(BOOL)animated{
    [[NSRunLoop currentRunLoop] cancelPerformSelector:@selector(dismiss) target:self argument:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismiss) object:nil];
    _notifierBar.isDissiming=YES;
    if(animated){
        [UIView animateWithDuration:0.4 animations:^{
            
            if (LESS_IOS0_AND_ORIENTATION_PORTRAIT) {
                
                CGRect frame = _notifierBar.frame;
//                frame.origin.x +=frame.size.width;
//                _notifierBar.frame=frame;
                _notifierBar.transform=CGAffineTransformTranslate(_notifierBar.transform,CGRectGetWidth(frame), 0);
                
            }else{
                
                CGRect frame = _notifierBar.frame;
//                frame.origin.y = -frame.size.height;
//                _notifierBar.frame = frame;
                _notifierBar.transform=CGAffineTransformTranslate(_notifierBar.transform,0, -frame.size.height);

            }

        } completion:^(BOOL finished) {
            self.notifierBar.userInteractionEnabled = NO;
            _notifierBar.hidden = YES;
        }];
    }else{
        _notifierBar.hidden = YES;
    }
}
- (void)notifierOrientationChange:(NSNotification *)notification
{
    
    if ([UIApplication sharedApplication].statusBarOrientation != _notifierBar.orientation) {
        if (_notifierBar.hidden == NO && _notifierBar.isDissiming == NO) {
            [self showNotifer:self.note name:self.appName icon:[self loadPlistIcon]];
        }
    }
}
#pragma --mark helper

- (UIImage*)loadPlistIcon{
    NSString *iconString = @"Icon.png";
    NSArray *icons = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIconFiles"];
    if (!icons) {
        iconString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIconFile"];
    }
    else
    {
        iconString = icons [0];
    }
    return [UIImage imageNamed:iconString];
}
@end

