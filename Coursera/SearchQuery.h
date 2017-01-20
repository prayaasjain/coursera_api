//
//  SearchQuery.h
//  Coursera
//
//  Created by Prayaas Jain on 11/14/16.
//  Copyright © 2016 Prayaas Jain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchQuery : NSObject

//query parameters
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *keyword;
@property (nonatomic, strong) NSString *start;
@property (nonatomic, strong) NSString *limit;

- (id)initWithType:(NSString *)t keyword:(NSString *)kword startIndex:(NSUInteger)start limit:(NSUInteger)lim;
- (void)fetchResults;

@end
