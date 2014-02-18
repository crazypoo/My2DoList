//
//  BTEditViewController.m
//  myTodo
//
//  Created by crazypoo on 12/16/13.
//  Copyright (c) 2013 鄧傑豪. All rights reserved.
//

#import "BTEditViewController.h"

@interface BTEditViewController ()
- (void)configureView;
@end

@implementation BTEditViewController
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
    
    if (self.detailItem) {
        self.titleTextField.text = [self.detailItem valueForKey:@"title"];
        
        self.loationTextField.text = [self.detailItem valueForKey:@"location"];
        
        NSDateFormatter *format = [[NSDateFormatter alloc]init];
        [format setDateFormat:@"dd.MM.yyyy HH:mm"];
        
        NSDate *date = [self.detailItem valueForKey:@"timestamp"];
        self.dateTextField.text = [format stringFromDate:date];
        self.todoTextView.text = [self.detailItem valueForKey:@"text"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureView];
    
    self.datePicker = [[UIDatePicker alloc]init];
    
    [self.datePicker addTarget:self
                        action:@selector(dateChanged)
              forControlEvents:UIControlEventValueChanged];
    self.dateTextField.inputView = self.datePicker;
    
}

- (void)dateChanged {
    NSDate *date = self.datePicker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    
    [dateFormat setDateFormat:@"dd.MM.yyyy HH:mm"];
    self.dateTextField.text = [dateFormat stringFromDate:date];
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
}

- (IBAction)saveTouched:(UIBarButtonItem *)sender {
    
    [self.detailItem setValue:@(NO) forKey:@"done"];
    
    [self.detailItem setValue:self.titleTextField.text forKey:@"title"];
    [self.detailItem setValue:self.todoTextView.text forKey:@"text"];
    [self.detailItem setValue:self.loationTextField.text forKey:@"location"];
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"dd.MM.yyyy HH:mm"];
    [self.detailItem setValue:[format dateFromString:self.dateTextField.text] forKey:@"timestamp"];
    
    NSManagedObjectContext *context = [self.detailItem managedObjectContext];
    
    NSError *error = nil;
    
    if (![context save:&error]) {
        NSLog(@"Problem: Das Speichern ist fehlgeschlagen. %@, %@", error, [error userInfo]);
        abort();
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
