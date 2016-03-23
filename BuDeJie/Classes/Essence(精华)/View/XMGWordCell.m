//
//  XMGWordCell.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/23.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGWordCell.h"

@implementation XMGWordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // ...
        
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

/*
 - (void)layoutSubviews
 {
 [super layoutSubviews];
 
 }*/

- (void)setTopic:(XMGTopic *)topic
{
    [super setTopic:topic];
    
    
}

@end
