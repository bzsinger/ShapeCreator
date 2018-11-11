//
//  WalkthroughViewController.m
//  ShapeCreator
//
//  Created by Benny Singer on 10/25/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import "WalkthroughViewController.h"
#import "InstructionPaneView.h"
#import "InstructionPaneViewController.h"

@interface WalkthroughViewController () {
    InstructionPaneViewController *instructionPaneViewController;
    WalkthroughView *walkthroughView;
};

@end

@implementation WalkthroughViewController

- (instancetype)initWithWalkthroughView:(WalkthroughView *)walkthroughView {
    if (self = [super init]) {
        instructionPaneViewController = [[InstructionPaneViewController alloc] initWithInstructionPaneView:walkthroughView.instructionPaneView];

        self->walkthroughView = walkthroughView;
        [self->walkthroughView setHidden:[[NSUserDefaults standardUserDefaults] boolForKey:@"walkthroughClosed"]];
        [self->walkthroughView.closeButton addTarget:self action:@selector(hideWalkthroughView) forControlEvents:UIControlEventTouchUpInside];
        [self->walkthroughView.nextButton addTarget:self action:@selector(nextInstructionSlide) forControlEvents:UIControlEventTouchUpInside];
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

- (void)nextInstructionSlide {
    CGPoint currentOffset = self->walkthroughView.instructionPaneView.scrollView.contentOffset;
    CGFloat scrollViewFrameWidth = CGRectGetWidth(self->walkthroughView.instructionPaneView.scrollView.frame);
    CGFloat scrollViewContentWidth = self->walkthroughView.instructionPaneView.scrollView.contentSize.width;
    CGFloat nextInstructionX = currentOffset.x + scrollViewFrameWidth;
    if (nextInstructionX >= scrollViewContentWidth) {
        nextInstructionX = 0;
    }

    [UIView animateWithDuration:0.2 animations:^ {
        [self->walkthroughView.instructionPaneView.scrollView setContentOffset:CGPointMake(nextInstructionX, currentOffset.y) animated:NO];
    }];
}

@end

