//
//  LoverlyModel.h
//  Loverly
//
//  Created by Moyun on 14/6/26.
//  Copyright (c) 2014年 Moyun. All rights reserved.
//

#import "LoverlyObject.h"

@interface LoverlyModel : LoverlyObject

@property(nonatomic,strong)NSURL *source;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *alt_tags;
@property(nonatomic,assign)NSInteger likes;
@property(nonatomic,strong)NSString *filename;
@property(nonatomic,assign)NSInteger shared_count;
@property(nonatomic,assign)NSInteger publisher_id;

- (NSURL *)getImgURL;

- (CGSize)getImgSize;

@end
