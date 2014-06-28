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
#import <SVProgressHud.h>

@interface LoverlyViewModel ()
{
    NSString *cachePath;
}
@property (nonatomic) BOOL cachaValid;
@property (nonatomic,strong) LoverlyModel *cacheData;

@end

@implementation LoverlyViewModel

- (id)init
{
    if ((self = [super init])) {
        RAC(self,models) = [self obtainData];
    }
    return self;
}

- (BOOL)cachaValid
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    cachePath = [paths[0] stringByAppendingPathComponent:@"Moyun"];
    self.cacheData = [NSKeyedUnarchiver unarchiveObjectWithFile:cachePath];
    if (self.cacheData) {
        return YES;
    }else{
        return NO;
    }
    return NO;
}

- (RACSignal *)loadData
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        if (self.cachaValid) {
            [subscriber sendNext:self.cacheData];
            [subscriber sendCompleted];
        }else{
            [SVProgressHUD showWithStatus:@"Loading..."];
            [subscriber sendError:nil];
        }
        return nil;
    }] subscribeOn:[RACScheduler scheduler]];
}



- (RACSignal *)obtainData
{
    return [[self loadData] catch:^RACSignal *(NSError *error) {
        NSLog(@"%@",error);
        return [[[LoverlyAPIManage sharedInstance] requestWithParameters:nil resultClass:[LoverlyModel class]]
                doNext:^(id x) {
                    [SVProgressHUD dismiss];
                    [NSKeyedArchiver archiveRootObject:x toFile:cachePath];
        }];
    }];
}

@end
