//
//  CanvasViewController.m
//  ShapeCreator
//
//  Created by Benny Singer on 10/25/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import "CanvasViewController.h"

@interface CanvasViewController ()

@end

@implementation CanvasViewController {
    CanvasView *_canvasView;

    UIImpactFeedbackGenerator *_feedbackGenerator;

    UIView *_currentSquare;
    CGPoint _currentOrigin;
    CGPoint _currentCenter;
}

- (instancetype)initWithCanvasView:(CanvasView *)canvasView {
    if (self = [super init]) {
        _canvasView = canvasView;
        [_canvasView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanAcrossScreen:)]];

        UIPanGestureRecognizer *clearPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPerformClearScreenPan:)];
        [clearPanGestureRecognizer setMaximumNumberOfTouches:2];
        [clearPanGestureRecognizer setMinimumNumberOfTouches:2];
        [_canvasView addGestureRecognizer:clearPanGestureRecognizer];

        _feedbackGenerator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
    }
    return self;
}

- (void)didPanAcrossScreen:(UIPanGestureRecognizer *)panGestureRecognizer {
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        _currentOrigin = [panGestureRecognizer locationInView:_canvasView];
        _currentSquare = [[UIView alloc] initWithFrame:CGRectMake(_currentOrigin.x, _currentOrigin.y, 0, 0)];
        _currentSquare.backgroundColor = [UIColor colorWithRed:(arc4random_uniform(256) / 256.0) green:(arc4random_uniform(256) / 256.0) blue:(arc4random_uniform(256) / 256.0) alpha:1];

        _currentSquare.userInteractionEnabled = TRUE;
        [_currentSquare addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didMoveSquare:)]];

        UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSingleTap:)];
        [_currentSquare addGestureRecognizer:singleTapGestureRecognizer];

        UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDoubleTap:)];
        doubleTapGestureRecognizer.numberOfTapsRequired = 2;
        [_currentSquare addGestureRecognizer:doubleTapGestureRecognizer];

        [_canvasView addSubview:_currentSquare];
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint currentLocation = [panGestureRecognizer locationInView:_canvasView];
        _currentSquare.frame = CGRectMake(_currentOrigin.x, _currentOrigin.y, currentLocation.x - _currentOrigin.x, currentLocation.y - _currentOrigin.y);
    }
}

- (void)didPerformClearScreenPan:(UIPanGestureRecognizer *)panGestureRecognizer {
    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        for (UIView *square in _canvasView.subviews) {
            [square removeFromSuperview];
        }
    }
}

- (void)didMoveSquare:(UIPanGestureRecognizer *)panGestureRecognizer {
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
    UIView *square = tapGestureRecognizer.view;
    if (tapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [_canvasView bringSubviewToFront:square];
    }
}

- (void)didDoubleTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    UIView *square = tapGestureRecognizer.view;
    if (tapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.3 animations:^{
            square.backgroundColor = [square.backgroundColor colorWithAlphaComponent:0];
        } completion:^(BOOL finished) {
            [square removeFromSuperview];
        }];
    }
}

@end
