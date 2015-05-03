//
//  Measurement.h
//  TabBarDemoApp
//
//  Created by Lance Fallon on 5/2/15.
//  Copyright (c) 2015 Lance Fallon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Measurement : NSObject
@property (nonatomic, strong) NSString *sessiontId;
@property (nonatomic, strong) NSDate *readingDate;
@property (nonatomic, strong) NSNumber *reading;
@property (nonatomic, strong) NSString *unitOfMeasure;

-(id)initWithSessionId:(NSString *)s readingDate:(NSDate *)d reading:(NSNumber *)r unitOfMeasure:(NSString *)m;
@end
