//
//  LoverlyCellViewModel.m
//  Loverly
//
//  Created by Moyun on 14/6/26.
//  Copyright (c) 2014年 Moyun. All rights reserved.
//

#import "LoverlyCellViewModel.h"
#import "LoverlyModel.h"
#import "LoverlyViewModel.h"
@interface LoverlyCellViewModel ()

@end

@implementation LoverlyCellViewModel

- (NSURL *)getImgURL
{
    NSString *baseUrl = @"http://images.lover.ly/";
    NSString *imageUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"%d_%@",self.publisher_id,self.filename]];
    return [NSURL URLWithString:imageUrl];
}


@end
