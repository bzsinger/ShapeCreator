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
        [self->walkthroughView setHidden:[[NSUserDefaults standardUserDefaults] boolForKey:@"walkthroughClosed"]];
        [self->walkthroughView.closeButton addTarget:self action:@selector(hideWalkthroughView) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:walkthroughView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)hideWalkthroughView {
    self->walkthroughView.hidden = YES;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"walkthroughClosed"];
}

- (void)showWalkthroughView {
    self->walkthroughView.hidden = NO;
}

@end

