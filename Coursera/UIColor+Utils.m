//
//  UIColor+Utils.m
//  Coursera
//
//  Created by Prayaas Jain on 11/21/16.
//  Copyright © 2016 Prayaas Jain. All rights reserved.
//

#import "UIColor+Utils.h"

@implementation UIColor (CEColor)

+ (UIColor *)ceUIColorFromRGB:(NSUInteger)rgbValue {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}

+(id)ceBackgroundColor {
    return [UIColor ceUIColorFromRGB:0xF2F4F5];
}

@end
