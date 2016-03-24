//
//  XMGTopic.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/22.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTopic.h"

@implementation XMGTopic

- (CGFloat)cellHeight
{
    // 如果已经计算过，就直接返回
    if (_cellHeight) return _cellHeight;
    
    // 文字的Y值
    _cellHeight += 55;
    
    // 文字的高度
    CGSize textMaxSize = CGSizeMake(XMGScreenW - 2 * XMGMarin, MAXFLOAT);
    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + XMGMarin;
    
    // 工具条
    _cellHeight += 35 + XMGMarin;
    
    return _cellHeight;
}

@end
