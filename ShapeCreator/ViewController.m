//
//  ViewController.m
//  ShapeCreator
//
//  Created by Benny Singer on 10/18/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    UIView *currentSquare;
    CGPoint currentOrigin;
    CGPoint currentCenter;
};

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanAcrossScreen:)]];
}

- (void)didPanAcrossScreen:(UIPanGestureRecognizer *)panGestureRecognizer {
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        currentOrigin = [panGestureRecognizer locationInView:self.view];
        currentSquare = [[UIView alloc] initWithFrame:CGRectMake(currentOrigin.x, currentOrigin.y, 0, 0)];
        currentSquare.backgroundColor = [UIColor colorWithRed:(arc4random_uniform(256) / 256.0) green:(arc4random_uniform(256) / 256.0) blue:(arc4random_uniform(256) / 256.0) alpha:1];
        
        currentSquare.userInteractionEnabled = TRUE;
        [currentSquare addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didMoveSquare:)]];

        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDoubleTap:)];
        tapGestureRecognizer.numberOfTapsRequired = 2;
        [currentSquare addGestureRecognizer:tapGestureRecognizer];

        [self.view addSubview:currentSquare];
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint currentLocation = [panGestureRecognizer locationInView:self.view];
        currentSquare.frame = CGRectMake(currentOrigin.x, currentOrigin.y, currentLocation.x - currentOrigin.x, currentLocation.y - currentOrigin.y);
    }
}

- (void)didMoveSquare:(UIPanGestureRecognizer *)panGestureRecognizer {
    UIView *square = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        currentCenter = square.center;
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:self.view];
        square.center = CGPointMake(currentCenter.x + translation.x, currentCenter.y + translation.y);
    }
}

- (void)didDoubleTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    UIView *square = tapGestureRecognizer.view;
    if (tapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self.view bringSubviewToFront:square];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
