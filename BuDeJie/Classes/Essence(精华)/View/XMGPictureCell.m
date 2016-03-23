//
//  XMGPictureCell.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/23.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGPictureCell.h"

@implementation XMGPictureCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 增加中间的图片控件，并且设置约束
        // ...
        
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

/*
 - (void)layoutSubviews
 {
 [super layoutSubviews];
 
 // 设置中间图片控件的frame
 }*/

- (void)setTopic:(XMGTopic *)topic
{
    [super setTopic:topic];
    
    // 设置中间图片控件的具体数据（比如文字数据、图片数据）
}

@end
