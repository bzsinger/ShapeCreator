//
//  InstructionPaneView.h
//  ShapeCreator
//
//  Created by Benny Singer on 11/8/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstructionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface InstructionPaneView : UIView

@property (nonatomic, strong, readonly) UIPageControl *pageControl;
@property (nonatomic, strong, readonly) UIScrollView *scrollView;
@property (nonatomic, strong, readonly) NSArray<InstructionView *> *instructionViews;

@end

NS_ASSUME_NONNULL_END
