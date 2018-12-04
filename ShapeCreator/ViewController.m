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
#import "TrayView.h"
#import "TrayViewController.h"

@interface ViewController () <TrayViewDelegate> {
    WalkthroughViewController *_walkthroughViewController;

    CanvasView *_canvasView;
    CanvasViewController *_canvasViewController;

    TrayView *_trayView;
    TrayViewController *_trayViewController;

    UIAlertController *_imageSaveAlert;
    UIImpactFeedbackGenerator *_feedbackGenerator;
};

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self becomeFirstResponder];

    _canvasView = [[CanvasView alloc] initWithFrame:self.view.frame];
    _canvasViewController = [[CanvasViewController alloc] initWithCanvasView:_canvasView];
    [self.view addSubview:_canvasView];

    WalkthroughView *walkthroughView = [[WalkthroughView alloc] initWithFrame:self.view.frame];
    _walkthroughViewController = [[WalkthroughViewController alloc] initWithWalkthroughView:walkthroughView];
    [self.view addSubview:walkthroughView];

    _trayView = [[TrayView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) - 50, 100, 200, 150)];
    _trayView.delegate = self;
    _trayViewController = [[TrayViewController alloc] initWithTrayView:_trayView];
    [self.view addSubview:_trayView];

    _imageSaveAlert = [UIAlertController alertControllerWithTitle:@""
                                                          message:@"Saving art..."
                                                   preferredStyle:UIAlertControllerStyleAlert];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.type == UIEventSubtypeMotionShake) {
        [_walkthroughViewController showWalkthroughView];
    }
}

- (void)saveButtonTapped {
    [_trayViewController closeTrayView];
    [self presentViewController:_imageSaveAlert animated:YES completion:nil];
    UIImageWriteToSavedPhotosAlbum([_canvasViewController getCanvasSnapshot], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    [_imageSaveAlert setMessage:@"Saved"];
    [_feedbackGenerator impactOccurred];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(hideSaved) userInfo:nil repeats:NO];
}

- (void)hideSaved {
    [_imageSaveAlert dismissViewControllerAnimated:YES completion:nil];
}

- (void)walkthroughButtonTapped {
    [_trayViewController closeTrayView];
    [_walkthroughViewController showWalkthroughView];
}

@end
