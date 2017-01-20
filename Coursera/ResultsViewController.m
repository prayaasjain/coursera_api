//
//  ResultsViewController.m
//  Coursera
//
//  Created by Prayaas Jain on 11/21/16.
//  Copyright © 2016 Prayaas Jain. All rights reserved.
//

#import "ResultsViewController.h"
#import "CourseCell.h"
#import "CourseCellData.h"
#import "ImageDownloader.h"
#import "DataManager.h"
#import "CourseViewController.h"

@interface ResultsViewController () <DataRefreshDelegate, UITableViewDelegate> {
    NSUInteger lastLoadedImageIndex;
}


@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;

@end

static NSString *courseCellReuseIdentifier = @"courseCellReuseIdentifier";

@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [[DataManager getInstance] setRefreshDelegate:self];

    _imageDownloadsInProgress = [NSMutableDictionary dictionary];
}

- (void)setUpNavigationController {
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.hidesBackButton = NO;
    self.navigationController.navigationBar.tintColor = [UIColor ceBackgroundColor];
    [self.navigationItem setTitle:@"Results"];
}

#pragma mark - UITableViewDataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.tableData count] > 0) {
        return 1;
    }
    else {
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        messageLabel.text = @"No results found. Try a different search.";
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:AppFont_SF_UI_Text_Regular size:15.0];
        [messageLabel sizeToFit];

        [self.tableView setBackgroundColor:[UIColor clearColor]];
        self.tableView.backgroundView = messageLabel;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return [self.tableData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.width/2 + 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CourseCell *cell = [tableView dequeueReusableCellWithIdentifier:courseCellReuseIdentifier];
    CourseCellData *courseData = (self.tableData)[indexPath.row];
    cell = [[CourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:courseCellReuseIdentifier withData:courseData];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self startImageDownload:courseData forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CourseCellData *courseData = (self.tableData)[indexPath.row];
    CourseViewController *courseVc = [[CourseViewController alloc] initWithCourseData:courseData];
    [self.navigationController pushViewController:courseVc animated:YES];
}

#pragma mark - Table Cell Image Support Operations
- (void)startImageDownload:(CourseCellData *)courseData forIndexPath:(NSIndexPath *)indexPath {
    ImageDownloader *imgDownloader = (self.imageDownloadsInProgress)[indexPath];

    if (imgDownloader == nil) {
        imgDownloader = [[ImageDownloader alloc] init];
        imgDownloader.pictureURL = courseData.imageURLString;
        [imgDownloader setMaxWidthForImage:self.view.frame.size.width/2 - 20];

        [imgDownloader setCompletionHandler:^(UIImage *image){
            CourseCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

            // display the newly loaded image
            cell.mainImage.image = image;
            cell.courseData.image = image;
            lastLoadedImageIndex = indexPath.row;

            // remove the ImageDownloader object from the in progress list to free up memory
            [self.imageDownloadsInProgress removeObjectForKey:indexPath];
        }];

        (self.imageDownloadsInProgress)[indexPath] = imgDownloader;
        [imgDownloader startDownload];
    }
}

// Loads images for the next 6 rows to be displayed
- (void)loadImagesForSubsequentRows {
    if ([self.tableData count] > 0) {
        int upperBound = lastLoadedImageIndex + 6 > [self.tableData count] ? (int)[self.tableData count] : (int)lastLoadedImageIndex + 6;

        for (int i=0; i<upperBound; i++) {
            CourseCellData *courseData = (self.tableData)[i];
            if (!courseData.image) {
                [self startImageDownload:courseData forIndexPath:[NSIndexPath indexPathForRow:i inSection:1]];
            }
        }
    }
}

#pragma mark - DataRefreshDelegate Methods
- (void)refreshWithData:(NSArray *)data {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.tableData = data;
        [self.tableView reloadData];
    });
}

#pragma mark - UIScrollViewDelegate Methods
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self loadImagesForSubsequentRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self loadImagesForSubsequentRows];
}

#pragma mark - Memory Clean Up
- (void)terminateAllDownloads {
    // terminate all pending download connections
    NSArray *allDownloads = [self.imageDownloadsInProgress allValues];
    [allDownloads makeObjectsPerformSelector:@selector(cancelDownload)];

    [self.imageDownloadsInProgress removeAllObjects];
}

//  If this view controller is going away, we need to cancel all outstanding image downloads
- (void)dealloc {
    // terminate all pending download connections
    [self terminateAllDownloads];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
