//
//  ShareView.m
//  Lottery
//
//  Created by g1game on 16/5/13.
//  Copyright © 2016年 g1game. All rights reserved.
//

#import "ShareView.h"
#import "ShareButton.h"
@implementation ShareView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    
    return self;
}


#pragma mark - 创建UI 界面 
- (void)createUI
{
    // 1 分享到Lbl
    UILabel *shareLbl = [self createLblWithTitle:@"分享到"];
    shareLbl.font = [UIFont systemFontOfSize:19.0f];
    shareLbl.frame = CGRectMake(0, 0, kScreenW, 40);
    shareLbl.textColor = [UIColor orangeColor];
    [self addSubview:shareLbl];
    
    // 2 分享按钮
    NSArray *titleArr = @[@"微信朋友圈",@"微信",@"短信",@"邮件"];
    NSArray *imageArr = @[@"分享-icon-微信朋友圈",@"分享-icon-微信",@"分享-icon-新浪微博",@"分享-icon-QQ"];
    CGFloat btnW = 60;
    CGFloat margin = (kScreenW - btnW * 4 - 20 * 3) / 2;
    for (int i = 0 ; i < 4 ; i ++) {
        ShareButton *btn = [[ShareButton alloc]init];
        btn.tag = 660 + i;
        if (i == 0 ) {
            btn.frame = CGRectMake(margin + btnW * i , 40 , btnW , 80);
        }else{
            btn.frame = CGRectMake(margin + btnW * i + i * 20, 40 , btnW , 80);
        }
        
        
        [self addSubview:btn];
        [btn setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
    
    }
    
    
    // 3 取消Lbl
    UIButton *cancleBtn  = [self createBtnWithTitle:@"取消"];
    cancleBtn.tag = 666;
    [cancleBtn setTitleColor:[UIColor colorWithRed:121/255.0f green:121/255.0f blue:121/255.0f alpha:1] forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    cancleBtn.frame = CGRectMake(0, 127, kScreenW, 50);
    [self addSubview:cancleBtn];
    
    // 4 分割线view
    UIView *sepView = [[UIView alloc]init];
    sepView.backgroundColor = [UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1];
    [self addSubview:sepView];
    [sepView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(cancleBtn.top).offset(6);
        make.left.equalTo(self.left);
        make.right.equalTo(self.right);
        make.height.equalTo(0.5);
    }];
    
    self.frame =CGRectMake(0, kScreenH, kScreenW, 180);
    
    [self setNeedsDisplay];
    
    
}

- (UILabel *)createLblWithTitle:(NSString *)title

{
    
    UILabel *label = [[UILabel alloc]init];
    
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont systemFontOfSize:14.0f];
    
    return label;
    
}
- (UIButton *)createBtnWithTitle:(NSString *)title
{
    
    UIButton *btn = [[UIButton alloc]init];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    
    return btn;
    
}





@end
