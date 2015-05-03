//
//  MeasurementTableViewCell.h
//  TabBarDemoApp
//
//  Created by Lance Fallon on 5/2/15.
//  Copyright (c) 2015 Lance Fallon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeasurementTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *measurementId;
@property (weak, nonatomic) IBOutlet UILabel *reading;
@property (weak, nonatomic) IBOutlet UILabel *unitOfMeasure;
@end
