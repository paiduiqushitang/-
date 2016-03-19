//
//  XMGEssenceViewController.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGEssenceViewController.h"
#import "XMGTitleButton.h"

#import "XMGAllViewController.h"
#import "XMGVideoViewController.h"
#import "XMGVoiceViewController.h"
#import "XMGPictureViewController.h"
#import "XMGWordViewController.h"

@interface XMGEssenceViewController () <UIScrollViewDelegate>
/** 用来存放所有子控制器view的scrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 标题栏 */
@property (nonatomic, weak) UIView *titlesView;
/** 标题下划线 */
@property (nonatomic, weak) UIView *titleUnderline;
/** 上一次点击的标题按钮 */
@property (nonatomic, weak) XMGTitleButton *previousClickedTitleButton;
@end

@implementation XMGEssenceViewController
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化子控制器
    [self setupAllChildVcs];
    
    // 设置导航条
    [self setupNavBar];
    
    // scrollView
    [self setupScrollView];
    
    // 标题栏
    [self setupTitlesView];
}

/**
 *  初始化子控制器
 */
- (void)setupAllChildVcs
{
    [self addChildViewController:[[XMGAllViewController alloc] init]];
    [self addChildViewController:[[XMGVideoViewController alloc] init]];
    [self addChildViewController:[[XMGVoiceViewController alloc] init]];
    [self addChildViewController:[[XMGPictureViewController alloc] init]];
    [self addChildViewController:[[XMGWordViewController alloc] init]];
}

/**
 *  设置导航条
 */
- (void)setupNavBar
{
    // 左边按钮
    // 把UIButton包装成UIBarButtonItem.就导致按钮点击区域扩大
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:nil action:nil];
    
    // titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

/**
 *  scrollView
 */
- (void)setupScrollView
{
    // 不允许自动修改UIScrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor blueColor];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 添加子控制器的view
    NSUInteger count = self.childViewControllers.count;
    CGFloat scrollViewW = scrollView.xmg_width;
    CGFloat scrollViewH = scrollView.xmg_height;
    
    for (NSUInteger i = 0; i < count; i++) {
        // 取出i位置子控制器的view
        UIView *childVcView = self.childViewControllers[i].view;
        childVcView.frame = CGRectMake(i * scrollViewW, 0, scrollViewW, scrollViewH);
        [scrollView addSubview:childVcView];
    }
    
    scrollView.contentSize = CGSizeMake(count * scrollViewW, 0);
}

/**
 *  标题栏
 */
- (void)setupTitlesView
{
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    titlesView.frame = CGRectMake(0, 64, self.view.xmg_width, 35);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 标题栏按钮
    [self setupTitleButtons];
    
    // 标题下划线
    [self setupTitleUnderline];
}

/**
 *  标题栏按钮
 */
- (void)setupTitleButtons
{
    // 文字
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSUInteger count = titles.count;
    
    // 标题按钮的尺寸
    CGFloat titleButtonW = self.titlesView.xmg_width / count;
    CGFloat titleButtonH = self.titlesView.xmg_height;
    
    // 创建5个标题按钮
    for (NSUInteger i = 0; i < count; i++) {
        XMGTitleButton *titleButton = [[XMGTitleButton alloc] init];
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:titleButton];
        // frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        // 文字
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
    }
}

/**
 *  标题下划线
 */
- (void)setupTitleUnderline
{
    // 标题按钮
    XMGTitleButton *firstTitleButton = self.titlesView.subviews.firstObject;
    
    // 下划线
    UIView *titleUnderline = [[UIView alloc] init];
    titleUnderline.xmg_height = 2;
    titleUnderline.xmg_y = self.titlesView.xmg_height - titleUnderline.xmg_height;
    titleUnderline.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    [self.titlesView addSubview:titleUnderline];
    self.titleUnderline = titleUnderline;
    
    // 切换按钮状态
    firstTitleButton.selected = YES;
    self.previousClickedTitleButton = firstTitleButton;
    
    [firstTitleButton.titleLabel sizeToFit]; // 让label根据文字内容计算尺寸
    self.titleUnderline.xmg_width = firstTitleButton.titleLabel.xmg_width + 10;
    self.titleUnderline.xmg_centerX = firstTitleButton.xmg_centerX;
}

#pragma mark - 监听
/**
 *  点击标题按钮
 */
- (void)titleButtonClick:(XMGTitleButton *)titleButton
{
    // 切换按钮状态
    self.previousClickedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    
    [UIView animateWithDuration:0.25 animations:^{
        // 处理下划线
        self.titleUnderline.xmg_width = titleButton.titleLabel.xmg_width + 10;
        self.titleUnderline.xmg_centerX = titleButton.xmg_centerX;
        
        // 滚动scrollView
        CGFloat offsetX = self.scrollView.xmg_width * titleButton.tag;
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
    }];
}

- (void)game
{
    XMGFunc
}

#pragma mark - <UIScrollViewDelegate>
/**
 *  当用户松开scrollView并且滑动结束时调用这个代理方法（scrollView停止滚动的时候）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 求出标题按钮的索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.xmg_width;
    
    // 点击对应的标题按钮
    XMGTitleButton *titleButton = self.titlesView.subviews[index];
    [self titleButtonClick:titleButton];
}

@end
