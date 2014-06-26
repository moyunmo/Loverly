//
//  LoverlyViewController.m
//  Loverly
//
//  Created by Moyun on 14/6/26.
//  Copyright (c) 2014年 Moyun. All rights reserved.
//

#import "LoverlyViewController.h"
#import "LoverlyViewModel.h"
#import <ReactiveCocoa.h>
#import <CHTCollectionViewWaterfallLayout.h>
#import "LoverlyModel.h"
#import "LoverlyCell.h"
#import "LoverlyCellViewModel.h"
#import <RACEXTScope.h>
#import <SVProgressHud.h>

static NSString *cellIdentifier = @"Identifier";

@interface LoverlyViewController ()<CHTCollectionViewDelegateWaterfallLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation LoverlyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.viewModel = [[LoverlyViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Loverly";
    [RACObserve(self, viewModel.models) subscribeNext:^(id x) {
        [SVProgressHUD dismiss];
        [self.collectionView reloadData];
    }];
    [self.view addSubview:self.collectionView];
    [SVProgressHUD showWithStatus:@"Loading..."];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.columnCount = 2;
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.alwaysBounceVertical = YES;
        [self.collectionView registerClass:[LoverlyCell class] forCellWithReuseIdentifier:cellIdentifier];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewModel.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LoverlyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    LoverlyModel *model = self.viewModel.models[indexPath.row];
    LoverlyCellViewModel *mode = [LoverlyCellViewModel new];
    cell.viewModel = self.viewModel.models[indexPath.row];
    mode.filename = model.filename;
    mode.publisher_id = model.publisher_id;
    [cell configureWithViewModel:mode];
    if ([self.viewModel.models count] - indexPath.row < 5){
        [self update];
    }
    return cell;
}

- (void)update
{

}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LoverlyModel *model = self.viewModel.models[indexPath.row];
    CGFloat height;
    if (model.width) {
        height = model.height*150/model.width;
    }
    return CGSizeMake(150, height);
}





@end
