//
//  DetailViewController.h
//  TabBarDemoApp
//
//  Created by Lance Fallon on 5/1/15.
//  Copyright (c) 2015 Lance Fallon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeasurementReadingsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *GraphBtn;
@property (weak, nonatomic) IBOutlet UIButton *ShareBtn;
@property (weak, nonatomic) IBOutlet UIButton *StopBtn;

-(void)showButtons;
-(void)convertReading:(NSString *)unitOfMeasure;
@end
