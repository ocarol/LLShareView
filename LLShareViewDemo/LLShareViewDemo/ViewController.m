//
//  ViewController.m
//  LLShareViewDemo
//
//  Created by ocarol on 16/2/19.
//  Copyright © 2016年 ocarol. All rights reserved.
//

#import "ViewController.h"
#import "LLShareView.h"

#define KScreenWidth [[UIScreen mainScreen] bounds].size.width
#define KScreenHeight [[UIScreen mainScreen] bounds].size.height
#define AutoSizeScaleY (KScreenHeight > 480 ? KScreenHeight/568 : 1.0)

@interface ViewController ()<LLShareViewDelegate>
@property (nonatomic, weak)LLShareView *shareView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showShareView];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)share:(id)sender {
    [self showShareView];
}

- (void)showShareView {
    UIImage *logo = [UIImage imageNamed:@"icon-share-wechat"];
    logo = [self imaga:logo scaleToWxSize:CGSizeMake(200, ((200 / logo.size.width) * logo.size.height))];
    
    // 微信
    UIImage *WXSSImage = [UIImage imageNamed:@"icon-share-wechat"];
    NSString *WXSSTtitle = @"最新一期的codereview精彩案例！";
    NSString *WXSSStr = @"分享图片超长干货《话谈 iOS 目录结构的划分》，最新一期的codereview精彩案例，来自@lzwjava";
    LLShareModel *WXSSModel = [self modelWithindex:0 Type:LLShareTypeWXSceneSession ButtonTitle:@"微信" ButtonImage:WXSSImage ShareTitle:WXSSTtitle ShareDescription:WXSSStr ShareThumbImage:logo WebpageUrl:@"http://t.cn/RG9cuMF"];
    
    // 朋友圈
    UIImage *WXSTSImage = [UIImage imageNamed:@"icon-share-friendcircle"];
    NSString *WXSTTtitle = @"CocoaPods 的核心开发者 Olivier 讲述他的开源之旅。为什么大家喜欢开源？如何参与开源？参与开源有什么收获？来看看他的故事。译者@请叫我_小锅_";
    LLShareModel *WXSTSModel = [self modelWithindex:1 Type:LLShareTypeWXSceneTimeline ButtonTitle:@"朋友圈" ButtonImage:WXSTSImage ShareTitle:WXSTTtitle ShareDescription:nil ShareThumbImage:logo WebpageUrl:@"http://t.cn/RG9quf1"];
    
    // 短信
    UIImage *SMSImage = [UIImage imageNamed:@"icon-share-message"];
    NSString *SMSStr = @"iOS 事件处理机制与图像渲染过程 - 微信开发团队出品的：iOS 事件处理机制与图像渲染过程。分享by@NeXT___ 详戳→";
    NSString *SMSDes = [NSString stringWithFormat:@"%@:%@",SMSStr,@"http://t.cn/RUnsMfJ"];
    LLShareModel *SMSModel = [self modelWithindex:2 Type:LLShareTypeSMS ButtonTitle:@"短信" ButtonImage:SMSImage ShareTitle:nil ShareDescription:SMSDes ShareThumbImage:nil WebpageUrl:nil];
    
    LLShareView *shareView = [LLShareView LLShareViewShareArray:@[WXSSModel,WXSTSModel,SMSModel]];
    shareView.delegate = self;
    [shareView showOnView:self.view];
    self.shareView = shareView;
    
}

- (LLShareModel *)modelWithindex:(int)index Type:(LLShareType)shareType ButtonTitle:(NSString *)btntitle ButtonImage:(UIImage*)btnImg ShareTitle:(NSString *)shareTitle ShareDescription:(NSString *)shareDescription ShareThumbImage:(UIImage *)shareimage WebpageUrl:(NSString *)webpageUrl{
    
    CGFloat btnW = KScreenWidth / 4.0f;
    
    LLShareModel *model = [[LLShareModel alloc] init];
    model.shareType = shareType;
    model.shareTitle = shareTitle;
    model.shareDescription = shareDescription;
    model.shareimage = shareimage;
    model.webpageUrl = webpageUrl;
    model.btnRect = CGRectMake(index * btnW, 0, btnW, 100 * AutoSizeScaleY);
    model.btnImg = btnImg;
    model.btnTitle = btntitle;
    
    return model;
}

- (UIImage *)imaga:(UIImage *)img scaleToWxSize:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}


-(void)LLShareButtonDidClick {
    [self.shareView remove:NO];
}

@end
