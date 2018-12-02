//
//  TrayView.h
//  ShapeCreator
//
//  Created by Benny Singer on 11/25/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TrayView;

@protocol TrayViewDelegate <NSObject>

- (void)walkthroughButtonTapped;
- (void)saveButtonTapped;

@end

NS_ASSUME_NONNULL_BEGIN

@interface TrayView : UIView

@property (nonatomic, weak, readwrite) id<TrayViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
