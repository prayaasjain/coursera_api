//
//  CourseViewController.m
//  Coursera
//
//  Created by Prayaas Jain on 11/21/16.
//  Copyright © 2016 Prayaas Jain. All rights reserved.
//

#import "CourseViewController.h"

@interface CourseViewController ()

@property (nonatomic, strong) UIImageView *mainImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) CourseCellData *courseData;

@end

@implementation CourseViewController

- (id)initWithCourseData:(CourseCellData *)cdata {
    if (self = [super init]) {
        self.courseData = cdata;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    [self setUpNavigationController];
    [self setupMainView];
}

- (void)setUpNavigationController {
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.hidesBackButton = NO;
    self.navigationController.navigationBar.tintColor = [UIColor ceBackgroundColor];
    [self.navigationItem setTitle:@"Course Description"];
}

- (void)setupMainView {
    self.mainImage = [[UIImageView alloc] initWithImage:self.courseData.image];
    self.mainImage.contentMode = UIViewContentModeScaleAspectFit;
    self.mainImage.backgroundColor = [UIColor ceBackgroundColor];
    self.mainImage.translatesAutoresizingMaskIntoConstraints = NO;

    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.nameLabel setTextColor:[UIColor blackColor]];
    [self.nameLabel setTextAlignment:NSTextAlignmentLeft];
    [self.nameLabel setFont:[UIFont fontWithName:AppFont_SF_UI_Text_Semibold size:24]];
    [self.nameLabel setNumberOfLines:0];
    [self.nameLabel sizeToFit];
    self.nameLabel.text = self.courseData.courseName;
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.nameLabel.adjustsFontSizeToFitWidth = NO;

    self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.descriptionLabel setTextColor:[UIColor grayColor]];
    [self.descriptionLabel setTextAlignment:NSTextAlignmentLeft];
    [self.descriptionLabel setFont:[UIFont fontWithName:AppFont_SF_UI_Text_Regular size:15]];
    [self.descriptionLabel setNumberOfLines:0];
    [self.descriptionLabel sizeToFit];
    self.descriptionLabel.text = self.courseData.course_description;
    self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.descriptionLabel.adjustsFontSizeToFitWidth = NO;

    [self.view addSubview:self.mainImage];
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.descriptionLabel];

    [self setupMainViewConstraints];
}

- (void)setupMainViewConstraints {
    NSLayoutConstraint *mainImageCenterXConstraint = [NSLayoutConstraint
                                                   constraintWithItem:self.mainImage attribute:NSLayoutAttributeCenterX
                                                   relatedBy:NSLayoutRelationEqual toItem:self.view
                                                   attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *mainImageCenterYConstraint = [NSLayoutConstraint
                                                  constraintWithItem:self.mainImage attribute:NSLayoutAttributeCenterY
                                                  relatedBy:NSLayoutRelationEqual toItem:self.view
                                                  attribute:NSLayoutAttributeCenterY multiplier:0.3 constant:0];

    NSLayoutConstraint *nameLabelCenterXConstraint = [NSLayoutConstraint
                                                   constraintWithItem:self.nameLabel attribute:NSLayoutAttributeCenterX
                                                   relatedBy:NSLayoutRelationEqual toItem:self.mainImage
                                                   attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *nameLabelTopConstraint = [NSLayoutConstraint
                                                  constraintWithItem:self.nameLabel attribute:NSLayoutAttributeTop
                                                  relatedBy:NSLayoutRelationEqual toItem:self.mainImage
                                                  attribute:NSLayoutAttributeBottom multiplier:1 constant:25];

    NSLayoutConstraint *nameLabelWidthConstraint = [NSLayoutConstraint
                                                    constraintWithItem:self.nameLabel attribute:NSLayoutAttributeWidth
                                                    relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil
                                                    attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.view.frame.size.width*0.8];

    NSLayoutConstraint *descLabelLeftConstraint = [NSLayoutConstraint
                                                   constraintWithItem:self.descriptionLabel attribute:NSLayoutAttributeCenterX
                                                   relatedBy:NSLayoutRelationEqual toItem:self.nameLabel
                                                   attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *descLabelTopConstraint = [NSLayoutConstraint
                                                  constraintWithItem:self.descriptionLabel attribute:NSLayoutAttributeTop
                                                  relatedBy:NSLayoutRelationEqual toItem:self.nameLabel
                                                  attribute:NSLayoutAttributeBottom multiplier:1 constant:25];

    NSLayoutConstraint *descLabelWidthConstraint = [NSLayoutConstraint
                                                    constraintWithItem:self.descriptionLabel attribute:NSLayoutAttributeWidth
                                                    relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil
                                                    attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.view.frame.size.width*0.95];

    [self.view addConstraints:@[mainImageCenterXConstraint, mainImageCenterYConstraint,
                           nameLabelCenterXConstraint, nameLabelTopConstraint, nameLabelWidthConstraint,
                           descLabelLeftConstraint, descLabelTopConstraint, descLabelWidthConstraint]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
