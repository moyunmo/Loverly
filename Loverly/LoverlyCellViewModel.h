//
//  LoverlyCellViewModel.h
//  Loverly
//
//  Created by Moyun on 14/6/26.
//  Copyright (c) 2014年 Moyun. All rights reserved.
//

#import "RVMViewModel.h"

@interface LoverlyCellViewModel : RVMViewModel

@property(nonatomic,assign)NSInteger publisher_id;
@property(nonatomic,strong)NSString *filename;

- (NSURL *)getImgURL;

@end
