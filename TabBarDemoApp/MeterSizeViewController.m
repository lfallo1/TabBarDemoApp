//
//  MeterSizeViewController.m
//  TabBarDemoApp
//
//  Created by Lance Fallon on 5/1/15.
//  Copyright (c) 2015 Lance Fallon. All rights reserved.
//

#import "MeterSizeViewController.h"

@implementation MeterSizeViewController

-(void)viewDidAppear:(BOOL)animated{
    [self.previousViewCtrl.tabBarController.tabBar setHidden:YES];
}

- (IBAction)convert:(id)sender {
    //get the unit of measure to convert the value into
    UIButton *btn = (UIButton *)sender;
    switch ([btn tag]) {
        case 0:
            [self.previousViewCtrl convertReading:@"gallons"];
            break;
        case 1:
            [self.previousViewCtrl convertReading:@"cubic feet"];
            break;
        case 2:
            [self.previousViewCtrl convertReading:@"cubic meters"];
            break;
        default:
            break;
    }
    [self dismissModal];
}

-(void)dismissModal{
    [self dismissViewControllerAnimated:YES completion:^{
        [self.previousViewCtrl showButtons];
    }];
}

@end
