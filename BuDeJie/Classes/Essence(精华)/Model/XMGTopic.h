//
//  XMGTopic.h
//  BuDeJie
//
//  Created by xiaomage on 16/3/22.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef enum {
//    /** 全部 */
//    XMGTopicTypeAll = 1,
//    /** 图片 */
//    XMGTopicTypePicture = 10,
//    /** 段子 */
//    XMGTopicTypeWord = 29,
//    /** 声音 */
//    XMGTopicTypeVoice = 31,
//    /** 视频 */
//    XMGTopicTypeVideo = 41
//} XMGTopicType;

typedef NS_ENUM(NSUInteger, XMGTopicType) {
    /** 全部 */
    XMGTopicTypeAll = 1,
    /** 图片 */
    XMGTopicTypePicture = 10,
    /** 段子 */
    XMGTopicTypeWord = 29,
    /** 声音 */
    XMGTopicTypeVoice = 31,
    /** 视频 */
    XMGTopicTypeVideo = 41
};

@interface XMGTopic : NSObject
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *passtime;

/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;

/** 帖子的类型 10为图片 29为段子 31为音频 41为视频 */
@property (nonatomic, assign) NSInteger type;
@end
