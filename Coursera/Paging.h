//
//  Paging.h
//  Coursera
//
//  Created by Prayaas Jain on 11/21/16.
//  Copyright © 2016 Prayaas Jain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Paging : NSObject

@property (nonatomic, strong) NSNumber *total;              //long value encapsulayted as NSNumber
@property (nonatomic, strong) NSDictionary *facets;
@property (nonatomic, strong) NSString *next;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
