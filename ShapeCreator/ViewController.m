//
//  ViewController.m
//  ShapeCreator
//
//  Created by Benny Singer on 10/18/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)]];
}

- (void)didPan:(UIPanGestureRecognizer *)panGestureRecognizer {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
