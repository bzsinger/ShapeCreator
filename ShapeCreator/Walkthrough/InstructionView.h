//
//  InstructionView.h
//  ShapeCreator
//
//  Created by Benny Singer on 10/28/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InstructionView : UIView

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)instructionImage text:(NSString *)instructionText;

@end

NS_ASSUME_NONNULL_END
