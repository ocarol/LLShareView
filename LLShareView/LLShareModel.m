//
//  LLShareModel.m
//  LLShareView
//
//  Created by ocarol on 16/2/19.
//  Copyright © 2016年 Botpy. All rights reserved.
//

#import "LLShareModel.h"

#define KLLScreenWidth [[UIScreen mainScreen] bounds].size.width
#define KLLScreenHeight [[UIScreen mainScreen] bounds].size.height
#define LLShareScaleX (KLLScreenHeight > 480 ? KLLScreenWidth/320 : 1.0)
#define LLShareScaleY (KLLScreenHeight > 480 ? KLLScreenHeight/568 : 1.0)

@implementation LLShareModel

+ (LLShareModel *)LLShareModelWithindex:(int)index total:(int) total Type:(LLShareType)shareType ButtonTitle:(NSString *)btntitle ButtonImage:(UIImage*)btnImg ShareTitle:(NSString *)shareTitle ShareDescription:(NSString *)shareDescription ShareThumbImage:(UIImage *)shareimage WebpageUrl:(NSString *)webpageUrl {
    
    CGFloat btnW = [UIScreen mainScreen].bounds.size.width / total;
    
    LLShareModel *model = [[LLShareModel alloc] init];
    model.shareType = shareType;
    model.shareTitle = shareTitle;
    model.shareDescription = shareDescription;
    model.shareimage = shareimage;
    model.webpageUrl = webpageUrl;
    model.btnRect = CGRectMake(index * btnW, 0, btnW, 100 * LLShareScaleY);
    model.btnImg = btnImg;
    model.btnTitle = btntitle;
    
    return model;
}

