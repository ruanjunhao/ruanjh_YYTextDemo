//
//  ViewController.m
//  YYTextDemo
//
//  Created by app on 2017/9/6.
//  Copyright © 2017年 RJH. All rights reserved.
//

#import "ViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "UserViewController.h"

@interface ViewController ()

@property(nonatomic,strong) NSArray *dataArray;




@end

@implementation ViewController


//- (NSArray *)dataArray
//{
//    if (!_dataArray) {
//        _dataArray = [NSMutableArray array];
//    }
//    
//    return _dataArray;
//}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[@"qq号要求高亮并且可以点击",@"...全文",@"YYLabel聊天表情+文字并排"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
//        cell.backgroundColor = [UIColor grayColor];
        
    }
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];//[NSString stringWithFormat:@"indexPatch__%zd",indexPath.row];
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        OneViewController *one = [[OneViewController alloc] init];
        [self.navigationController pushViewController:one animated:YES];
    }else if (indexPath.row == 1) {
        
        TwoViewController *one = [[TwoViewController alloc] init];
        [self.navigationController pushViewController:one animated:YES];
        
    }else if (indexPath.row == 2) {
        
        UserViewController *one = [[UserViewController alloc] init];
        [self.navigationController pushViewController:one animated:YES];
    }
    
}




@end
