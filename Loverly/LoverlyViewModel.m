//
//  LoverlyViewModel.m
//  Loverly
//
//  Created by Moyun on 14/6/26.
//  Copyright (c) 2014年 Moyun. All rights reserved.
//

#import "LoverlyViewModel.h"
#import <ReactiveCocoa.h>
#import "LoverlyAPIManage.h"
#import "LoverlyModel.h"
#import "LoverlyCellViewModel.h"
@implementation LoverlyViewModel

- (id)init
{
    if ((self = [super init])) {
        RAC(self,models) = [self obtainData];
    }
    return self;
}

- (RACSignal *)obtainData
{
    return [[LoverlyAPIManage sharedInstance] requestWithParameters:nil resultClass:[LoverlyModel class]];
}

@end
