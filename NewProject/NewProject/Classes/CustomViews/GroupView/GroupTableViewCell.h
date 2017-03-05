//
//  GroupTableViewCell.h
//  NewProject
//
//  Created by jiangshiju on 2017/3/5.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//


/*高度要求80.0f*/

#import <UIKit/UIKit.h>

@class GroupModel;

@interface GroupTableViewCell : UITableViewCell

- (void)refreshWithGroupModel:(GroupModel *)model;

@end
