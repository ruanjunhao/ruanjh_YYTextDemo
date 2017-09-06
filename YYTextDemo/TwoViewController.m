//
//  TwoViewController.m
//  YYTextDemo
//
//  Created by app on 2017/9/6.
//  Copyright © 2017年 RJH. All rights reserved.
//

#import "TwoViewController.h"
#import "YYText.h"
#import "UIView+Extension.h"



@interface TwoViewController ()

@property(nonatomic,strong) YYLabel *label;


@property(nonatomic,strong) UIView *belowView;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    UIFont *font = [UIFont systemFontOfSize:16];
    
    
    //添加文本
    NSString *title =@"豫章故郡，洪都新府。星分翼轸，地接衡庐。襟三江而带五湖，控蛮荆而引瓯越。物华天宝，龙光射牛斗之墟；人杰地灵，徐孺下陈蕃之榻。雄州雾列，俊采星驰。台隍枕夷夏之交，宾主尽东南之美。都督阎公之雅望，棨戟遥临；宇文新州之懿范，襜帷暂驻。十旬休假，胜友如云；千里逢迎，高朋满ajy座。腾蛟起凤，孟学士之词宗；紫电青霜，王将军之武库。家君作宰，路出名区；童子何知，躬逢胜饯。时维九月，序属三秋。潦水尽而寒潭清，烟光凝而暮山紫。俨骖騑于上路，访风景于崇阿。临帝子之长洲，得仙人之旧馆。层台耸翠，上出重霄；飞阁流丹，下临无地。鹤汀凫渚，穷岛屿之萦回；桂殿兰宫，列冈峦之体势。";
    
    [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:nil]];
    
    text.yy_font = font ;
    
    
 
    
    
    
    //    CGSize textSize = [title sizeWithFont:font maxW:260];
    //     NSLog(@"textSize1__%@",NSStringFromCGSize(textSize));
    //
    //
    //
    //    CGSize contentSize = [text boundingRectWithSize:CGSizeMake(260, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    //     NSLog(@"contentSize__%@",NSStringFromCGSize(contentSize));
    
    
    _label = [YYLabel new];
    _label.userInteractionEnabled =YES;
    _label.numberOfLines =0;
    _label.textVerticalAlignment =YYTextVerticalAlignmentCenter;
    _label.frame = CGRectMake(30,80, 260,160);
    _label.attributedText = text;
    [self.view addSubview:_label];
   
    
    _label.layer.borderWidth =0.5;
    _label.layer.borderColor = [UIColor colorWithRed:0.000 green:0.463 blue:1.000 alpha:1.000].CGColor;
    
    
//     [_label sizeToFit];
//    //代码计算全部的高度
//    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(260, MAXFLOAT)];
//    YYTextLayout *textLayout = [YYTextLayout layoutWithContainer:container text:text];
//    
//   CGSize calueSize = textLayout.textBoundingSize;
//    NSLog(@"_label.frame代码计算size__%@",    NSStringFromCGSize(calueSize));
//
//    
//    
//
//    
//    NSLog(@"_label.frame显示的size__%@",NSStringFromCGRect(_label.frame));
//    
    
    [self addSeeMoreButton];
    
    UIView *belowView = [[UIView alloc] initWithFrame:CGRectMake(30, 0, 200, 60)];
    belowView.backgroundColor = [UIColor redColor];
    [self.view addSubview:belowView];
    self.belowView = belowView;
    
    
    [self changeBelowView];
}


- (void)changeBelowView {
    
    CGFloat bY = CGRectGetMaxY(_label.frame) + 20;
    
    self.belowView.y = bY;
    
}

- (void)addSeeMoreButton {
    __weak typeof(self) _self =self;
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"...全文"];
    
    YYTextHighlight *hi = [YYTextHighlight new];
    [hi setColor:[UIColor colorWithRed:0.578 green:0.790 blue:1.000 alpha:1.000]];
    hi.tapAction = ^(UIView *containerView,NSAttributedString *text,NSRange range, CGRect rect) {
        YYLabel *label = _self.label;
        [label sizeToFit];
       [_self changeBelowView];
    };
    
    
    [text yy_setColor:[UIColor colorWithRed:0.000 green:0.449 blue:1.000 alpha:1.000]range:[text.string rangeOfString:@"全文"]];
    [text yy_setTextHighlight:hi range:[text.string rangeOfString:@"全文"]];
    text.yy_font =_label.font;
    
    YYLabel *seeMore = [YYLabel new];
    seeMore.attributedText = text;
    [seeMore sizeToFit];
    
    NSAttributedString *truncationToken = [NSAttributedString yy_attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter attachmentSize:seeMore.frame.size alignToFont:text.yy_font alignment:YYTextVerticalAlignmentCenter];
    _label.truncationToken = truncationToken;
}

@end
