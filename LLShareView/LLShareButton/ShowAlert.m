//
//  ShowAlert.m
//  LLShareViewDemo
//
//  Created by ocarol on 16/2/19.
//  Copyright © 2016年 ocarol. All rights reserved.
//

#import "ShowAlert.h"
#import <UIKit/UIKit.h>

@implementation ShowAlert

+ (void)showAlert:(id)context titleString:(NSString *)titleString messageString:(NSString *)messageString {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:titleString
                                                          message:messageString
                                                         delegate:context
                                                cancelButtonTitle:@"确定"
                                                otherButtonTitles:nil];
        [myAlert show];
    });
}

+ (void)showAlert:(id)context messageString:(NSString *)messageString {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle: @"提示"
                                                          message:messageString
                                                         delegate:context
                                                cancelButtonTitle: @"确定"
                                                otherButtonTitles:nil];
        [myAlert show];
        
    });
}

@end
