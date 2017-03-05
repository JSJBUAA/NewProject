//
//  GroupModel.m
//  NewProject
//
//  Created by jiangshiju on 2017/3/5.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "GroupModel.h"

@implementation GroupModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        self.groupID = [dictionary md_stringForKey:@"groupID" defaultValue:@"defaultID"];
        self.groupName = [dictionary md_stringForKey:@"groupName" defaultValue:@"defaultName"];
        self.groupNumber = [dictionary md_integerForKey:@"groupNumber" defaultValue:0];
        self.groupImageUrl = [dictionary md_stringForKey:@"groupImageUrl" defaultValue:@"defaultImageUrl"];
        self.groupAnnouncement = [dictionary md_stringForKey:@"groupAnnouncement" defaultValue:@"defaultAnnouncement"];
        self.groupLocation = [dictionary md_stringForKey:@"groupLocation" defaultValue:@"defaultLoaction"];
        self.groupOwnerID = [dictionary md_stringForKey:@"groupOwnerID" defaultValue:@"defaultOwnerID"];
        self.groupOwnerName = [dictionary md_stringForKey:@"groupOwnerName" defaultValue:@"defaultOwnerName"];
    }
    return self;
}

@end
