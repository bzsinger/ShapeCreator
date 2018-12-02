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
    CanvasViewController *_canvasViewController;
    CanvasView *_canvasView;

    UIButton *_saveButton;
    UIAlertController *_imageSaveAlert;

    TrayView *_trayView;
    TrayViewController *_trayViewController;
};

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self becomeFirstResponder];

    _canvasView = [[CanvasView alloc] initWithFrame:self.view.frame];
    _canvasViewController = [[CanvasViewController alloc] initWithCanvasView:_canvasView];
    [self.view addSubview:_canvasView];

    _imageSaveAlert = [UIAlertController alertControllerWithTitle:@""
                                                 message:@"Saving art..."
                                          preferredStyle:UIAlertControllerStyleAlert];

    WalkthroughView *walkthroughView = [[WalkthroughView alloc] initWithFrame:self.view.frame];
    _walkthroughViewController = [[WalkthroughViewController alloc] initWithWalkthroughView:walkthroughView];
    [self.view addSubview:walkthroughView];

    _trayView = [[TrayView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) - 50, 100, 100, 150)];
    _trayView.delegate = self;
    _trayViewController = [[TrayViewController alloc] initWithTrayView:_trayView];
    [self.view addSubview:_trayView];
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
    [self presentViewController:_imageSaveAlert animated:YES completion:nil];

    UIGraphicsBeginImageContextWithOptions(_canvasView.bounds.size, _canvasView.opaque, 0.0f);
    CGContextRef graphicsContext = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] setFill];
    CGContextFillRect(graphicsContext, CGRectMake(0, 0, _canvasView.frame.size.width, _canvasView.frame.size.height));
    [_canvasView drawViewHierarchyInRect:_canvasView.bounds afterScreenUpdates:NO];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    UIImageWriteToSavedPhotosAlbum(snapshotImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    [_imageSaveAlert dismissViewControllerAnimated:YES completion:nil];
}

- (void)walkthroughButtonTapped {
    [_walkthroughViewController showWalkthroughView];
}

@end
