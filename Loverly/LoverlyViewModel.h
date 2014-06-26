//
//  LoverlyViewModel.h
//  Loverly
//
//  Created by Moyun on 14/6/26.
//  Copyright (c) 2014年 Moyun. All rights reserved.
//

#import "RVMViewModel.h"
@class LoverlyCellViewModel;
@interface LoverlyViewModel : RVMViewModel

@property(nonatomic,strong)NSArray *models;
@property(nonatomic,strong)LoverlyCellViewModel *model;

- (RACSignal *)obtainData;

@end
