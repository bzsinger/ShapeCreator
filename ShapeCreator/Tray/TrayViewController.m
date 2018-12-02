//
//  TrayViewController.m
//  ShapeCreator
//
//  Created by Benny Singer on 11/26/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import "TrayViewController.h"

@interface TrayViewController () {
    TrayView *_trayView;

    CGPoint _trayOriginalCenter;
    CGFloat _trayDownOffset;
    CGPoint _trayOut;
    CGPoint _trayIn;
}

@end

@implementation TrayViewController

- (instancetype)initWithTrayView:(TrayView *)trayView {
    if (self = [super init]) {
        _trayView = trayView;
        [_trayView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanTray:)]];
        [_trayView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapTray:)]];

        _trayOut = _trayView.center;
        _trayIn = CGPointMake(_trayView.center.x + 30, _trayView.center.y);
    }
    return self;
}

- (void)didPanTray:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint translation = [panGestureRecognizer translationInView:_trayView];

    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        _trayOriginalCenter = _trayView.center;
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        if (-1 * (translation.x) + _trayView.frame.size.width / 2 < _trayView.frame.size.width) {
            _trayView.center = CGPointMake(_trayOriginalCenter.x + translation.x, _trayOriginalCenter.y);
        }
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [panGestureRecognizer velocityInView:_trayView];
        if (velocity.x < 0) {
            [self openTrayView];
        } else {
            [self closeTrayView];
        }
    }
}

- (void)didTapTray:(UITapGestureRecognizer *)tapGestureRecognizer {
    if (CGPointEqualToPoint(_trayView.center, _trayOut)) {
        [self closeTrayView];
    } else {
        [self openTrayView];
    }
}

- (void)openTrayView {
    [UIView animateWithDuration:0.5 animations:^{
        self->_trayView.center = self->_trayOut;
    }];
}

- (void)closeTrayView {
    [UIView animateWithDuration:0.5 animations:^{
        self->_trayView.center = self->_trayIn;
    }];
}

@end
