//
//  LLShareView.h
//  LLShareView
//
//  Created by ocarol on 16/2/19.
//  Copyright © 2016年 ocarol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLShareModel.h"

@protocol LLShareViewDelegate <NSObject>
/** 分享按钮被点击时 */
- (void)LLShareButtonDidClick;
@end


@interface LLShareView : UIView

@property (nonatomic, weak) id<LLShareViewDelegate> delegate;

+ (instancetype)LLShareViewShareArray:(NSArray<LLShareModel *> *)shareArray;
- (void)show;
- (void)showOnView:(UIView *)view;
- (void)hidden;
- (void)hiddenWithFinish:(void(^)())finish;
- (void)remove:(BOOL)animated;
@end
