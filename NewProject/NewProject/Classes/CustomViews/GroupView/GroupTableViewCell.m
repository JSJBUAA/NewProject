//
//  GroupTableViewCell.m
//  NewProject
//
//  Created by jiangshiju on 2017/3/5.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

/*高度要求80.0f*/

#import "GroupTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "GroupModel.h"

@interface GroupTableViewCell ()

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *announcementLabel;

@end

@implementation GroupTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.headerImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.numberLabel];
        [self.contentView addSubview:self.announcementLabel];
    }
    return self;
}

- (UIImageView *)headerImageView
{
    if (!_headerImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20.0f, 10.0f, 60.0f, 60.0f)];
#pragma TODO - 后续修改为不要触发离屏渲染的模式
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 10.0f;
        _headerImageView = imageView;
    }
    return _headerImageView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100.0f, 10.0f, 200.0f, 20.0f)];
        label.font = [UIFont boldSystemFontOfSize:15.0f];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentLeft;
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)numberLabel
{
    if (!_numberLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100.0f, 30.0f, 200.0f, 20.0f)];
        label.font = [UIFont systemFontOfSize:13.0f];
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentLeft;
        _numberLabel = label;
    }
    return _numberLabel;
}

- (UILabel *)announcementLabel
{
    if (!_announcementLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100.0f, 50.0f, 200.0f, 20.0f)];
        label.font = [UIFont systemFontOfSize:13.0f];
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentLeft;
        _announcementLabel = label;
    }
    return _announcementLabel;
}

- (void)refreshWithGroupModel:(GroupModel *)model
{
    self.headerImageView.image = nil;
    self.nameLabel.text = nil;
    self.numberLabel.text = nil;
    self.announcementLabel.text = nil;
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.groupImageUrl]];
    self.nameLabel.text = model.groupName;
    self.numberLabel.text = [NSString stringWithFormat:@"人数：%lu",(unsigned long)model.groupNumber];
    self.announcementLabel.text = [NSString stringWithFormat:@"公告：%@",model.groupAnnouncement];
}

@end
