//
//  ConversionUtility.m
//  TabBarDemoApp
//
//  Created by Lance Fallon on 5/2/15.
//  Copyright (c) 2015 Lance Fallon. All rights reserved.
//

#import "ConversionUtility.h"

@implementation ConversionUtility

+(NSNumber *)convertVolume:(NSNumber *)currentValue from:(NSString *)f to:(NSString *)t{
    if([t isEqualToString:@"gallons"]){
        return [self convertVolumeToGallons:currentValue from:f];
    }
    else if ([t isEqualToString:@"cubic feet"]){
        return [self convertVolumeToCubicFeet:currentValue from:f];
    }
    else if ([t isEqualToString:@"cubic meters"]){
        return [self convertVolumeToCubicMeters:currentValue from:f];
    }
    return currentValue;
}

+(NSNumber *)convertVolumeToGallons:(NSNumber *)v from:(NSString *)f{
    if([f isEqualToString:@"gallons"]){
        return v;
    }
    else if([f isEqualToString:@"cubic feet"]){
        return [NSNumber numberWithFloat:[v floatValue] * 7.48052f];
    }
    else if([f isEqualToString:@"cubic meters"]){
        return [NSNumber numberWithFloat:[v floatValue] * 264.172f];
    }
    return v;
}

+(NSNumber *)convertVolumeToCubicFeet:(NSNumber *)v from:(NSString *)f{
    if([f isEqualToString:@"gallons"]){
        return [NSNumber numberWithFloat: [v floatValue] * 0.133681f];
    }
    else if([f isEqualToString:@"cubic feet"]){
        return v;
    }
    else if([f isEqualToString:@"cubic meters"]){
        return [NSNumber numberWithFloat:[v floatValue] * 35.3147f];
    }
    return v;
}

+(NSNumber *)convertVolumeToCubicMeters:(NSNumber *)v from:(NSString *)f{
    if([f isEqualToString:@"gallons"]){
        return [NSNumber numberWithFloat: [v floatValue] * 0.00378541f];
    }
    else if([f isEqualToString:@"cubic feet"]){
        return [NSNumber numberWithFloat: [v floatValue] * 0.0283168f];
    }
    else if([f isEqualToString:@"cubic meters"]){
        return v;
    }
    return v;
}

@end
