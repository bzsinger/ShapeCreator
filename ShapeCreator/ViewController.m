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
};

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)]];
}

- (void)didPan:(UIPanGestureRecognizer *)panGestureRecognizer {
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        currentOrigin = [panGestureRecognizer locationInView:self.view];
        currentSquare = [[UIView alloc] initWithFrame:CGRectMake(currentOrigin.x, currentOrigin.y, 0, 0)];
        currentSquare.backgroundColor = [UIColor greenColor];
        [self.view addSubview:currentSquare];
    }
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint currentLocation = [panGestureRecognizer locationInView:self.view];
        currentSquare.frame = CGRectMake(currentOrigin.x, currentOrigin.y, currentLocation.x - currentOrigin.x, currentLocation.y - currentOrigin.y);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
