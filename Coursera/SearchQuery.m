//
//  SearchQuery.m
//  Coursera
//
//  Created by Prayaas Jain on 11/14/16.
//  Copyright © 2016 Prayaas Jain. All rights reserved.
//

#import "AppDelegate.h"
#import "SearchQuery.h"
#import "SearchData.h"
#import "DataManager.h"

static NSString *baseQuery = @"https://api.coursera.org/api/catalogResults.v2";
static NSString *fieldsAndIncludes = @"fields=courseId,onDemandSpecializationId,courses.v1(name,photoUrl,partnerIds),onDemandSpecializations.v1(name,logo,courseIds,partnerIds),partners.v1(name)&includes=courseId,onDemandSpecializationId,courses.v1(partnerIds)";

@implementation SearchQuery

- (id)initWithType:(NSString *)t keyword:(NSString *)kword startIndex:(NSUInteger)start limit:(NSUInteger)lim {
    if(self = [super init]) {
        self.type = t;
        self.keyword = kword;
        self.start = [NSString stringWithFormat:@"%lu",(unsigned long)start];
        self.limit = [NSString stringWithFormat:@"%lu",(unsigned long)lim];
    }
    return self;
}

- (void)fetchResults {
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?q=%@&query=%@&start=%@&limit=%@&%@", baseQuery, self.type, self.keyword, self.start, self.limit, fieldsAndIncludes]];
    NSLog(@"Request URL: %@", requestURL);

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestURL
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10];
    [request setHTTPMethod:@"GET"];

    NSURLSessionDataTask *sessionTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (error != nil) {
            // TODO: Handle error from API call
            NSLog(@"ERROR: %@", [error localizedDescription]);
        }
        else {
            // successfully retrieved data
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSLog(@"Received json data: %@", jsonDict);

            SearchData *sData = [[SearchData alloc] initWithDictionary:jsonDict];
            NSLog(@"Search Data: %@", [sData description]);
            [[DataManager getInstance] setSearchDataAndPopulateModel:sData];
        }
    }];

    [sessionTask resume];

    // show in the status bar that network activity is starting
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

@end
