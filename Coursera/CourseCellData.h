//
//  CourseCellData.h
//  Coursera
//
//  Created by Prayaas Jain on 11/21/16.
//  Copyright © 2016 Prayaas Jain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseCellData : NSObject

@property (nonatomic, strong) NSString *course_id;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *imageURLString;
@property (nonatomic, strong) NSString *courseName;
@property (nonatomic, strong) NSString *univName;
@property (nonatomic, strong) NSString *course_description;
@property (nonatomic, strong) NSNumber *numCourses;
@property (nonatomic, assign) BOOL isSpecialization;

@end
