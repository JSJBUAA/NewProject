//
//  GroupModel.h
//  NewProject
//
//  Created by jiangshiju on 2017/3/5.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "ProjectBaseModel.h"

@interface GroupModel : ProjectBaseModel

@property (nonatomic, copy) NSString *groupID;
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, copy) NSString *groupAnnouncement;
@property (nonatomic, copy) NSString *groupImageUrl;
@property (nonatomic, assign) NSUInteger groupNumber;
@property (nonatomic, copy) NSString *groupLocation;
@property (nonatomic, copy) NSString *groupOwnerID;
@property (nonatomic, copy) NSString *groupOwnerName;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
