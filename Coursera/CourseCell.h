//
//  CourseCell.h
//  Coursera
//
//  Created by Prayaas Jain on 11/21/16.
//  Copyright © 2016 Prayaas Jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseCellData.h"

@interface CourseCell : UITableViewCell

@property (nonatomic, strong) UIImageView *mainImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *univLabel;
@property (nonatomic, strong) UILabel *coursesLabel;
@property (nonatomic, strong) CourseCellData *courseData;

/**
 Returns an instance of CourseCell initialized with the course data passed to the method.
 @param cdata contains the relevant data needed to display the course information
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withData:(CourseCellData *)cdata;

@end
