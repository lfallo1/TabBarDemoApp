//
//  Measurement.m
//  TabBarDemoApp
//
//  Created by Lance Fallon on 5/2/15.
//  Copyright (c) 2015 Lance Fallon. All rights reserved.
//

#import "Measurement.h"

@implementation Measurement
-(id)initWithSessionId:(NSString *)s readingDate:(NSDate *)d reading:(NSNumber *)r unitOfMeasure:(NSString *)m{
    self = [super init];
    if(self){
        [self setSessiontId:s];
        [self setReadingDate:d];
        [self setReading:r];
        [self setUnitOfMeasure:m];
    }
    return self;
}
@end
