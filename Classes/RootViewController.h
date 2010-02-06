//
//  RootViewController.h
//  Pets
//
//  Created by Steve Baker on 2/3/10.
//  Copyright Beepscore LLC 2010. All rights reserved.
//
#import "AddViewController.h"

@interface RootViewController : UITableViewController 
<NSFetchedResultsControllerDelegate, AddViewControllerDelegate> {
	NSFetchedResultsController *fetchedResultsController;
	NSManagedObjectContext *managedObjectContext;
    // add another MOC for adding a pet
	NSManagedObjectContext *addingManagedObjectContext;
}

// These properties have setters.  The app delegate sets the rootViewController.managedObjectContext.
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSManagedObjectContext *addingManagedObjectContext;

@end
