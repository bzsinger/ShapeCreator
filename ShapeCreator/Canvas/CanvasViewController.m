//
//  CanvasViewController.m
//  ShapeCreator
//
//  Created by Benny Singer on 10/25/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import "CanvasViewController.h"
#import "ColorPickerViewController.h"
#import "ColorPickerView.h"

@interface CanvasViewController ()

@end

@implementation CanvasViewController {
    CanvasView *_canvasView;

    ColorPickerView *_colorPickerView;
    ColorPickerViewController *_colorPickerViewController;

    UIImpactFeedbackGenerator *_feedbackGenerator;

    UIView *_currentSquare;
    CGPoint _currentOrigin;
    CGPoint _currentCenter;
}

- (instancetype)initWithCanvasView:(CanvasView *)canvasView {
    if (self = [super init]) {
        _canvasView = canvasView;

        [_canvasView.drawingView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanAcrossScreen:)]];
        [_canvasView.drawingView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapCanvas:)]];

        UIPanGestureRecognizer *clearPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPerformClearScreenPan:)];
        [clearPanGestureRecognizer setMaximumNumberOfTouches:2];
        [clearPanGestureRecognizer setMinimumNumberOfTouches:2];
        [_canvasView.drawingView addGestureRecognizer:clearPanGestureRecognizer];

        _feedbackGenerator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];

        _colorPickerView = [[ColorPickerView alloc] initWithFrame:CGRectMake(0, 0, 150, 125)];
        [_colorPickerView setHidden:YES];
        _colorPickerViewController = [[ColorPickerViewController alloc] initWithColorPickerView:_colorPickerView];
        _colorPickerViewController.delegate = self;
        [_canvasView addSubview:_colorPickerView];
    }
    return self;
}

- (void)didPanAcrossScreen:(UIPanGestureRecognizer *)panGestureRecognizer {
    [_colorPickerViewController hideColorPicker];

    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        _currentOrigin = [panGestureRecognizer locationInView:_canvasView];
        _currentSquare = [[UIView alloc] initWithFrame:CGRectMake(_currentOrigin.x, _currentOrigin.y, 0, 0)];
        _currentSquare.backgroundColor = [UIColor colorWithRed:(arc4random_uniform(256) / 256.0) green:(arc4random_uniform(256) / 256.0) blue:(arc4random_uniform(256) / 256.0) alpha:1];

        [_currentSquare addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didMoveSquare:)]];

        UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSingleTap:)];
        [_currentSquare addGestureRecognizer:singleTapGestureRecognizer];

        UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDoubleTap:)];
        doubleTapGestureRecognizer.numberOfTapsRequired = 2;
        [_currentSquare addGestureRecognizer:doubleTapGestureRecognizer];

        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didLongPress:)];
        [_currentSquare addGestureRecognizer:longPressGestureRecognizer];

        [_canvasView.drawingView addSubview:_currentSquare];
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint currentLocation = [panGestureRecognizer locationInView:_canvasView];
        _currentSquare.frame = CGRectMake(_currentOrigin.x, _currentOrigin.y, currentLocation.x - _currentOrigin.x, currentLocation.y - _currentOrigin.y);
    }
}

- (void)didPerformClearScreenPan:(UIPanGestureRecognizer *)panGestureRecognizer {
    [_colorPickerViewController hideColorPicker];

    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        for (UIView *square in _canvasView.drawingView.subviews) {
            [square removeFromSuperview];
        }
    }
}

- (void)didMoveSquare:(UIPanGestureRecognizer *)panGestureRecognizer {
    [_colorPickerViewController hideColorPicker];

    UIView *square = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        _currentCenter = square.center;
        square.transform = CGAffineTransformMakeScale(1.05, 1.05);
        [_feedbackGenerator impactOccurred];
        square.backgroundColor = [square.backgroundColor colorWithAlphaComponent:0.5];
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:_canvasView];
        square.center = CGPointMake(_currentCenter.x + translation.x, _currentCenter.y + translation.y);
    } else {
        square.transform = CGAffineTransformMakeScale(1, 1);
        [_feedbackGenerator impactOccurred];
        square.backgroundColor = [square.backgroundColor colorWithAlphaComponent:1];
    }
}

- (void)didSingleTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    [_colorPickerViewController hideColorPicker];

    UIView *square = tapGestureRecognizer.view;
    if (tapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [_canvasView.drawingView bringSubviewToFront:square];
    }
}

- (void)didDoubleTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    [_colorPickerViewController hideColorPicker];

    UIView *square = tapGestureRecognizer.view;
    if (tapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.3 animations:^{
            square.backgroundColor = [square.backgroundColor colorWithAlphaComponent:0];
        } completion:^(BOOL finished) {
            [square removeFromSuperview];
        }];
    }
}

- (void)didLongPress:(UILongPressGestureRecognizer *)longPressGestureRecognizer {
    UIView *square = longPressGestureRecognizer.view;
    if (longPressGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [_colorPickerViewController showColorPicker];

        CGPoint possibleCenters[] = {
            // TL
            CGPointMake(CGRectGetMinX(square.frame),
                        CGRectGetMinY(square.frame)),
            // TMid
            CGPointMake(CGRectGetMinX(square.frame) + CGRectGetWidth(square.frame) / 2,
                        CGRectGetMinY(square.frame)),
            // TR
            CGPointMake(CGRectGetMaxX(square.frame),
                        CGRectGetMinY(square.frame)),
            // MidR
            CGPointMake(CGRectGetMaxX(square.frame),
                        CGRectGetMinY(square.frame) + CGRectGetHeight(square.frame) / 2),
            // MidL
            CGPointMake(CGRectGetMinX(square.frame),
                        CGRectGetMinY(square.frame) + CGRectGetHeight(square.frame) / 2),
            // BR
            CGPointMake(CGRectGetMaxX(square.frame),
                        CGRectGetMaxY(square.frame)),
            // BMid
            CGPointMake(CGRectGetMinX(square.frame) + CGRectGetWidth(square.frame) / 2,
                        CGRectGetMaxY(square.frame)),
            // BL
            CGPointMake(CGRectGetMinX(square.frame), CGRectGetMaxY(square.frame)),
            square.center
        };

        _colorPickerView.center = CGPointZero;
        CGFloat minOverflow = CGFLOAT_MAX;
        for (int i = 0; i < sizeof(possibleCenters) / sizeof(possibleCenters[0]); i++) {
            CGFloat overflowLeft = possibleCenters[i].x - CGRectGetWidth(_colorPickerView.frame) / 2;
            CGFloat overflowRight = possibleCenters[i].x + CGRectGetWidth(_colorPickerView.frame) / 2;
            CGFloat overflowTop = possibleCenters[i].y - CGRectGetHeight(_colorPickerView.frame) / 2;
            CGFloat overflowBottom = possibleCenters[i].y + CGRectGetHeight(_colorPickerView.frame) / 2;
            if (overflowLeft > 0 && overflowRight < CGRectGetWidth(_canvasView.frame) &&
                overflowTop > 10 && overflowBottom < CGRectGetHeight(_canvasView.frame)) {
                _colorPickerView.center = possibleCenters[i];
                break;
            } else {
                CGFloat overflow = 0;
                if (overflowLeft < 0) {
                    overflow += overflowLeft;
                }

                if (overflowRight > CGRectGetWidth(_canvasView.frame)) {
                    overflow += CGRectGetWidth(_canvasView.frame) - overflowRight;
                }

                if (overflowTop < 10) {
                    overflow += overflowTop;
                }

                if (overflowBottom > CGRectGetHeight(_canvasView.frame)) {
                    overflow += CGRectGetHeight(_canvasView.frame) - overflowBottom;
                }

                if (-1 * overflow < minOverflow) {
                    minOverflow = -1 * overflow;
                    _colorPickerView.center = possibleCenters[i];
                }
            }
        }

        [_feedbackGenerator impactOccurred];
        [_canvasView bringSubviewToFront:_colorPickerView];
        [_colorPickerViewController setColorValues:square.backgroundColor];
        _currentSquare = square;
    }
}

- (void)didTapCanvas:(UITapGestureRecognizer *)tapGestureRecognizer {
    [_colorPickerViewController hideColorPicker];
}

- (void)colorValuesChanged:(ColorPickerViewController *)colorPickerViewController {
    _currentSquare.backgroundColor = [colorPickerViewController getColorValues];
}

- (UIImage *)getCanvasSnapshot {
    UIGraphicsBeginImageContextWithOptions(_canvasView.drawingView.bounds.size, _canvasView.drawingView.opaque, 0.0f);
    CGContextRef graphicsContext = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] setFill];
    CGContextFillRect(graphicsContext, CGRectMake(0, 0, _canvasView.drawingView.frame.size.width, _canvasView.drawingView.frame.size.height));
    [_canvasView.drawingView drawViewHierarchyInRect:_canvasView.drawingView.bounds afterScreenUpdates:NO];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return snapshotImage;
}

@end
