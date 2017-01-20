//
//  OnDemandSpecialization.m
//  Coursera
//
//  Created by Prayaas Jain on 11/18/16.
//  Copyright © 2016 Prayaas Jain. All rights reserved.
//

#import "OnDemandSpecialization.h"

@implementation OnDemandSpecialization

- (id)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"description"]) {
        self.ods_description = value;
    }
    else if ([key isEqualToString:@"id"]) {
        self.ods_id = value;
    }
    else {
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"Found undefined key: %@", key);
}

@end
