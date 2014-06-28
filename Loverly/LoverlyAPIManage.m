//
//  LoverlyAPIManage.m
//  Loverly
//
//  Created by Moyun on 14/6/26.
//  Copyright (c) 2014年 Moyun. All rights reserved.
//

#import "LoverlyAPIManage.h"
#import <Mantle.h>
#import <AFNetworking-RACExtensions/AFHTTPRequestOperationManager+RACSupport.h>
#define kwaterFlowAPI @"http://api.lover.ly/browse/featured?api=json&preferred_width=640&offset=0&limit=30"

@implementation LoverlyAPIManage

+ (LoverlyAPIManage *)sharedInstance
{
    static LoverlyAPIManage *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self manager];
    });
    return instance;
}

- (RACSignal *)requestWithParameters:(NSMutableDictionary *)parameters resultClass:(Class)resultClass
{
    return [[[self rac_GET:kwaterFlowAPI parameters:parameters] catch:^RACSignal *(NSError *error) {
        NSLog(@"%@",error);
        return nil;
    }] map:^id(id value) {
        return [[((NSArray *)value[@"items"]).rac_sequence map:^id(id value) {
            return [MTLJSONAdapter modelOfClass:resultClass fromJSONDictionary:value error:nil];
        }] array];
    }];
    
}

@end
