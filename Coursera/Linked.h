//
//  Linked.h
//  Coursera
//
//  Created by Prayaas Jain on 11/18/16.
//  Copyright © 2016 Prayaas Jain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Linked : NSObject

@property (nonatomic, strong) NSArray *courses;
@property (nonatomic, strong) NSArray *partners;
@property (nonatomic, strong) NSArray *onDemandSpecializations;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
