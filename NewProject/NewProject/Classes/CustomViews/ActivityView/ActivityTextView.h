//
//  ActivityView.h
//  NewProject
//
//  Created by jiangshiju on 17/2/25.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ActivityTextView;
@protocol ActivityTextViewDelegate <NSObject>

- (BOOL)activityTextViewShouldReturn:(ActivityTextView *)textView;

@end

@interface ActivityTextView : UITextView

- (instancetype)initWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder agent:(id<ActivityTextViewDelegate>)agent;

@end
