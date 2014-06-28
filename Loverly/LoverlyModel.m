//
//  LoverlyModel.m
//  Loverly
//
//  Created by Moyun on 14/6/26.
//  Copyright (c) 2014年 Moyun. All rights reserved.
//

#import "LoverlyModel.h"

@implementation LoverlyModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"source":@"source",
             @"width":@"width",
             @"height":@"height",
             @"title":@"title",
             @"alt_tags":@"alt_tags",
             @"likes":@"likes",
             @"filename":@"filename",
             @"shared_count":@"shared_count",
             @"publisher_id":@"publisher_id"};
}

- (NSURL *)getImgURL
{
    NSString *baseUrl = @"http://images.lover.ly/";
    NSString *imageUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"%d_%@",self.publisher_id,self.filename]];
    return [NSURL URLWithString:imageUrl];
}

- (CGSize)getImgSize
{
    return CGSizeMake(320, 320*self.height/self.width);
}

@end
