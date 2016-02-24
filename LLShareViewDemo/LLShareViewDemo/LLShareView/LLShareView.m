//
//  LLShareView.m
//  LLShareView
//
//  Created by ocarol on 16/2/19.
//  Copyright © 2016年 ocarol. All rights reserved.
//

#import "LLShareView.h"
#import "LLShareButton.h"

#define ColorI(c) [UIColor colorWithRed:((c>>16)&0xff)/255.0 green:((c>>8)&0xff)/255.0 blue:(c&0xff)/255.0 alpha:1.0]
// 随机色
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]

@interface LLShareView()<LLShareButtonDelegate>
@property (nonatomic, strong) NSArray <LLShareModel *> *shareArray;
@property (nonatomic, weak)UIView *coverView;

@end


@implementation LLShareView

+ (instancetype)LLShareViewShareArray:(NSArray<LLShareModel *> *)shareArray {
    LLShareView *view = [[LLShareView alloc] init];
    view.shareArray = shareArray;
    
    return view;
}

- (void)setShareArray:(NSArray<LLShareModel *> *)shareArray {

    _shareArray = [shareArray copy];
    [self setupUI];
}

- (void)setupUI {

    CGFloat maxY = -1;
    for (int i = 0; i < self.shareArray.count; i++) {
        LLShareModel *model = self.shareArray[i];
        LLShareButton *shareBtn = [LLShareButton LLShareButtonWithShareModel:model];
        [self addSubview:shareBtn];
        shareBtn.delegate = self;
//        shareBtn.backgroundColor = RandomColor;
        CGFloat btnMAXY = model.btnRect.origin.y + model.btnRect.size.height;
        maxY = maxY > btnMAXY ? maxY : btnMAXY;
    }
    
    if (maxY > 0) {
        UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancleBtn setBackgroundColor:ColorI(0xebebeb)];
        cancleBtn.frame = CGRectMake(0, maxY, [UIScreen mainScreen].bounds.size.width, 54);
        
        [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancleBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [cancleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [cancleBtn addTarget:self action:@selector(clickCancleBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancleBtn];
        
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, CGRectGetMaxY(cancleBtn.frame));
        
    }
    
    self.backgroundColor = [UIColor whiteColor];

}

- (void)clickCancleBtn {

    [self remove:YES];

}

- (void)moveStartFromY1:(CGFloat)y1 ToY2:(CGFloat)y2 finish:(void(^)())finish {

    __block typeof(self) myself = self;
    __block CGRect rect = self.frame;
    rect.origin.y = y1;
    self.frame = rect;
    
    [UIView animateWithDuration:0.25f animations:^{
        rect.origin.y = y2;
        myself.frame = rect;
        
    } completion:^(BOOL finished) {
        if (finish != nil) {
             finish();
        }
    }];

}

- (void)showOnView:(UIView *)view {
    
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[LLShareView class]]) {
            [subview removeFromSuperview];
            break;
        }
    }
    
    if (self.coverView == nil) {
        UIView *cover = [[UIView alloc] initWithFrame:view.bounds];
        cover.backgroundColor = [UIColor blackColor];
        cover.alpha = 0.5f;
        [view addSubview:cover];
        self.coverView = cover;
    }
    self.coverView.hidden = NO;
    
    [view addSubview:self];
    
    CGFloat startY = self.superview.bounds.size.height;
    CGFloat endY = startY - self.frame.size.height;
    [self moveStartFromY1:startY ToY2:endY finish:nil];
    
    
   
}

- (void)LLShareButtonDidClick:(LLShareButton *)LLShareButton {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(LLShareButtonDidClick)]) {
        [self.delegate LLShareButtonDidClick];
    }
}

- (void)show {
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIView *topView = window.subviews[0];
    [self showOnView:topView];
  
}

- (void)hidden {

    [self hiddenWithFinish:nil];

}

- (void)hiddenWithFinish:(void(^)())finish {
    self.coverView.hidden = YES;
    CGFloat startY = self.frame.origin.y;
    CGFloat endY = self.superview.bounds.size.height;
    
    [self moveStartFromY1:startY ToY2:endY finish:finish];
}

- (void)remove {
    
    [self removeFromSuperview];
    [self.coverView removeFromSuperview];
    self.coverView = nil;
    
}

- (void)remove:(BOOL)animated {
    if (animated == YES) {
        [self hiddenWithFinish:^{
            [self remove];
        }];
    }else {
        [self remove];
    }
}
@end
