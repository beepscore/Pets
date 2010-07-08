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
    // Xcode will automatically add instance variables to back properties
}

// These properties have setters.  The app delegate sets the rootViewController.managedObjectContext.
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

// add another MOC for adding a pet
@property (nonatomic, retain) NSManagedObjectContext *addingManagedObjectContext;

@end
