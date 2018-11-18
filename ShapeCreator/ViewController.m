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
    WalkthroughViewController *_walkthroughViewController;
    CanvasViewController *_canvasViewController;
    CanvasView *_canvasView;

    UIButton *_saveButton;
};

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self becomeFirstResponder];

    _canvasView = [[CanvasView alloc] initWithFrame:self.view.frame];
    _canvasViewController = [[CanvasViewController alloc] initWithCanvasView:_canvasView];
    [self.view addSubview:_canvasView];

    _saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [self.view addSubview:_saveButton];
    [_saveButton addTarget:self action:@selector(saveSnapshot) forControlEvents:UIControlEventTouchUpInside];

    [_saveButton sizeToFit];
    CGSize saveButtonSize = _saveButton.frame.size;
    _saveButton.frame = CGRectMake(CGRectGetMaxX(self.view.frame) - saveButtonSize.width - 10,
                                   CGRectGetMaxY(self.view.frame) - saveButtonSize.height - 5,
                                   saveButtonSize.width,
                                   saveButtonSize.height);
    [self.view addSubview:_saveButton];

    WalkthroughView *walkthroughView = [[WalkthroughView alloc] initWithFrame:self.view.frame];
    _walkthroughViewController = [[WalkthroughViewController alloc] initWithWalkthroughView:walkthroughView];
    [self.view addSubview:walkthroughView];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.type == UIEventSubtypeMotionShake) {
        [_walkthroughViewController showWalkthroughView];
    }
}

- (void)saveSnapshot {
    UIGraphicsBeginImageContextWithOptions(_canvasView.bounds.size, _canvasView.opaque, 0.0f);
    CGContextRef graphicsContext = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] setFill];
    CGContextFillRect(graphicsContext, CGRectMake(0, 0, _canvasView.frame.size.width, _canvasView.frame.size.height));
    [_canvasView drawViewHierarchyInRect:_canvasView.bounds afterScreenUpdates:NO];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    UIImageWriteToSavedPhotosAlbum(snapshotImage, nil, nil, nil);
}

@end
