//
//  LoverlyCell.h
//  Loverly
//
//  Created by Moyun on 14/6/26.
//  Copyright (c) 2014年 Moyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoverlyCellViewModel;
@interface LoverlyCell : UICollectionViewCell

@property(nonatomic,strong)LoverlyCellViewModel *viewModel;

- (void)configureWithViewModel:(LoverlyCellViewModel *)model;

@end
