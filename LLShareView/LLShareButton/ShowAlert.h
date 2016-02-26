//
//  ShowAlert.h
//  LLShareViewDemo
//
//  Created by ocarol on 16/2/19.
//  Copyright © 2016年 ocarol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowAlert : NSObject

+ (void)showAlert:(id)context titleString:(NSString *)titleString messageString:(NSString *)messageString;

+ (void)showAlert:(id)context messageString:(NSString *)messageString;

@end
