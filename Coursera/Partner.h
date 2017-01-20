//
//  Partner.h
//  Coursera
//
//  Created by Prayaas Jain on 11/18/16.
//  Copyright © 2016 Prayaas Jain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Partner : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *partner_id;
@property (nonatomic, strong) NSString *shortName;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
