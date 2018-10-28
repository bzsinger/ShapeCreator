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
    CanvasView *canvasView;

    UIView *currentSquare;
    CGPoint currentOrigin;
    CGPoint currentCenter;
}

- (instancetype)initWithCanvasView:(CanvasView *)canvasView {
    if (self = [super init]) {
        self->canvasView = canvasView;
        [self->canvasView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanAcrossScreen:)]];
    }
    return self;
}

- (void)didPanAcrossScreen:(UIPanGestureRecognizer *)panGestureRecognizer {
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        currentOrigin = [panGestureRecognizer locationInView:self->canvasView];
        currentSquare = [[UIView alloc] initWithFrame:CGRectMake(currentOrigin.x, currentOrigin.y, 0, 0)];
        currentSquare.backgroundColor = [UIColor colorWithRed:(arc4random_uniform(256) / 256.0) green:(arc4random_uniform(256) / 256.0) blue:(arc4random_uniform(256) / 256.0) alpha:1];

        currentSquare.userInteractionEnabled = TRUE;
        [currentSquare addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didMoveSquare:)]];

        UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDoubleTap:)];
        doubleTapGestureRecognizer.numberOfTapsRequired = 2;
        [currentSquare addGestureRecognizer:doubleTapGestureRecognizer];

        UITapGestureRecognizer *tripleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTripleTap:)];
        tripleTapGestureRecognizer.numberOfTapsRequired = 3;
        [currentSquare addGestureRecognizer:tripleTapGestureRecognizer];

        [self->canvasView addSubview:currentSquare];
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint currentLocation = [panGestureRecognizer locationInView:self->canvasView];
        currentSquare.frame = CGRectMake(currentOrigin.x, currentOrigin.y, currentLocation.x - currentOrigin.x, currentLocation.y - currentOrigin.y);
    }
}

- (void)didMoveSquare:(UIPanGestureRecognizer *)panGestureRecognizer {
    UIView *square = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        currentCenter = square.center;
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:self->canvasView];
        square.center = CGPointMake(currentCenter.x + translation.x, currentCenter.y + translation.y);
    }
}

- (void)didDoubleTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    UIView *square = tapGestureRecognizer.view;
    if (tapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self->canvasView bringSubviewToFront:square];
    }
}

- (void)didTripleTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    UIView *square = tapGestureRecognizer.view;
    if (tapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.3 animations:^{
            square.backgroundColor = [square.backgroundColor colorWithAlphaComponent:0];
        } completion:^(BOOL finished) {
            [square removeFromSuperview];
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end