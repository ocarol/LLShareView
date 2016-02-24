//
//  LLShareModel.h
//  LLShareView
//
//  Created by ocarol on 16/2/19.
//  Copyright © 2016年 Botpy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/** 分享移动端类型*/
typedef enum : NSUInteger {
    LLShareTypeSMS = 0, // 短信
    LLShareTypeWXSceneSession, // 微信会话
    LLShareTypeWXSceneTimeline // 微信朋友圈
} LLShareType;


@interface LLShareModel : NSObject

@property (nonatomic, assign) LLShareType shareType;
@property (nonatomic, copy) NSString *shareTitle;
@property (nonatomic, copy) NSString *shareDescription;
@property (nonatomic, strong) UIImage *shareimage;
@property (nonatomic, copy) NSString *webpageUrl;
@property (nonatomic, assign) CGRect btnRect;
@property (nonatomic, copy) NSString *btnTitle;
@property (nonatomic, strong) UIImage *btnImg;

@end
