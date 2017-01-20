//
//  OnDemandSpecialization.h
//  Coursera
//
//  Created by Prayaas Jain on 11/18/16.
//  Copyright © 2016 Prayaas Jain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OnDemandSpecialization : NSObject

@property (nonatomic, strong) NSArray *courseIds;
@property (nonatomic, strong) NSString *ods_description;
@property (nonatomic, strong) NSArray *partnerIds;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *tagline;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *ods_id;
@property (nonatomic, strong) NSString *slug;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
