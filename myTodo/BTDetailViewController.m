//
//  BTDetailViewController.m
//  myTodo
//
//  Created by crazypoo on 12/16/13.
//  Copyright (c) 2013 鄧傑豪. All rights reserved.
//

#import "BTDetailViewController.h"
#import "BTEditViewController.h"
#import <Social/Social.h>

@interface BTDetailViewController ()
- (void)configureView;
- (void)composeForSocialMedia:(NSString*)type;
@end

@implementation BTDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.view.backgroundColor = [UIColor whiteColor];
        
        CGRect frame      = self.view.frame;
        frame.origin.y    = 20;
        frame.size.height -= 0;
        self.view.frame   = frame;
        
//        UIView *headViews = [[UIView alloc] initWithFrame:CGRectMake(0, -20, 320, 20)];
//        [headViews setBackgroundColor:[UIColor blackColor]];
//        [self.view addSubview:headViews];
    }
    if (self.detailItem) {
        self.titleLabel.text = [self.detailItem valueForKey:@"title"];
        
        self.locationLabel.text = [self.detailItem valueForKey:@"location"];
        
        NSDateFormatter *format = [[NSDateFormatter alloc]init];
        [format setDateFormat:@"dd.MM.yyyy HH:mm"];
        
        NSDate *date = [self.detailItem valueForKey:@"timestamp"];
        self.dateLabel.text = [format stringFromDate:date];
        self.todoTextView.text = [self.detailItem valueForKey:@"text"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void) viewWillAppear:(BOOL)animated {
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneTouched:(UIButton *)sender {
    [self.detailItem setValue:@(YES) forKey:@"done"];
    
    NSManagedObjectContext *context = [self.detailItem managedObjectContext];
    NSError *error = nil;
    
    if (![context save:&error]) {
        NSLog(@"Problem: Das Speichern ist fehlgeschlagen. %@, %@", error, [error userInfo]);
        abort();
    }
    
    if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.selectionView.hidden = NO;
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"editSegue"]) {
        BTEditViewController *editVC = segue.destinationViewController;
        editVC.detailItem = self.detailItem;
    }
}

- (void)composeForSocialMedia:(NSString *)type{
    if (![SLComposeViewController isAvailableForServiceType:type]) {
        NSString *errorStrings = @"Twitter ist leider nicht verfübar";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                        message:errorStrings
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    SLComposeViewController *socialVC = [SLComposeViewController composeViewControllerForServiceType:type];
    
    NSString *titleString = [self.detailItem valueForKey:@"title"];
    NSDate *date = [self.detailItem valueForKey:@"timestamp"];
    
    NSDateFormatter *format = [NSDateFormatter new];
    [format setDateFormat:@"dd.MM.yyyy HH:mm"];
    
    NSString *initialString = [NSString stringWithFormat:@"Mein ToDO '%@' muss erledigt sein bis zumm %@", titleString, [format stringFromDate:date]];
    
    [socialVC setInitialText:initialString];
    [self presentViewController:socialVC animated:YES completion:^ {
        
    }];
}

- (IBAction)twitterToched:(UIButton *)sender {
    [self composeForSocialMedia:SLServiceTypeTwitter];
}

- (IBAction)fbTouched:(UIButton *)sender {
    
    [self composeForSocialMedia:SLServiceTypeFacebook];
}
@end
