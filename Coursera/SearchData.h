//
//  SearchData.h
//  Coursera
//
//  Created by Prayaas Jain on 11/18/16.
//  Copyright © 2016 Prayaas Jain. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Paging.h"
#import "Linked.h"
#import "Entry.h"

@interface SearchData : NSObject

@property (nonatomic, strong) Paging *paging;
@property (nonatomic, strong) NSArray *entries;             //look for key "elements" and populate entries
@property (nonatomic, strong) Linked *linked;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
