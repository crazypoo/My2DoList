//
//  BTMasterViewController.h
//  myTodo
//
//  Created by crazypoo on 12/16/13.
//  Copyright (c) 2013 鄧傑豪. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface BTMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
