//
//  HeaderVC.m
//  顶部视图放大
//
//  Created by autobot on 17/1/11.
//  Copyright © 2017年 autobot. All rights reserved.
//

#import "HeaderVC.h"
#import "DDObjc_Sugar.h"
//#import  "UIImageView+AFNetworking.h"
//#import <YYWebImage.h>
#import "YYWebImage.h"
@interface HeaderVC ()<UITableViewDelegate,UITableViewDataSource>{
    UIView *_headerView;
    UIImageView *_headerImageView;
    UIView *_lineView;
    UIStatusBarStyle  _statusBarStyle;
}

@end

@implementation HeaderVC
NSString *const cellId = @"cellId";
#define KHeaderHeight 200
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self prepareTableView];
    [self prepareHeaderView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return _statusBarStyle;
}

/**
 准备表格视图
 */
- (void)prepareTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    tableView.contentInset = UIEdgeInsetsMake(KHeaderHeight, 0, 0, 0);
    tableView.scrollIndicatorInsets = UIEdgeInsetsMake(KHeaderHeight, 0, 0, 0);
}

/**
 准备顶部试图
 */
- (void)prepareHeaderView{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.dd_width, KHeaderHeight)];
    _headerView.backgroundColor = [UIColor dd_colorWithHex:0xf8f8f8];
    [self.view addSubview:_headerView];
    
   _headerImageView = [[UIImageView alloc]initWithFrame:_headerView.bounds];
    _headerImageView.backgroundColor = [UIColor blueColor];
    //contentMode
    _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headerImageView.clipsToBounds = YES;
    [_headerView addSubview:_headerImageView];
    
    //添加一个分割线
    CGFloat lineHeight = 1/[UIScreen mainScreen].scale;
     _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, KHeaderHeight-lineHeight, self.view.dd_width, lineHeight)];
    _lineView.backgroundColor = [UIColor lightGrayColor];
//    _lineView.layer.shadowColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0].CGColor;
//    _lineView.layer.shadowOffset = CGSizeMake(0, lineHeight);
    [_headerView addSubview:_lineView];
    
    
    //设置图像
    NSURL *url = [NSURL URLWithString:@"http://www.who.int/campaigns/immunization-week/2015/large-web-banner.jpg?ua=1"];
    [_headerImageView yy_setImageWithURL:url options:YYWebImageOptionShowNetworkActivity];
    
    
}

#pragma mark -------------------TableViewDataSoure&&Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.y+scrollView.contentInset.top;
    if (offset<=0) {
        _headerView.dd_y = 0;
        _headerView.dd_height = KHeaderHeight - offset;
    }else{
        _headerView.dd_height = KHeaderHeight ;
        _headerView.dd_y = -offset;
        // headerView 最小y值
        CGFloat min = KHeaderHeight - 64;
        _headerView.dd_y = -MIN(min, offset);
        //设置透明度
        CGFloat alpha = 1- (offset/min);
        _headerImageView.alpha = alpha;
        _statusBarStyle = (alpha<0.5)?UIStatusBarStyleDefault:UIStatusBarStyleLightContent;
        [self.navigationController setNeedsStatusBarAppearanceUpdate];
    }
    _headerImageView.dd_height = _headerView.dd_height;

    _lineView.dd_y = _headerView.dd_height - _lineView.dd_height;
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
