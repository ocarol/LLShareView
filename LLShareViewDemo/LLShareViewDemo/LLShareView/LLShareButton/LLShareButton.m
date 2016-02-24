//
//  LLShareButton.m
//  LLShareView
//
//  Created by ocarol on 16/2/19.
//  Copyright © 2016年 ocarol. All rights reserved.
//

#import "LLShareButton.h"
#import "ShowAlert.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "WXApi.h"

#define padding  10
#define LableH 15

@interface LLShareButton()<WXApiDelegate,UIActionSheetDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>
@end


@implementation LLShareButton

+ (instancetype)LLShareButtonWithShareModel:(LLShareModel *)shareModel {
    
    LLShareButton *shareBtn = [LLShareButton buttonWithType:UIButtonTypeCustom];
    [shareBtn addTarget:shareBtn action:@selector(didclickBtn) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    shareBtn.frame = shareModel.btnRect;
    [shareBtn setImage:shareModel.btnImg forState:UIControlStateNormal];
    [shareBtn setTitle:shareModel.btnTitle forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.shareModel = shareModel;

    return shareBtn;
}

+ (instancetype)LLShareButtonWithType:(LLShareType)shareType Rect:(CGRect)frame ButtonTitle:(NSString *)btntitle ButtonImage:(UIImage*)btnImg ShareTitle:(NSString *)shareTitle ShareDescription:(NSString *)shareDescription ShareThumbImage:(UIImage *)shareimage WebpageUrl:(NSString *)webpageUrl{
    
    LLShareModel *model = [[LLShareModel alloc] init];
    
    model.shareType = shareType;
    model.shareTitle = shareTitle;
    model.shareDescription = shareDescription;
    model.shareimage = shareimage;
    model.webpageUrl = webpageUrl;
    model.btnRect = frame;
    model.btnImg = btnImg;
    model.btnTitle = btntitle;
    
    return [self LLShareButtonWithShareModel:model];

}

- (void)didclickBtn {

    switch (self.shareModel.shareType) {
        case LLShareTypeSMS :  // 短信
            [self LLShareSMS];
            break;
        case LLShareTypeWXSceneSession:// 微信会话
            [self LLShareWXSceneSession];
            break;
        case LLShareTypeWXSceneTimeline:// 微信朋友圈
            [self LLShareWXSceneTimeline];
            break;
        default:
            break;
    }

    if (self.delegate !=nil && [self.delegate respondsToSelector:@selector(LLShareButtonDidClick:)]) {
        [self.delegate LLShareButtonDidClick:self];
    }
}


#pragma mark 短信分享
- (void)LLShareSMS {

    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if (messageClass != nil) {
        if ([messageClass canSendText]) {
            
            MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
            picker.messageComposeDelegate = self;
            picker.body  = self.shareModel.shareDescription;
            UIViewController *rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
            [rootVc presentViewController:picker animated:YES completion:nil];
            
        } else {
            [ShowAlert showAlert:self messageString:@"你的设备无法发送短信"];
        }
    }

}

#pragma mark 短信回调
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {

    switch (result)
    {
        case MessageComposeResultCancelled: // 取消短信发送
            break;
        case MessageComposeResultSent: // 短信已发出
            break;
        case MessageComposeResultFailed: // 短信发送失败
            break;
        default:  // 短信未发送
            break;
    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark 微信分享
/** 发送的目标场景，可以选择发送到会话(WXSceneSession)或者朋友圈(WXSceneTimeline)。 默认发送到会话。
 * @see WXScene 0、会话界面(WXSceneSession)；1、朋友圈(WXSceneTimeline)；2、收藏(WXSceneFavorite)
 */
- (void)LLShareWXWithScene:(int)scene {
    
    if ([WXApi isWXAppInstalled]) {
        
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.scene = scene;
        
        // 文本消息和多媒体消息两种，两者只能选择其一
        
        if (self.shareModel.webpageUrl) {
            
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = self.shareModel.shareTitle;
            message.description = self.shareModel.shareDescription;
            
            if (self.shareModel.shareimage) {
                [message setThumbImage:self.shareModel.shareimage];
            }
            
            WXWebpageObject *ext = [WXWebpageObject object];
            ext.webpageUrl = self.shareModel.webpageUrl;
            message.mediaObject = ext;
            
            req.bText = NO;
            req.message = message;
            
        }else {
        
            req.bText = YES;
            req.text = self.shareModel.shareDescription;
        }
        
         BOOL isSendReq = [WXApi sendReq:req];
        if (!isSendReq) {
            
        }
        
    } else {
        
        [ShowAlert showAlert:self messageString:@"您还未安装微信客户端！"];
    }
    
}

#pragma mark 微信会话分享
- (void)LLShareWXSceneSession {
    [self LLShareWXWithScene:0];
}

#pragma mark 微信朋友圈分享
- (void)LLShareWXSceneTimeline {
    [self LLShareWXWithScene:1];
}


// 自定义UIButton图片与文字的位置
- (CGFloat)imageW:(CGRect)contentRect {

    CGFloat resultWBaseW = contentRect.size.width - 4 * padding;
    CGFloat resultWBaseH = contentRect.size.height - 5 * padding - LableH;
    
    return resultWBaseW > resultWBaseH ? resultWBaseH : resultWBaseW;
}

//图片的位置大小z
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imgW = [self imageW:contentRect];
    return CGRectMake((contentRect.size.width - imgW)/2.0f, (contentRect.size.height - padding - LableH - imgW) /2.0,imgW,imgW);
}

//文本的位置大小
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat imgW = [self imageW:contentRect];
    return CGRectMake(0, (contentRect.size.height - padding - LableH - imgW) /2.0 + padding + imgW, contentRect.size.width, 15);
}
@end
