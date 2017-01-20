//
//  DataManager.h
//  Coursera
//
//  Created by Prayaas Jain on 11/21/16.
//  Copyright © 2016 Prayaas Jain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchData.h"

@protocol DataRefreshDelegate <NSObject>
@required
- (void)refreshWithData:(NSArray *)data;
@end

@interface DataManager : NSObject

@property (nonatomic, strong) SearchData *searchData;
@property (nonatomic, strong) NSArray *courseDataItems;
@property (nonatomic, strong) NSDictionary *partners;
@property (nonatomic, weak) id<DataRefreshDelegate> refreshDelegate;

+ (id)getInstance;
- (NSArray *)getFetchedCourseDataItems;
- (void)setSearchDataAndPopulateModel:(SearchData *)sData;

@end
