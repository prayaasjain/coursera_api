//
//  Paging.m
//  Coursera
//
//  Created by Prayaas Jain on 11/21/16.
//  Copyright © 2016 Prayaas Jain. All rights reserved.
//

#import "Paging.h"

@implementation Paging

- (id)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"Found undefined key: %@", key);
}

@end
