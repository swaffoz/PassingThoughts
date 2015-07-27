//
//  MasterViewController.h
//  PassingThoughts
//
//  Created by Zane Swafford on 7/27/15.
//  Copyright (c) 2015 Zane Swafford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end

