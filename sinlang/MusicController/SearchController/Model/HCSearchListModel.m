//
//  HCSearchListModel.m
//  LittleFrog3
//
//  Created by qianfeng on 16/9/10.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "HCSearchListModel.h"

@implementation HCSearchListModel

+ (NSArray *)mj_allowedPropertyNames {
    return @[@"songname",@"artistname",@"albumname",@"song_id",@"title",@"author",@"album_title",@"pic_small",@"avatar_middle",@"album_num",@"song_num",@"ting_uid",@"album_id",@"artist_id"];
}

@end
