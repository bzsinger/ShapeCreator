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
    CGPoint _trayUp;
    CGPoint _trayDown;
}

@end

@implementation TrayViewController

- (instancetype)initWithTrayView:(TrayView *)trayView {
    if (self = [super init]) {
        _trayView = trayView;
        [_trayView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanTray:)]];
        [_trayView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapTray:)]];

        _trayUp = _trayView.center;
        _trayDown = CGPointMake(_trayView.center.x + 30, _trayView.center.y);
    }
    return self;
}

- (void)didPanTray:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint translation = [panGestureRecognizer translationInView:_trayView];

    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        _trayOriginalCenter = _trayView.center;
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        if (_trayOriginalCenter.y + translation.y < _trayView.frame.size.height) {
            _trayView.center = CGPointMake(_trayOriginalCenter.x, _trayOriginalCenter.y + translation.y);
        }
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [panGestureRecognizer velocityInView:_trayView];
        [UIView animateWithDuration:0.5 animations:^{
            if (velocity.y < 0) {
                self->_trayView.center = self->_trayUp;
            } else {
                self->_trayView.center = self->_trayDown;
            }
        }];
    }
}

- (void)didTapTray:(UITapGestureRecognizer *)tapGestureRecognizer {
    CGPoint destination = CGPointZero;
    if (CGPointEqualToPoint(_trayView.center, _trayUp)) {
        destination = _trayDown;
    } else {
        destination = _trayUp;
    }

    [UIView animateWithDuration:0.5 animations:^{
        self->_trayView.center = destination;
    }];
}
@end
