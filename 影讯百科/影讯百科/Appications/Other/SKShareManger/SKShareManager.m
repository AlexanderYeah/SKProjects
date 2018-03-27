//
//  SKShareManager.m
//  Lottery
//
//  Created by g1game on 16/5/14.
//  Copyright © 2016年 g1game. All rights reserved.
//

#import "SKShareManager.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "WXApi.h"

@interface SKShareManager ()

{
    UIViewController *_viewVC;
    MFMailComposeViewController *_mailVC;
}


@end

@implementation SKShareManager

static SKShareManager *shareManager;

// 1 单例方法

+(SKShareManager *)shareManager
{
    @synchronized(self) {
        if (shareManager == nil) {
            shareManager = [[self alloc]init];
        }
        
        return shareManager;
    }
}

#pragma mark - 注册友盟分享微信 

-(void)shareConfig
{
    // 设置友盟社会化组件appKey
    [UMSocialData setAppKey:Umeng_AppKey];
    [UMSocialData openLog:NO];
    
    // 注册微信
    [WXApi registerApp:WX_Appkey];
    
    // 设置图文分享
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
    
}


#pragma mark - 微信分享

- (void)wechatShareWithViewController:(UIViewController *)viewVC withShareText:(NSString*)text withShareUrl:(NSString *)shareUrl;
{
    _viewVC = viewVC;
    [[UMSocialControllerService defaultControllerService] setShareText:text shareImage:nil socialUIDelegate:nil];
    [UMSocialWechatHandler setWXAppId:WX_Appkey appSecret:WX_AppSecret url:shareUrl];

    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession].snsClickHandler(viewVC,[UMSocialControllerService defaultControllerService],YES);
}


#pragma mark - 朋友圈分享 
- (void)timelineShareWithViewController:(UIViewController *)viewVC withShareText:(NSString*)text withShareUrl:(NSString *)shareUrl;
{
    _viewVC = viewVC;
    [[UMSocialControllerService defaultControllerService] setShareText:text shareImage:nil socialUIDelegate:nil];
    [UMSocialWechatHandler setWXAppId:WX_Appkey appSecret:WX_AppSecret url:shareUrl];
    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatTimeline ].snsClickHandler(viewVC,[UMSocialControllerService defaultControllerService],YES);
    
}

#pragma mark- 短信分享 
- (void)messageShareWithViewController:(UIViewController *)viewVC withShareText:(NSString*)text withShareUrl:(NSString *)shareUrl;
{
    
    _viewVC = viewVC;
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if (messageClass != nil) {
        [self displaySMSComposerSheetWithUrl:shareUrl];
    }

}


#pragma mark - 短信的代理方法 
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    switch (result) {
        case MessageComposeResultCancelled:
                        break;
         case MessageComposeResultSent:
           
            break;
        case MessageComposeResultFailed:
          
            break;
        default:
            break;
    }
}



- (void)displaySMSComposerSheetWithUrl:(NSString *)urlStr
{
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc]init];
    picker.messageComposeDelegate = self;
    picker.navigationBar.tintColor = [UIColor blackColor];
    
    picker.body = urlStr;
    [_viewVC presentViewController:picker animated:YES completion:nil];

}


-(void)emailShareWithViewController:(UIViewController *)viewVC withShareText:(NSString*)text withShareUrl:(NSString *)shareUrl;
{
    
    _viewVC = viewVC;
    _mailVC = [[MFMailComposeViewController alloc]init];
    // 判断是否可以发短信
    if ([MFMailComposeViewController canSendMail]) {
        // 1 设置代理
        _mailVC.mailComposeDelegate = self;
        // 2 收件人
        [_mailVC setToRecipients:@[@"1023954998@qq.com"]];
        // 3 抄送
        [_mailVC setCcRecipients:@[@""]];
        // 4 密送
        [_mailVC setBccRecipients:@[@""]];
        // 5 主题
        [_mailVC setSubject:@"you are good man"];
        // 6 正文
        [_mailVC setMessageBody:@"so handsome" isHTML:NO];
        // 7 附件
        
        
        [viewVC presentViewController:_mailVC animated:YES completion:nil];
    }
    
}


#pragma mark -  发邮件代理方法 
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
        switch (result) {
        case MFMailComposeResultCancelled:
            
            break;
        case MFMailComposeResultFailed:
          
            break;
        case MFMailComposeResultSaved:
           
            break;
        case MFMailComposeResultSent:
           
            break;

        default:
            break;
    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}









@end
