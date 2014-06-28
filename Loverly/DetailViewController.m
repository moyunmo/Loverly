//
//  DetailViewController.m
//  Loverly
//
//  Created by Moyun on 14/6/28.
//  Copyright (c) 2014年 Moyun. All rights reserved.
//

#import "DetailViewController.h"
#import "LoverlyModel.h"
#import <UIImageView+WebCache.h>
#import <ReactiveCocoa.h>
#import <RACEXTScope.h>

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:(CGRect){.origin=CGPointMake(0, 20), .size=[self.viewModel getImgSize]}];
    [imgView setImageWithURL:[self.viewModel getImgURL]];
    [self.view addSubview:imgView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"dismiss" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, self.view.frame.size.height-100, 110, 100);
    @weakify(self);
    btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
        return [RACSignal empty];
    }];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
