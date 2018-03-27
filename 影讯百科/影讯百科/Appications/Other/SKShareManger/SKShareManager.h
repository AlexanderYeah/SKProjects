//
//  SKShareManager.h
//  Lottery
//
//  Created by g1game on 16/5/14.
//  Copyright © 2016年 g1game. All rights reserved.
//


#define Umeng_AppKey @"5735713d67e58efc06001c49"

#define WX_Appkey @"wx910504abc92e543a"
#define WX_AppSecret @"ff037a51dafcc6ec54da4386ec95994f"
#define ShareUrl @"www.baidu.com"


#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

@interface SKShareManager : NSObject<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>

+ (SKShareManager *)shareManager;

// 1 微信分享
- (void)wechatShareWithViewController:(UIViewController *)viewVC withShareText:(NSString*)text withShareUrl:(NSString *)shareUrl;

// 2 朋友圈分享
- (void)timelineShareWithViewController:(UIViewController *)viewVC withShareText:(NSString*)text withShareUrl:(NSString *)shareUrl;;

// 3 短信分享
- (void)messageShareWithViewController:(UIViewController *)viewVC withShareText:(NSString*)text withShareUrl:(NSString *)shareUrl;;

// 4 邮件分享
- (void)emailShareWithViewController:(UIViewController *)viewVC withShareText:(NSString*)text withShareUrl:(NSString *)shareUrl;;


- (void)shareConfig;

@end
