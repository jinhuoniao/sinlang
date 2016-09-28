//
//  HCSearchInfoModel.h
//  LittleFrog3
//
//  Created by qianfeng on 16/9/10.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCSearchInfoModel : NSObject
@property (nonatomic ,strong) NSArray *song;
@property (nonatomic ,strong) NSArray *album;
@property (nonatomic ,strong) NSArray *artist;

@property (nonatomic ,copy) NSString *total;
@property (nonatomic ,strong) NSArray *song_list;
@property (nonatomic ,strong) NSArray *album_list;
@property (nonatomic ,strong) NSArray *artist_list;
@property (nonatomic ,strong) HCSearchInfoModel *song_info;
@property (nonatomic ,strong) HCSearchInfoModel *artist_info;
@property (nonatomic ,strong) HCSearchInfoModel *album_info;
@end
