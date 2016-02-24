//
//  LLShareButton.h
//  LLShareView
//
//  Created by ocarol on 16/2/19.
//  Copyright © 2016年 ocarol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLShareModel.h"

@class LLShareButton;
@protocol LLShareButtonDelegate <NSObject>
/** 分享按钮被点击时 */
- (void)LLShareButtonDidClick:(LLShareButton *)LLShareButton;
@end


@interface LLShareButton : UIButton

@property (nonatomic, weak) id<LLShareButtonDelegate> delegate;
@property (nonatomic, strong) LLShareModel *shareModel;


+ (instancetype)LLShareButtonWithShareModel:(LLShareModel *)shareModel;

+ (instancetype)LLShareButtonWithType:(LLShareType)shareType Rect:(CGRect)frame ButtonTitle:(NSString *)btntitle ButtonImage:(UIImage*)btnImg ShareTitle:(NSString *)shareTitle ShareDescription:(NSString *)shareDescription ShareThumbImage:(UIImage *)shareimage WebpageUrl:(NSString *)webpageUrl;

@end
