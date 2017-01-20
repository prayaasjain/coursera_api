//
//  CourseCell.m
//  Coursera
//
//  Created by Prayaas Jain on 11/21/16.
//  Copyright © 2016 Prayaas Jain. All rights reserved.
//

#import "CourseCell.h"

@implementation CourseCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withData:(CourseCellData *)cdata {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.courseData = cdata;
        [self setupCellView];
    }
    return self;
}

- (void)setupCellView {
    [self setSeparatorInset:UIEdgeInsetsZero];
    [self setPreservesSuperviewLayoutMargins:NO];
    [self setLayoutMargins:UIEdgeInsetsZero];
    [self setBackgroundColor:[UIColor whiteColor]];

    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.nameLabel setTextColor:[UIColor blackColor]];
    [self.nameLabel setTextAlignment:NSTextAlignmentLeft];
    [self.nameLabel setFont:[UIFont fontWithName:AppFont_SF_UI_Text_Semibold size:18]];
    [self.nameLabel setNumberOfLines:0];
    [self.nameLabel sizeToFit];
    self.nameLabel.text = self.courseData.courseName;
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.nameLabel.adjustsFontSizeToFitWidth = NO;

    if (self.courseData.image) {
        self.mainImage = [[UIImageView alloc] initWithImage:self.courseData.image];
        self.mainImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    else {
        self.mainImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"imageLoading"]];
        self.mainImage.contentMode = UIViewContentModeCenter;
    }
    self.mainImage.backgroundColor = [UIColor ceBackgroundColor];
    self.mainImage.translatesAutoresizingMaskIntoConstraints = NO;

    self.univLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.univLabel setTextColor:[UIColor grayColor]];
    [self.univLabel setTextAlignment:NSTextAlignmentLeft];
    [self.univLabel setFont:[UIFont fontWithName:AppFont_SF_UI_Text_Regular size:15]];
    [self.univLabel setNumberOfLines:0];
    [self.univLabel sizeToFit];
    self.univLabel.text = self.courseData.univName;
    self.univLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.univLabel.adjustsFontSizeToFitWidth = NO;

    self.coursesLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.coursesLabel setTextColor:[UIColor whiteColor]];
    [self.coursesLabel setBackgroundColor:[UIColor lightGrayColor]];
    [self.coursesLabel setTextAlignment:NSTextAlignmentLeft];
    [self.coursesLabel setFont:[UIFont fontWithName:AppFont_SF_UI_Text_Regular size:15]];
    [self.coursesLabel setNumberOfLines:0];
    [self.coursesLabel sizeToFit];
    self.coursesLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.coursesLabel.adjustsFontSizeToFitWidth = NO;

    if (self.courseData.isSpecialization) {
        self.coursesLabel.text = [NSString stringWithFormat:@"%d-course Specialization", [self.courseData.numCourses intValue]];
    }
    else {
        self.coursesLabel.text = @"";
    }

    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.mainImage];
    [self.contentView addSubview:self.univLabel];
    [self.contentView addSubview:self.coursesLabel];

    [self setupConstraintsForCellView];
}

- (void)setupConstraintsForCellView {
    NSLayoutConstraint *mainImageLeftConstraint = [NSLayoutConstraint
                                                      constraintWithItem:self.mainImage attribute:NSLayoutAttributeLeft
                                                      relatedBy:NSLayoutRelationEqual toItem:self.contentView
                                                      attribute:NSLayoutAttributeLeft multiplier:1 constant:10];
    NSLayoutConstraint *mainImageTopConstraint = [NSLayoutConstraint
                                                  constraintWithItem:self.mainImage attribute:NSLayoutAttributeTop
                                                  relatedBy:NSLayoutRelationEqual toItem:self.contentView
                                                  attribute:NSLayoutAttributeTop multiplier:1 constant:10];

    NSLayoutConstraint *mainImageWidthConstraint = [NSLayoutConstraint
                                                    constraintWithItem:self.mainImage attribute:NSLayoutAttributeWidth
                                                    relatedBy:NSLayoutRelationEqual toItem:nil
                                                    attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.contentView.frame.size.width/2 - 10];
    NSLayoutConstraint *mainImageHeightConstraint = [NSLayoutConstraint
                                                     constraintWithItem:self.mainImage attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.contentView.frame.size.width/2 - 10];

    NSLayoutConstraint *nameLabelLeftConstraint = [NSLayoutConstraint
                                                       constraintWithItem:self.nameLabel attribute:NSLayoutAttributeLeft
                                                       relatedBy:NSLayoutRelationEqual toItem:self.mainImage
                                                       attribute:NSLayoutAttributeRight multiplier:1 constant:10];
    NSLayoutConstraint *nameLabelTopConstraint = [NSLayoutConstraint
                                                      constraintWithItem:self.nameLabel attribute:NSLayoutAttributeTop
                                                      relatedBy:NSLayoutRelationEqual toItem:self.mainImage
                                                      attribute:NSLayoutAttributeTop multiplier:1 constant:0];

    NSLayoutConstraint *nameLabelWidthConstraint = [NSLayoutConstraint
                                                  constraintWithItem:self.nameLabel attribute:NSLayoutAttributeWidth
                                                  relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil
                                                  attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.contentView.frame.size.width/2];

    NSLayoutConstraint *univLabelLeftConstraint = [NSLayoutConstraint
                                                   constraintWithItem:self.univLabel attribute:NSLayoutAttributeLeft
                                                   relatedBy:NSLayoutRelationEqual toItem:self.nameLabel
                                                   attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *univLabelTopConstraint = [NSLayoutConstraint
                                                  constraintWithItem:self.univLabel attribute:NSLayoutAttributeTop
                                                  relatedBy:NSLayoutRelationEqual toItem:self.nameLabel
                                                  attribute:NSLayoutAttributeBottom multiplier:1 constant:10];

    NSLayoutConstraint *univLabelWidthConstraint = [NSLayoutConstraint
                                                    constraintWithItem:self.univLabel attribute:NSLayoutAttributeWidth
                                                    relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil
                                                    attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.contentView.frame.size.width/2];

    NSLayoutConstraint *coursesLabelLeftConstraint = [NSLayoutConstraint
                                                   constraintWithItem:self.coursesLabel attribute:NSLayoutAttributeLeft
                                                   relatedBy:NSLayoutRelationEqual toItem:self.nameLabel
                                                   attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *coursesLabelTopConstraint = [NSLayoutConstraint
                                                  constraintWithItem:self.coursesLabel attribute:NSLayoutAttributeTop
                                                  relatedBy:NSLayoutRelationEqual toItem:self.univLabel
                                                  attribute:NSLayoutAttributeBottom multiplier:1 constant:10];

    [self addConstraints:@[mainImageLeftConstraint, mainImageTopConstraint, mainImageWidthConstraint, mainImageHeightConstraint,
                           nameLabelLeftConstraint, nameLabelTopConstraint, nameLabelWidthConstraint,
                           univLabelLeftConstraint, univLabelTopConstraint, univLabelWidthConstraint,
                           coursesLabelLeftConstraint, coursesLabelTopConstraint]];
}

@end
