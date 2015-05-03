//
//  SecondViewController.m
//  TabBarDemoApp
//
//  Created by Lance Fallon on 5/1/15.
//  Copyright (c) 2015 Lance Fallon. All rights reserved.
//

#import "SecondViewController.h"
#import "MeasurementReadingsViewController.h"

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UIView *myNewView;

@end

@implementation SecondViewController
- (IBAction)longPressHandler:(id)sender {
    [self.myNewView setBackgroundColor:[UIColor redColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier]isEqualToString:@"loadDataLogSegue"]){
        //DO STUFFS
    }
}

@end
