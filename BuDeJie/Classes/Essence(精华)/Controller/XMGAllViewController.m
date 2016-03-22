//
//  XMGAllViewController.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/18.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGAllViewController.h"

@interface XMGAllViewController ()
/** 数据量 */
@property (nonatomic, assign) NSInteger dataCount;

/** 上拉刷新控件 */
@property (nonatomic, weak) UIView *footer;
/** 上拉刷新控件里面的文字 */
@property (nonatomic, weak) UILabel *footerLabel;
/** 上拉刷新控件时候正在刷新 */
@property (nonatomic, assign, getter=isFooterRefreshing) BOOL footerRefreshing;
@end

@implementation XMGAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataCount = 10;
    
    self.view.backgroundColor = XMGRandomColor;
    
    self.tableView.contentInset = UIEdgeInsetsMake(XMGNavMaxY + XMGTitlesViewH, 0, XMGTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:XMGTabBarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:XMGTitleButtonDidRepeatClickNotification object:nil];
    
    [self setupRefresh];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupRefresh
{
    UIView *footer = [[UIView alloc] init];
    footer.frame = CGRectMake(0, 0, self.tableView.xmg_width, 35);
    self.footer = footer;
    
    UILabel *footerLabel = [[UILabel alloc] init];
    footerLabel.frame = footer.bounds;
    footerLabel.backgroundColor = [UIColor redColor];
    footerLabel.text = @"上拉可以加载更多";
    footerLabel.textColor = [UIColor whiteColor];
    footerLabel.textAlignment = NSTextAlignmentCenter;
    [footer addSubview:footerLabel];
    self.footerLabel = footerLabel;
    
    self.tableView.tableFooterView = footer;
}

#pragma mark - 监听
/**
 *  监听tabBarButton重复点击
 */
- (void)tabBarButtonDidRepeatClick
{
    // 重复点击的不是精华按钮
    if (self.view.window == nil) return;
    
    // 显示在正中间的不是AllViewController
    if (self.tableView.scrollsToTop == NO) return;
    
    XMGLog(@"%@ - 刷新数据", self.class)
}

/**
 *  监听titleButton重复点击
 */
- (void)titleButtonDidRepeatClick
{
    [self tabBarButtonDidRepeatClick];
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 根据数据量显示或者隐藏footer
    self.footer.hidden = (self.dataCount == 0);
    return self.dataCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%zd", self.class, indexPath.row];
    return cell;
}

#pragma mark - 代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 还没有任何内容的时候，不需要判断
    if (self.tableView.contentSize.height == 0) return;
    
    // 如果正在刷新，直接返回
    if (self.isFooterRefreshing) return;
    
    // 当scrollView的偏移量y值 >= offsetY时，代表footer已经完全出现
    CGFloat ofsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.xmg_height;
    
    if (self.tableView.contentOffset.y >= ofsetY) {
        // 进入刷新状态
        self.footerRefreshing = YES;
        self.footerLabel.text = @"正在加载更多数据...";
        self.footerLabel.backgroundColor = [UIColor blueColor];
        
        // 发送请求给服务器
        XMGLog(@"发送请求给服务器 - 加载更多数据")
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 服务器请求回来了
            self.dataCount += 5;
            [self.tableView reloadData];
            
            // 结束刷新
            self.footerRefreshing = NO;
            self.footerLabel.text = @"上拉可以加载更多";
            self.footerLabel.backgroundColor = [UIColor redColor];
        });
    }
}

@end
