//
//  LoverlyAPIManage.h
//  Loverly
//
//  Created by Moyun on 14/6/26.
//  Copyright (c) 2014年 Moyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <ReactiveCocoa.h>
@interface LoverlyAPIManage : AFHTTPRequestOperationManager

+ (LoverlyAPIManage *)sharedInstance;

- (RACSignal *)requestWithParameters:(NSMutableDictionary *)parameters resultClass:(Class)resultClass;

@end
