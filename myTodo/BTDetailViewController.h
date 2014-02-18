//
//  BTDetailViewController.h
//  myTodo
//
//  Created by crazypoo on 12/16/13.
//  Copyright (c) 2013 鄧傑豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *todoTextView;
- (IBAction)doneTouched:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *selectionView;
- (IBAction)twitterToched:(UIButton *)sender;
- (IBAction)fbTouched:(UIButton *)sender;

@end
