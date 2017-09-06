//
//  OneViewController.m
//  YYTextDemo
//
//  Created by app on 2017/9/6.
//  Copyright © 2017年 RJH. All rights reserved.
//

#import "OneViewController.h"
#import "YYText.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    YYLabel *yyLabel = [YYLabel new];
    [self.view addSubview:yyLabel];
    
    yyLabel.numberOfLines = 0;
    yyLabel.frame = CGRectMake(60, 100, 180,60);
    yyLabel.backgroundColor = [UIColor whiteColor];
    NSString *totalStr = @"添加QQ 670360112 进行在线咨询";
    NSString *hightStr = @"670360112";
    
    NSRange hightStrRange = [totalStr rangeOfString:hightStr];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:totalStr];
    text.yy_font =[UIFont systemFontOfSize:14];
    text.yy_color = [UIColor blackColor];
    
    [text yy_setTextHighlightRange:hightStrRange
                             color:[UIColor blueColor]
                   backgroundColor:[UIColor grayColor]
                         tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                             UIPasteboard *pboard = [UIPasteboard generalPasteboard];
                             pboard.string = @"670360112";
                             NSLog(@"复制str__%@ range__%@",text.string,NSStringFromRange(range));

                             
                         }];
    
    [text yy_setTextUnderline:[YYTextDecoration decorationWithStyle:YYTextLineStyleSingle] range:hightStrRange];
    
    yyLabel.attributedText = text;
    [yyLabel sizeToFit];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
