//
//  Utils.m
//  TwitterDemo
//
//  Created by  Matthew Buckle on 2/4/17.
//  Copyright © 2017 Matthew Buckle. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (NSString *)formattedStringFromNumber:(NSNumber *)number {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSString *groupingSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator];
    [formatter setGroupingSeparator:groupingSeparator];
    [formatter setGroupingSize:3];
    [formatter setAlwaysShowsDecimalSeparator:NO];
    [formatter setUsesGroupingSeparator:YES];
    
    return [formatter stringFromNumber:number];
}

@end
