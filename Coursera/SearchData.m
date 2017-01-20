//
//  SearchData.m
//  Coursera
//
//  Created by Prayaas Jain on 11/18/16.
//  Copyright © 2016 Prayaas Jain. All rights reserved.
//

#import "SearchData.h"

@implementation SearchData

- (id)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"paging"]) {
        self.paging = [[Paging alloc] initWithDictionary:value];
    }
    else if ([key isEqualToString:@"elements"]) {
        NSDictionary *dict = value[0];
        NSArray *entriesArr = [dict objectForKey:@"entries"];
        NSMutableArray *eArr = [NSMutableArray new];
        for (NSDictionary *eDict in entriesArr) {
            [eArr addObject:[[Entry alloc] initWithDictionary:eDict]];
        }
        self.entries = eArr;
    }
    else if ([key isEqualToString:@"linked"]) {
        self.linked = [[Linked alloc] initWithDictionary:value];
    }
    else {
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"Found undefined key: %@", key);
}

@end
