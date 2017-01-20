//
//  ViewController.m
//  Coursera
//
//  Created by Prayaas Jain on 11/14/16.
//  Copyright © 2016 Prayaas Jain. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchQuery.h"
#import "ResultsViewController.h"
#import "DataManager.h"

@interface SearchViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *searchField;
@property (nonatomic, strong) UIButton *searchButton;

@end

static NSString *const searchPlaceholder = @"Search";

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor whiteColor]];

    [self setUpNavigationController];
    [self setupSearchView];
}

#pragma mark - UI Setup Methods
- (void)setUpNavigationController {
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationItem setTitle:@"Coursera Catalog"];
}

- (void)setupSearchView {
    self.searchField = [[UITextField alloc] init];
    self.searchField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.searchField setBackgroundColor:[UIColor whiteColor]];
    [[self.searchField layer] setBorderWidth:1.0];
    [[self.searchField layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [self setTextFieldProperties:self.searchField withPlaceholder:searchPlaceholder withTag:101];

    self.searchButton = [[HollowButton alloc] init];
    [self.searchButton addTarget:self
                         action:@selector(searchButtonPressed:)
               forControlEvents:UIControlEventTouchUpInside];
    [self.searchButton setTitle:@"GO" forState:UIControlStateNormal];
    [self.searchButton setEnabled:YES];
    self.searchButton.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addSubview:self.searchField];
    [self.view addSubview:self.searchButton];

    [self setupSearchViewConstraints];
}

- (void)setupSearchViewConstraints {
    NSLayoutConstraint *searchFieldCenterXConstraint = [NSLayoutConstraint
                                                            constraintWithItem:self.searchField attribute:NSLayoutAttributeCenterX
                                                            relatedBy:NSLayoutRelationEqual toItem:self.view
                                                            attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *searchFieldCenterYConstraint = [NSLayoutConstraint
                                        constraintWithItem:self.searchField attribute:NSLayoutAttributeCenterY
                                        relatedBy:NSLayoutRelationEqual toItem:self.view
                                        attribute:NSLayoutAttributeCenterY multiplier:0.86 constant:0];

    NSLayoutConstraint *searchFieldHeightConstraint = [NSLayoutConstraint
                                                           constraintWithItem:self.searchField attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual toItem:self.view
                                                           attribute:NSLayoutAttributeHeight multiplier:0.09 constant:0];
    NSLayoutConstraint *searchFieldWidthConstraint = [NSLayoutConstraint
                                                          constraintWithItem:self.searchField attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual toItem:self.view
                                                          attribute:NSLayoutAttributeWidth multiplier:0.68 constant:0];

    NSLayoutConstraint *searchButtonCenterXConstraint = [NSLayoutConstraint
                                                         constraintWithItem:self.searchButton attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual toItem:self.view
                                                         attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *searchButtonCenterYConstraint = [NSLayoutConstraint
                                     constraintWithItem:self.searchButton attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual toItem:self.view
                                     attribute:NSLayoutAttributeCenterY multiplier:1.18 constant:0];

    NSLayoutConstraint *searchButtonHeightConstraint = [NSLayoutConstraint
                                                        constraintWithItem:self.searchButton attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual toItem:self.view
                                                        attribute:NSLayoutAttributeHeight multiplier:0.06 constant:0];
    NSLayoutConstraint *searchButtonWidthConstraint = [NSLayoutConstraint
                                                       constraintWithItem:self.searchButton attribute:NSLayoutAttributeWidth
                                                       relatedBy:NSLayoutRelationEqual toItem:self.view
                                                       attribute:NSLayoutAttributeWidth multiplier:0.2 constant:0];

    [self.view addConstraints:@[searchFieldCenterXConstraint, searchFieldCenterYConstraint, searchFieldHeightConstraint, searchFieldWidthConstraint,
                                searchButtonCenterXConstraint, searchButtonCenterYConstraint, searchButtonHeightConstraint, searchButtonWidthConstraint]];
}

#pragma mark - UITextFieldDelegate Methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }

    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if([textField.text isEqualToString:searchPlaceholder]) {
        textField.text = @"";
        textField.textColor = [UIColor blackColor];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField.text isEqualToString:@""]) {
        if(textField.tag == 101) {
            textField.text = searchPlaceholder;
            textField.textColor = [UIColor lightGrayColor];
        }
        [textField resignFirstResponder];
    }
}

#pragma mark - UIButtonPressed Methods
- (IBAction)searchButtonPressed:(id)sender{
    NSString *searchString = [self.searchField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    searchString = [searchString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

    SearchQuery *query = [[SearchQuery alloc] initWithType:@"search" keyword:searchString startIndex:0 limit:10];
    [query fetchResults];

    [self presentResultsViewController];
}

#pragma mark - Helper Methods
- (void)setTextFieldProperties:(UITextField *)inputField withPlaceholder:(NSString*)placeholder withTag:(NSInteger)tag {
    inputField.text = placeholder;
    inputField.textColor = [UIColor lightGrayColor];
    inputField.font = [UIFont fontWithName:AppFont_SF_UI_Text_Regular size:18.0f];
    inputField.textAlignment = NSTextAlignmentCenter;
    inputField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    inputField.translatesAutoresizingMaskIntoConstraints = NO;
    inputField.clipsToBounds = YES;
    inputField.tag = tag;
    inputField.tintColor = [UIColor blackColor];
    inputField.delegate = self;
    [inputField setReturnKeyType:UIReturnKeyDone];
    [inputField setKeyboardAppearance:UIKeyboardAppearanceLight];
}

- (void)presentResultsViewController {
    ResultsViewController *resultVc = [[ResultsViewController alloc] init];
    resultVc.tableData = [[DataManager getInstance] getFetchedCourseDataItems];
    [self.navigationController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self.navigationController pushViewController:resultVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
