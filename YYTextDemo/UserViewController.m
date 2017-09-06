//
//  UserViewController.m
//  YYTextDemo
//
//  Created by app on 2017/9/6.
//  Copyright © 2017年 RJH. All rights reserved.
//

#import "UserViewController.h"
#import "YYText.h"
#import "UIView+YYAdd.h"
#import "YYImage.h"
#import "NSBundle+YYAdd.h"
#import "NSString+YYAdd.h"

@interface CellModel : NSObject

@property (nonatomic,strong) YYTextLayout *textLayout;
@property (nonatomic) CGFloat cellHeight;

@end


@implementation CellModel

@end



//=====================================分割线=========================================

@interface UserVCCell : UITableViewCell

@property (nonatomic,strong) CellModel *data;
@property (nonatomic, strong) YYLabel *contentLabel;

@end

@implementation UserVCCell


#define kWidth   280
#define kLabelMarginTop  10

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self addSubview:self.contentLabel];
    }
    return self;
}

-(void)setData:(CellModel *)data
{
    _data = data;
    YYTextLayout *layout = data.textLayout;
    self.contentLabel.textLayout = layout;
    self.contentLabel.size = layout.textBoundingSize;
}

-(YYLabel *)contentLabel
{
    if (_contentLabel == nil) {
        _contentLabel = [[YYLabel alloc] initWithFrame:CGRectMake((kScreenWidth - kWidth)/2.0, kLabelMarginTop, 0, 0)];
        _contentLabel.userInteractionEnabled = YES;
        _contentLabel.numberOfLines = 0;
        UIFont *font = [UIFont systemFontOfSize:16];
        _contentLabel.font = font;
        _contentLabel.displaysAsynchronously = YES; /// enable async display
        _contentLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
        [_contentLabel setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.2]];
    }
    return _contentLabel;
}
@end



//=====================================分割线=========================================



@interface UserViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataList;

@end

@implementation UserViewController

NSMutableAttributedString *attributeText;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [tableView registerClass:[UserVCCell class] forCellReuseIdentifier:@"tableCell"];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableArray *arrays = [NSMutableArray new];
        for (int i = 0; i<100; i++)
        {
            NSMutableAttributedString *text = [NSMutableAttributedString new];
            NSString *title11 = @"开始 ";
            [text appendAttributedString:[[NSAttributedString alloc] initWithString:title11 attributes:nil]];
            UIFont *font = [UIFont systemFontOfSize:16];
            NSArray *names = @[@"1", @"10", @"11",@"12",@"13",@"14", @"15", @"16",@"17",@"18",@"001", @"022", @"19",@"2",@"20",@"21", @"22", @"23",@"24",@"25",@"26", @"27",@"28",@"29",@"30",@"42", @"43", @"44",@"45",@"46",@"47", @"48", @"16",@"17",@"18",@"001", @"022", @"19",@"2",@"31",@"32", @"33", @"34",@"35",@"36",@"37", @"38",@"39",@"40",@"41"];
            
            for (int j = 0;j<names.count && j< arc4random()%names.count ;j++)
            {
                NSString *name  = names[j];
                NSString *path = [[NSBundle mainBundle] pathForScaledResource:name ofType:@"png" inDirectory:@"EmoticonQQ.bundle"];
                NSData *data = [NSData dataWithContentsOfFile:path];
                YYImage *image = [YYImage imageWithData:data scale:2];//修改表情大小
                image.preloadAllAnimatedImageFrames = YES;
                YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
                NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:imageView.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
                [text appendAttributedString:attachText];
                if(arc4random()%5==0)
                {
                    [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"这是乱七八糟的文字" attributes:nil]];
                }
            }
            
            [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"结束" attributes:nil]];
            YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kWidth, MAXFLOAT)];
            YYTextLayout *textLayout = [YYTextLayout layoutWithContainer:container text:text];
            
            CellModel *model = [[CellModel alloc] init];
            model.textLayout = textLayout;
            model.cellHeight = textLayout.textBoundingSize.height;
            [arrays addObject:model];
        }
        self.dataList = arrays;
        //更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableView reloadData];
        });
    });
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"tableCell";
    UserVCCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[UserVCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    CellModel *model = self.dataList[indexPath.row];
    cell.data = model;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellModel *model = self.dataList[indexPath.row];
    CGFloat height = model.cellHeight;
    return height + 2*kLabelMarginTop;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
