//
//  ConversionUtility.h
//  TabBarDemoApp
//
//  Created by Lance Fallon on 5/2/15.
//  Copyright (c) 2015 Lance Fallon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConversionUtility : NSObject
//+(NSNumber *)convertVolumeToCubicMeters:(NSNumber *)v from:(NSString *)f;
//+(NSNumber *)convertVolumeToCubicFeet:(NSNumber *)v from:(NSString *)f;
//+(NSNumber *)convertVolumeToGallons:(NSNumber *)v from:(NSString *)f;
+(NSNumber *)convertVolume:(NSNumber *)currentValue from:(NSString *)f to:(NSString *)t;
@end
