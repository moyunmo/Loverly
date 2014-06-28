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
#import <RACEXTScope.h>
#import "DetailViewController.h"
#import "PushAnimation.h"

static NSString *cellIdentifier = @"Identifier";

@interface LoverlyViewController ()<CHTCollectionViewDelegateWaterfallLayout,UICollectionViewDataSource,UICollectionViewDelegate,UIViewControllerTransitioningDelegate>

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
    @weakify(self);
    [RACObserve(self, viewModel.models) subscribeNext:^(id x) {
        @strongify(self);
        [self.collectionView reloadData];
    }];
    [self.view addSubview:self.collectionView];
    [[self rac_signalForSelector:@selector(collectionView:didSelectItemAtIndexPath:) fromProtocol:@protocol(UICollectionViewDelegate)] subscribeNext:^(RACTuple *arguments) {
        @strongify(self);
        NSIndexPath *indexPath = arguments.second;
        DetailViewController *detail = [DetailViewController new];
        detail.transitioningDelegate = self;
        detail.viewModel = self.viewModel.models[indexPath.row];
        [self presentViewController:detail animated:YES completion:nil];
    }];
    self.collectionView.delegate = nil;
    self.collectionView.delegate = self;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.columnCount = 2;
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
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
    [cell configureWithViewModel:self.viewModel.models[indexPath.row]];
    return cell;
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

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [PushAnimation new];
}




@end
