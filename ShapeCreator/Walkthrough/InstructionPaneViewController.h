//
//  InstructionPaneViewController.h
//  ShapeCreator
//
//  Created by Benny Singer on 11/8/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstructionPaneView.h"

NS_ASSUME_NONNULL_BEGIN

@interface InstructionPaneViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong, readonly) InstructionPaneView *instructionPaneView;

- (instancetype)initWithInstructionPaneView:(InstructionPaneView *)paneView;

- (void)scrollToNextInstruction;

@end

NS_ASSUME_NONNULL_END
