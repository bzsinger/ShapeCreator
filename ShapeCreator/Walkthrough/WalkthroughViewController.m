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
    InstructionPaneViewController *_instructionPaneViewController;
    WalkthroughView *_walkthroughView;
};

@end

@implementation WalkthroughViewController

- (instancetype)initWithWalkthroughView:(WalkthroughView *)walkthroughView {
    if (self = [super init]) {
        _instructionPaneViewController = [[InstructionPaneViewController alloc] initWithInstructionPaneView:walkthroughView.instructionPaneView];

        _walkthroughView = walkthroughView;
        [_walkthroughView setHidden:[[NSUserDefaults standardUserDefaults] boolForKey:@"walkthroughClosed"]];
        [_walkthroughView.closeButton addTarget:self action:@selector(hideWalkthroughView) forControlEvents:UIControlEventTouchUpInside];
        [_walkthroughView.nextButton addTarget:self action:@selector(scrollToNextInstruction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_walkthroughView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)hideWalkthroughView {
    _walkthroughView.hidden = YES;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"walkthroughClosed"];
}

- (void)showWalkthroughView {
    _walkthroughView.hidden = NO;
}

- (void)scrollToNextInstruction {
    [_instructionPaneViewController scrollToNextInstruction];
}

@end

