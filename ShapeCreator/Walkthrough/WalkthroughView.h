//
//  WalkthroughView.h
//  ShapeCreator
//
//  Created by Benny Singer on 10/25/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstructionPaneView.h"

@interface WalkthroughView : UIView

@property (nonatomic, strong, readonly) InstructionPaneView *instructionPaneView;
@property (nonatomic, strong, readonly) UIButton *closeButton;
@property (nonatomic, strong, readonly) UIButton *nextButton;

@end
