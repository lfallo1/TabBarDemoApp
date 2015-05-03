//
//  DetailViewController.m
//  TabBarDemoApp
//
//  Created by Lance Fallon on 5/1/15.
//  Copyright (c) 2015 Lance Fallon. All rights reserved.
//

#import "MeasurementReadingsViewController.h"
#import "MeterSizeViewController.h"
#import "Measurement.h"
#import "MeasurementTableViewCell.h"
#import "ConversionUtility.h"

const int LIST_SIZE = 1000;

@interface MeasurementReadingsViewController()
{
    UIBarButtonItem *back;
    NSDictionary *measurementList;
    NSArray *keys;
    NSArray *shortKeys;
}
@property (nonatomic, strong) UILabel *navBarTitleLabel;
@property (nonatomic, strong) UILabel *navBarTitleLabelLoading;
@property (nonatomic, strong) UIBarButtonItem *navBarButtonRight;
@property (nonatomic, strong) MeterSizeViewController* meterSizeViewController;
@property (weak, nonatomic) IBOutlet UITableView *measurementsTableView;

@end

@implementation MeasurementReadingsViewController

-(void)viewDidLoad{
    
    //this will be a call to a db (right here, just generating dummy data with rand values)
    NSMutableArray *tmp1 = [[NSMutableArray alloc]initWithCapacity:LIST_SIZE];
    for(int i = 0; i < LIST_SIZE; i++){
        //generate a random date between now and 96 days from now, at a random second in the day
        NSDate *date = [[NSDate date] dateByAddingTimeInterval:60*60*24*[[NSNumber numberWithUnsignedInt: arc4random_uniform(96)]intValue] + arc4random_uniform(86400)];
        NSString *sessionId = [[NSNumber numberWithInt: i+5000]stringValue];
        int randn = arc4random_uniform(1000);
        NSNumber *reading = [NSNumber numberWithFloat:((float)randn) / 10.0f];
        Measurement *m = [[Measurement alloc]initWithSessionId:sessionId readingDate:date reading:reading unitOfMeasure:@"cubic feet"];
        [tmp1 addObject:m];
    }
    
    //sort the array by date/time ascending (this will be done in the sql statement)
    NSArray *tmp = [tmp1 sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSDate *first = [(Measurement *)obj1 readingDate];
        NSDate *second = [(Measurement *)obj2 readingDate];
        return [first compare:second];
    }];
    
    //1. sort the array
    //2. create a dictionary, where each key is the field you'd like to group by, and each
    //   value is an array of items that contain equal values according your desired grouping
    //3. for your number of sections, get the number of keys
    //4. for the number of rows in each section, get the key at the current index of your dictionary, then
    //   get the element (which is an array) for that given key. return that arrays count.
    //5. for the actual cells, get the key using indexpath.section, then do the same as #4 to get the
    //   element (array) for that key. Finally, get the specific item inside the array using indexpath.row
    
    NSMutableDictionary *sections = [[NSMutableDictionary alloc]init];
    NSMutableArray *shortKeysTemp = [[NSMutableArray alloc]init];
    NSMutableArray *keysTemp = [[NSMutableArray alloc]init];
    for(Measurement *m in tmp){
        
        //generate the reading date in yyyy-MM-dd format
        NSDate *date = [self dateAtBeginningOfDayForDate: [m readingDate]];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MMMM-dd"];
        [dateFormatter2 setDateFormat:@"MMMM-dd"];
        NSString *formattedDateString = [dateFormatter stringFromDate:date];
        NSString *formattedDateString2 = [dateFormatter2 stringFromDate:date];
        
        
        // If we don't yet have an array to hold the events for this day, create one
        NSMutableArray *readingsOnThisDay = [sections objectForKey: formattedDateString];
        if (readingsOnThisDay == nil) {
            readingsOnThisDay = [NSMutableArray array];
            [keysTemp addObject:formattedDateString];
            [shortKeysTemp addObject:formattedDateString2];
            // Use the reduced date as dictionary key to later retrieve the event list this day
            [sections setObject:readingsOnThisDay forKey:formattedDateString];
        }
        
        // Add the event to the list for this day
        [readingsOnThisDay addObject:m];
    }
    
    shortKeys = [[NSArray alloc]initWithArray:shortKeysTemp];
    keys = [[NSArray alloc]initWithArray:keysTemp];

    measurementList = sections;
    
    [self.measurementsTableView reloadData];
}

//when view appears, hide the back button, the tab bar, and display the stop [capture] button
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setHidesBackButton:YES animated:YES];
    [self.tabBarController.tabBar setHidden:YES];
    
    [self.ShareBtn setHidden:YES];
    [self.GraphBtn setHidden:YES];
    [self.StopBtn setHidden:NO];
    
    //create a progress bar view and set as the title view of the navigation bar
    UIProgressView *progressView = [[UIProgressView alloc]initWithFrame:self.navigationController.navigationBar.frame];
    [progressView sizeToFit];
    progressView.progress = 0.5f;
    self.navigationItem.titleView = progressView;
}

//before the view disappears, remove all custom buttons, and re-enable the tab bar
-(void)viewWillDisappear:(BOOL)animated{
    //remove the meter size (rightBarButtonItem)
    [self.navigationItem setRightBarButtonItem:nil];
    
    //remove the title lable
    [self.navBarTitleLabel removeFromSuperview];
    self.navBarTitleLabel = nil;
    [[self.navigationController.navigationBar viewWithTag:1]removeFromSuperview];
    
    //set tab bar to visible
    [self.tabBarController.tabBar setHidden:NO];
}

//hard coded button to simulate when a capture either finished or was stopped by the user
- (IBAction)stopCapture:(id)sender {
    [self showButtons];
}

//display all buttons that should be visible, when a capture is not in progress
-(void)showButtons{
    UIBarButtonItem *myNewBtn = [[UIBarButtonItem alloc]initWithTitle:@"Meter Size" style:UIBarButtonItemStylePlain target:self action:@selector(setMeterSize:)];
    [self.navigationItem setRightBarButtonItem:myNewBtn];

    //set the back button to visible
    [self.navigationItem setHidesBackButton:NO];
    
    //create a label and set as the navigationItem's title view
    self.navBarTitleLabel = [[UILabel alloc] initWithFrame:self.navigationController.navigationBar.frame];
    self.navBarTitleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.navBarTitleLabel.text = @"Data Log";
    self.navBarTitleLabel.backgroundColor = [UIColor clearColor];
    self.navBarTitleLabel.font = [UIFont systemFontOfSize:16];
    self.navBarTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.navBarTitleLabel.tag = 1;
    [self.navBarTitleLabel sizeToFit];
    self.navigationItem.titleView = self.navBarTitleLabel;
    
    //show buttons on bottom of screen
    [self.ShareBtn setHidden:NO];
    [self.GraphBtn setHidden:NO];
    [self.StopBtn setHidden:YES];
}

//handle click event that will display the MeterSize options modal
-(void)setMeterSize:(UIButton *)sender{
    [self performSegueWithIdentifier:@"MeterSize" sender:self];
}

-(void)convertReading:(NSString *)unitOfMeasure{
    for(NSString *key in keys){
        NSArray *list = [measurementList objectForKey:key];
        for(Measurement *m in list){
            [m setReading:[ConversionUtility convertVolume:[m reading] from:[m unitOfMeasure] to:unitOfMeasure]];
            [m setUnitOfMeasure:unitOfMeasure];
        }
    }
    [self.measurementsTableView reloadData];
}

#pragma mark - datasource/delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSString *key = [keys objectAtIndex:section];
    NSArray *measurements = [measurementList objectForKey:key];
    return [measurements count];
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return shortKeys;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MeasurementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeasurementTableCell" forIndexPath:indexPath];
    
    NSString *key = [keys objectAtIndex:indexPath.section];
    NSArray *measurements = [measurementList objectForKey:key];
    Measurement *m = [measurements objectAtIndex:indexPath.row];
    
    NSString *readingValueFormatted = [NSString stringWithFormat:@"%.2f", [[m reading]floatValue]];
    
    NSDate *date = [m readingDate];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm:ss a"];
    NSString *formattedTimeString = [dateFormatter stringFromDate:date];
    
    [[cell unitOfMeasure] setText :[m unitOfMeasure]];
    [[cell reading] setText :[NSString stringWithFormat:@"%@ (%@)", readingValueFormatted, [m unitOfMeasure]]];
    [[cell measurementId] setText:[m sessiontId]];
    [[cell dateLabel] setText :formattedTimeString];
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *key = [keys objectAtIndex:section];
    return key;
}

- (NSDate *)dateAtBeginningOfDayForDate:(NSDate *)inputDate
{
    // Use the user's current calendar and time zone
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [calendar setTimeZone:timeZone];
    
    // Selectively convert the date components (year, month, day) of the input date
    NSDateComponents *dateComps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:inputDate];
    
    // Set the time components manually
    [dateComps setHour:0];
    [dateComps setMinute:0];
    [dateComps setSecond:0];
    
    // Convert back
    NSDate *beginningOfDay = [calendar dateFromComponents:dateComps];
    return beginningOfDay;
}


#pragma mark - Segue

//specific handling for various segues
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //if MeterSize segue, create a reference back to this controller
    //so that when the new meter size is selected, it can call the
    //appropriate methods on this controller to update the data
    if([[segue identifier] isEqualToString:@"MeterSize"]){
        self.meterSizeViewController = segue.destinationViewController;
        [self.meterSizeViewController setPreviousViewCtrl:self];
    }
}

@end
