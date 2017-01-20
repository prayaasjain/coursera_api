//
//  DataManager.m
//  Coursera
//
//  Created by Prayaas Jain on 11/21/16.
//  Copyright © 2016 Prayaas Jain. All rights reserved.
//

#import "DataManager.h"
#import "Partner.h"
#import "Course.h"
#import "OnDemandSpecialization.h"
#import "CourseCellData.h"

static DataManager *dataManager;

@implementation DataManager

+ (id)getInstance {
    @synchronized (self) {
        if (dataManager == nil) {
            dataManager = [[self alloc] _init];
        }
        return dataManager;
    }
}

- (id)_init {
    if ((self = [super init])) {
    }
    return self;
}

#pragma mark - Fetch Operations
- (void)setSearchDataAndPopulateModel:(SearchData *)sData {
    self.searchData = sData;
    [self populatePartnerDictionary:sData.linked.partners];
    [self populateCourseCellData];
    [self.refreshDelegate refreshWithData:self.courseDataItems];
}

- (NSArray *)getFetchedCourseDataItems {
    return self.courseDataItems;
}

- (void)populateCourseCellData {
    NSMutableArray *array = [NSMutableArray new];

    for (Course *c in self.searchData.linked.courses) {
        CourseCellData *cdata = [[CourseCellData alloc] init];
        cdata.course_id = c.course_id;
        cdata.imageURLString = c.photoUrl;
        cdata.courseName = c.name;
        NSString *key = c.partnerIds[0];
        Partner *p = [self.partners objectForKey:key];
        cdata.univName = p.name;
        cdata.isSpecialization = NO;

        [array addObject:cdata];
    }

    for (OnDemandSpecialization *ods in self.searchData.linked.onDemandSpecializations) {
        CourseCellData *cdata = [[CourseCellData alloc] init];
        cdata.course_id = ods.ods_id;
        cdata.imageURLString = ods.logo;
        cdata.courseName = ods.name;
        NSString *key = ods.partnerIds[0];
        Partner *p = [self.partners objectForKey:key];
        cdata.univName = p.name;
        cdata.course_description = ods.ods_description;
        cdata.numCourses = [NSNumber numberWithInt:(int)[ods.courseIds count]];
        cdata.isSpecialization = YES;

        [array addObject:cdata];
    }

    self.courseDataItems = array;
}

#pragma mark - Data Organization
- (void)populatePartnerDictionary:(NSArray *)partnerArr {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for (Partner *p in partnerArr) {
        [dict setObject:p forKey:p.partner_id];
    }
    self.partners = dict;
}

@end
