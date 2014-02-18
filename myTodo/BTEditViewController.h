//
//  BTEditViewController.h
//  myTodo
//
//  Created by crazypoo on 12/16/13.
//  Copyright (c) 2013 鄧傑豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTEditViewController : UITableViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *loationTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextView *todoTextView;
- (IBAction)saveTouched:(UIBarButtonItem *)sender;

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) UIDatePicker *datePicker;

@end
