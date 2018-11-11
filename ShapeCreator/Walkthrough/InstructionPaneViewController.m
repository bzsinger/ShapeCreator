//
//  InstructionPaneViewController.m
//  ShapeCreator
//
//  Created by Benny Singer on 11/8/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import "InstructionPaneViewController.h"
#import "InstructionPaneView.h"

@interface InstructionPaneViewController ()

@property (readwrite) InstructionPaneView *instructionPaneView;

@end

@implementation InstructionPaneViewController

- (instancetype)initWithInstructionPaneView:(InstructionPaneView *)paneView {
    if (self = [super init]) {
        self.instructionPaneView = paneView;
        self.instructionPaneView.scrollView.delegate = self;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.instructionPaneView.pageControl.currentPage = (NSInteger) roundf(scrollView.contentOffset.x / CGRectGetWidth(self.view.frame));
}

@end
