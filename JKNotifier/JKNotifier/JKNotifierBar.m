//
//  JKNotifierBar.m
//  JKNotifier
//
//  Created by Jakey on 15/5/21.
//  Copyright (c) 2015年 Jakey. All rights reserved.
//

#import "JKNotifierBar.h"
#import <Accelerate/Accelerate.h>
#import "JKNotifier.h"

@interface JKNotifierBar ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, assign) UIEdgeInsets edge;
@property (nonatomic, strong) UIFont *font;

@property(nonatomic,strong)UIPanGestureRecognizer *panGestureRecognizer;
@property(nonatomic,strong)UITapGestureRecognizer *tapGestureRecognizer;


@end

@implementation JKNotifierBar


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self buildWindow];
        self.isDissiming=NO;
        self.orientation=[UIApplication sharedApplication].statusBarOrientation;
    }
    return self;
}
- (void)buildWindow
{
    self.windowLevel = UIWindowLevelStatusBar + 1.0;
    self.hidden = NO;
    self.autoresizesSubviews = YES;
    self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.800];
    
    UIApplication *sharedApplication = [UIApplication sharedApplication];
    

    if (LESS_IOS0_AND_ORIENTATION_PORTRAIT) {
        self.transform=CGAffineTransformMakeRotation(M_PI/2);
    }
    
    if (CGRectIsEmpty(sharedApplication.statusBarFrame)) {
        
        if (LESS_IOS0_AND_ORIENTATION_PORTRAIT) {
            self.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)-64, 0, 64, CGRectGetWidth([UIScreen mainScreen].bounds));
        }else{
            self.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 64);
        }
    }else{
        
        if (LESS_IOS0_AND_ORIENTATION_PORTRAIT) {
            
            CGRect screenRect=[UIScreen mainScreen].bounds;
            int screenHeight=MAX(CGRectGetWidth(screenRect), CGRectGetHeight(screenRect));
            int screenWith=MIN(CGRectGetWidth(screenRect), CGRectGetHeight(screenRect));

            self.frame = CGRectMake(screenWith-64, 0, 64, screenHeight);
        }else{
            self.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 64);
        }
    }

    [self addSubview:self.iconView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.detailLabel];
    
//    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
//                                                                                       action:@selector(swipeGesture:)];
//    swipeGesture.direction = UISwipeGestureRecognizerDirectionUp;
//    [self addGestureRecognizer:swipeGesture];

    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                    action:@selector(handlePan:)];
    [self addGestureRecognizer:_panGestureRecognizer];
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                   action:@selector(handleTap:)];
    [self addGestureRecognizer:_tapGestureRecognizer];

}
- (UIFont *)font{
    if (!_font) {
        _font =[UIFont systemFontOfSize:14.0];
    }
    return _font;
}
- (UIEdgeInsets)edge{
    return  UIEdgeInsetsMake(8.0, 50.0, 20.0, 5.0);
}
- (UIImageView *)iconView;
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithFrame:self.bounds];
        _iconView.clipsToBounds = YES;
    }
    return _iconView;
}

//- (UILabel *)timeLabel;
//{
//    if (!_timeLabel) {
//        _timeLabel = [[UILabel alloc] initWithFrame:self.bounds];
//        _timeLabel.textColor = [UIColor colorWithWhite:1.000 alpha:0.490];
//        _timeLabel.backgroundColor = [UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.000];
//        _timeLabel.font = [UIFont systemFontOfSize:NOTIFIER_FONT_SIZE-2];
//        _timeLabel.textAlignment = NSTextAlignmentLeft;
//        _timeLabel.clipsToBounds = YES;
//    }
//    return _timeLabel;
//}

- (UILabel *)nameLabel;
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = self.font;
        _nameLabel.textAlignment = NSTextAlignmentJustified;
        _nameLabel.clipsToBounds = YES;
        _nameLabel.numberOfLines = 2;

    }
    return _nameLabel;
}

- (UILabel *)detailLabel;
{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _detailLabel.textColor = [UIColor whiteColor];
        _detailLabel.backgroundColor = [UIColor clearColor];
        _detailLabel.font = self.font;
        _detailLabel.textAlignment = NSTextAlignmentJustified;
        _detailLabel.clipsToBounds = YES;
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}

#pragma --mark getter

- (void)handleClickAction:(JKNotifierBarClickBlock)notifierBarClickBlock{
    _notifierBarClickBlock = [notifierBarClickBlock copy];
}

- (void)drawRect:(CGRect)rect{
    
    if (LESS_IOS0_AND_ORIENTATION_PORTRAIT) {
    
        CGRect rect=CGRectMake((CGRectGetHeight(self.frame)-35)/2, CGRectGetWidth(self.frame)-12, 35, 5);

        UIBezierPath  *round = [UIBezierPath bezierPathWithRoundedRect:rect
                                                     byRoundingCorners:(UIRectCornerAllCorners) cornerRadii:CGSizeMake(10, 10)];
        [[UIColor lightGrayColor] setFill];
        [round fill];


    }else{
        
        UIBezierPath  *round = [UIBezierPath bezierPathWithRoundedRect:CGRectMake((CGRectGetWidth(self.frame)-35)/2, CGRectGetHeight(self.frame)-12, 35, 5) byRoundingCorners:(UIRectCornerAllCorners) cornerRadii:CGSizeMake(10, 10)];
        [[UIColor lightGrayColor] setFill];
        [round fill];

    }
}
- (void)show:(NSString*)note name:(NSString*)appName icon:(UIImage*)appIcon{
    
    self.nameLabel.text = appName;
    self.detailLabel.text = note;
    self.iconView.image = appIcon;
    if (LESS_IOS0_AND_ORIENTATION_PORTRAIT) {
        
        CGRect screenRect=[UIScreen mainScreen].bounds;
        int screenHeight=MAX(CGRectGetWidth(screenRect), CGRectGetHeight(screenRect));

        self.iconView.frame = CGRectMake( 15, 7, 20, 20);
        
        CGFloat nameLabelWidth = CGRectGetHeight(self.frame)-self.edge.left-self.edge.right;
        CGFloat nameLabelHeight = MIN(40, [self heightWithString:appName fontSize:self.font.pointSize width:nameLabelWidth]);
        
        self.nameLabel.frame = CGRectMake(self.edge.left,
                                          self.edge.top,
                                          CGRectGetHeight(self.frame)-self.edge.left-self.edge.right,
                                          nameLabelHeight);
        
        
        CGFloat detailLabelHeight =  MIN(screenHeight-40-self.edge.bottom, [self heightWithString:note fontSize:self.font.pointSize width:CGRectGetHeight(self.frame)-self.edge.left-self.edge.right]);
        
        self.detailLabel.frame = CGRectMake(self.edge.left,
                                            CGRectGetMaxY(self.nameLabel.frame),
                                            CGRectGetHeight(self.frame)-self.edge.left-self.edge.right,detailLabelHeight);

        CGFloat selfHeight = MIN(screenHeight, CGRectGetMaxY(self.detailLabel.frame)+self.edge.bottom);

        CGRect frame = self.frame;
        CGFloat rightLine=frame.origin.x+frame.size.width;
        self.frame = CGRectMake(rightLine-selfHeight,frame.origin.y,selfHeight,frame.size.height);
        
        
    }else{
        
        self.iconView.frame = CGRectMake(15, 7, 20, 20);
        
        CGFloat nameLabelHeight  =  MIN(40, [self heightWithString:appName fontSize:self.font.pointSize width:CGRectGetWidth(self.frame)-self.edge.left-self.edge.right]);
        
        self.nameLabel.frame = CGRectMake(self.edge.left, self.edge.top, CGRectGetWidth(self.frame)-self.edge.left-self.edge.right,nameLabelHeight);
        
        
        CGFloat detailLabelHeight =  MIN(CGRectGetHeight([UIScreen mainScreen].bounds)-40-self.edge.bottom, [self heightWithString:note fontSize:self.font.pointSize width:CGRectGetWidth(self.frame)-self.edge.left-self.edge.right]);
        
        self.detailLabel.frame = CGRectMake(self.edge.left,
                                            CGRectGetMaxY(self.nameLabel.frame),
                                            CGRectGetWidth(self.frame)-self.edge.left-self.edge.right,detailLabelHeight);
        
        CGFloat selfHeight = MIN(CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetMaxY(self.detailLabel.frame)+self.edge.bottom);
        
        self.frame = CGRectMake(0,-selfHeight,CGRectGetWidth(self.frame),selfHeight);
    }


    [self setNeedsDisplay];
}
- (CGFloat)widthWithString:(NSString*)string fontSize:(CGFloat)fontSize height:(CGFloat)height
{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  [string boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.width;
}
- (CGFloat)heightWithString:(NSString*)string fontSize:(CGFloat)fontSize width:(CGFloat)width
{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  [string boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height;
}

#pragma mark -
#pragma mark  Gesture Event

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    
    if (LESS_IOS0_AND_ORIENTATION_PORTRAIT) {
        
        static CGFloat originX=0;
        
        CGPoint translatedPoint = [recognizer translationInView:self];
        CGFloat x = recognizer.view.center.x + translatedPoint.x;
        
        if (recognizer.state == UIGestureRecognizerStateBegan) {
            
            originX=recognizer.view.center.x;
        }
        if (recognizer.state == UIGestureRecognizerStateChanged) {
            
            if (x <= originX) {
                x=originX;
            }
        }
        if (recognizer.state == UIGestureRecognizerStateEnded) {
            
            if (x > originX) {
                
                [JKNotifier dismiss];
            }
        }
        recognizer.view.center = CGPointMake(x, recognizer.view.center.y);
        [recognizer setTranslation:CGPointMake(0, 0) inView:self];

        
    }else{
        
        static CGFloat originY=0;
        
        CGPoint translatedPoint = [recognizer translationInView:self];
        CGFloat y = recognizer.view.center.y + translatedPoint.y;
        
        if (recognizer.state == UIGestureRecognizerStateBegan) {
            
            originY=recognizer.view.center.y;
        }
        if (recognizer.state == UIGestureRecognizerStateChanged) {
            
            if (y >= originY) {
                y=originY;
            }
        }
        if (recognizer.state == UIGestureRecognizerStateEnded) {
            
            if (y < originY) {
                
                [JKNotifier dismiss];
            }
            originY=0;
        }
        recognizer.view.center = CGPointMake(recognizer.view.center.x, y);
        [recognizer setTranslation:CGPointMake(0, 0) inView:self];

    }
}
//-(void)swipeGesture:(UISwipeGestureRecognizer*)gesture{
//    
//    [JKNotifier dismiss];
////    [self removeWithAnimation];
//}
-(void)handleTap:(UIPanGestureRecognizer *)recognizer{
    
    if (_notifierBarClickBlock) {
        _notifierBarClickBlock(self.nameLabel.text?:@"",self.detailLabel.text?:@"",[JKNotifier shareInstance]);
    }
    
}
@end