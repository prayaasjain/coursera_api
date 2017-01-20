//
//  Entry.h
//  Coursera
//
//  Created by Prayaas Jain on 11/18/16.
//  Copyright © 2016 Prayaas Jain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Entry : NSObject

@property (nonatomic, strong) NSNumber *score;                      //double encapsulated in NSNumber
@property (nonatomic, strong) NSString *resourceName;
@property (nonatomic, strong) NSString *entry_id;
@property (nonatomic, strong) NSString *courseId;
@property (nonatomic, strong) NSString *onDemandSpecializationId;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
