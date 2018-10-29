//
//  ViewController.m
//  ShapeCreator
//
//  Created by Benny Singer on 10/18/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import "ViewController.h"
#import "WalkthroughView.h"
#import "WalkthroughViewController.h"
#import "CanvasView.h"
#import "CanvasViewController.h"

@interface ViewController () {
    WalkthroughViewController *walkthroughViewController;
    CanvasViewController *canvasViewController;
};

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self becomeFirstResponder];

    CanvasView *canvasView = [[CanvasView alloc] initWithFrame:self.view.frame];
    self->canvasViewController = [[CanvasViewController alloc] initWithCanvasView:canvasView];
    [self.view addSubview:canvasView];

    WalkthroughView *walkthroughView = [[WalkthroughView alloc] initWithFrame:self.view.frame];
    self->walkthroughViewController = [[WalkthroughViewController alloc] initWithWalkthroughView:walkthroughView];
    [self.view addSubview:walkthroughView];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.type == UIEventSubtypeMotionShake) {
        [self->walkthroughViewController showWalkthroughView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
