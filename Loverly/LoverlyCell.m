//
//  LoverlyCell.m
//  Loverly
//
//  Created by Moyun on 14/6/26.
//  Copyright (c) 2014年 Moyun. All rights reserved.
//

#import "LoverlyCell.h"
#import "LoverlyCellViewModel.h"
#import <UIImageView+WebCache.h>
#import <RACEXTScope.h>
#import <ReactiveCocoa.h>
@interface LoverlyCell ()

@property(nonatomic,strong)UIImageView *imgView;

@end

@implementation LoverlyCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imgView.layer.cornerRadius = 5.0f;
        self.imgView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.imgView];
    }
    return self;
}


- (void)layoutSubviews
{
    self.imgView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (void)configureWithViewModel:(LoverlyCellViewModel *)model
{
    self.viewModel = model;
    NSURL *imgUrl = [model getImgURL];
    [self.imgView setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"color.png"]];
}





@end
