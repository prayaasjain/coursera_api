//
//  Course.h
//  Coursera
//
//  Created by Prayaas Jain on 11/18/16.
//  Copyright © 2016 Prayaas Jain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Course : NSObject

@property (nonatomic, strong) NSString *courseType;
@property (nonatomic, strong) NSString *photoUrl;
@property (nonatomic, strong) NSArray *partnerIds;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *course_id;
@property (nonatomic, strong) NSString *slug;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
