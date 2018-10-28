//
//  WalkthroughViewController.m
//  ShapeCreator
//
//  Created by Benny Singer on 10/25/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import "WalkthroughViewController.h"

@interface WalkthroughViewController () {
    WalkthroughView *walkthroughView;
};

@end

@implementation WalkthroughViewController

- (instancetype)initWithWalkthroughView:(WalkthroughView *)walkthroughView {
    if (self = [super init]) {
        self->walkthroughView = walkthroughView;
        [self->walkthroughView.closeButton addTarget:self action:@selector(closeButtonClicked) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:walkthroughView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)closeButtonClicked {
    self->walkthroughView.hidden = YES;
}

- (void)showWalkthroughView {
    self->walkthroughView.hidden = NO;
}

@end

