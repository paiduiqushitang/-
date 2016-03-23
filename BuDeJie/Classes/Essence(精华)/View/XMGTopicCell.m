//
//  XMGTopicCell.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/23.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTopicCell.h"
#import "XMGTopic.h"


@implementation XMGTopicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 增加顶部的控件，并且设置约束
        // ...
        
        // 增加底部的控件，并且设置约束
        // ...
        
        [self.contentView addSubview:[[UISwitch alloc] init]];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = NSStringFromClass(self.class);
        [label sizeToFit];
        label.tag = 10;
        [self.contentView addSubview:label];
    }
    return self;
}

/*
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置顶部和底部控件的frame
}*/

- (void)setTopic:(XMGTopic *)topic
{
    _topic = topic;
    
    UILabel *label = (UILabel *)[self viewWithTag:10];
    label.text = [NSString stringWithFormat:@"%@ - %zd", self.class, topic.type];
    [label sizeToFit];
    
    // 设置顶部和底部控件的具体数据（比如文字数据、图片数据）
}
@end
