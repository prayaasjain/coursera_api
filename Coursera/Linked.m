//
//  Linked.m
//  Coursera
//
//  Created by Prayaas Jain on 11/18/16.
//  Copyright © 2016 Prayaas Jain. All rights reserved.
//

#import "Linked.h"
#import "Course.h"
#import "Partner.h"
#import "OnDemandSpecialization.h"

@implementation Linked

- (id)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"courses.v1"]) {
        NSMutableArray *coursesv1 = [NSMutableArray new];
        for (id cObj in value) {
            [coursesv1 addObject:[[Course alloc] initWithDictionary:cObj]];
        }
        self.courses = coursesv1;
    }
    else if ([key isEqualToString:@"partners.v1"]) {
        NSMutableArray *partnersv1 = [NSMutableArray new];
        for (id pObj in value) {
            [partnersv1 addObject:[[Partner alloc] initWithDictionary:pObj]];
        }
        self.partners = partnersv1;
    }
    else if ([key isEqualToString:@"onDemandSpecializations.v1"]) {
        NSMutableArray *odsv1 = [NSMutableArray new];
        for (id odsObj in value) {
            [odsv1 addObject:[[OnDemandSpecialization alloc] initWithDictionary:odsObj]];
        }
        self.onDemandSpecializations = odsv1;
    }
    else {
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"Found undefined key: %@", key);
}

@end
