//
//  ActivitySettingViewController.h
//  NewProject
//
//  Created by jiangshiju on 17/2/25.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "TableViewBaseViewController.h"

@interface ActivitySettingViewController : TableViewBaseViewController

@end

@interface ActivitySettingTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *keyLabel;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;

- (void)refreshWithDictionary:(NSDictionary *)dictionary;

@end
