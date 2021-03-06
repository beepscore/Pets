//
//  RootViewController.m
//  Pets
//
//  Created by Steve Baker on 2/3/10.
//  Copyright Beepscore LLC 2010. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"
#import "Pet.h"
#import "Debug.h"

@implementation RootViewController

@synthesize fetchedResultsController, managedObjectContext, addingManagedObjectContext;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    
	// Set up the edit and add buttons.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"Pets";
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] 
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self 
                                  action:@selector(insertNewPet)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
	
	NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		DLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
}


#pragma mark Memory management
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


// Ref http://developer.apple.com/mac/library/documentation/Cocoa/Conceptual/MemoryMgmt/Articles/mmNibObjects.html
- (void)viewDidUnload {
	// Release any retained subviews of the main view.
    // Release any retained outlets
    // set properties to nil, which also releases them
    self.fetchedResultsController = nil;
    self.managedObjectContext = nil;
    self.addingManagedObjectContext = nil;
    
    [super viewDidUnload];
}


- (void)dealloc 
{
	[fetchedResultsController release], fetchedResultsController = nil;
	[managedObjectContext release], managedObjectContext = nil;
	[addingManagedObjectContext release], addingManagedObjectContext = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark Add a new object

- (void)insertNewPet
{    
    AddViewController *addViewController = [[AddViewController alloc]
                                            initWithStyle:UITableViewStyleGrouped];
    // this setter assigns, doesn't retain
    addViewController.delegate = self;	
    
	NSManagedObjectContext *addingContext = [[NSManagedObjectContext alloc] init];
    self.addingManagedObjectContext = addingContext;
    [addingContext release], addingContext = nil;
    
    [self.addingManagedObjectContext setPersistentStoreCoordinator:
     [[fetchedResultsController managedObjectContext] persistentStoreCoordinator]];
    
    // add a pet
	addViewController.pet = (Pet *)[NSEntityDescription 
                                    insertNewObjectForEntityForName:@"Pet"
                                    inManagedObjectContext:self.addingManagedObjectContext];
    
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:addViewController];
    [self.navigationController presentModalViewController:navController animated:YES];
    
    [addViewController release], addViewController = nil;
    [navController release], navController = nil;
}


#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	NSManagedObject *managedObject = [fetchedResultsController objectAtIndexPath:indexPath];
	cell.textLabel.text = [[managedObject valueForKey:BSKeyName] description];
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here -- for example, create and push another view controller.
    
    DetailViewController *detailViewController = [[DetailViewController alloc] 
                                                  initWithStyle:UITableViewStyleGrouped];
    Pet *selectedObject = (Pet *)[[self fetchedResultsController] objectAtIndexPath:indexPath];
    detailViewController.pet = selectedObject;

    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
		NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
		[context deleteObject:[fetchedResultsController objectAtIndexPath:indexPath]];
		
		// Save the context.
		NSError *error = nil;
		if (![context save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			DLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
	}   
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}


#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    /*
	 Set up the fetched results controller.
     */
	// Create the fetch request for the entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	// Edit the entity name as appropriate.
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Pet" inManagedObjectContext:managedObjectContext];
	[fetchRequest setEntity:entity];
	
	// Set the batch size to a suitable number.
	[fetchRequest setFetchBatchSize:20];
	
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:BSKeyName ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	// Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
	NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    aFetchedResultsController.delegate = self;
	self.fetchedResultsController = aFetchedResultsController;
	
	[aFetchedResultsController release];
	[fetchRequest release];
	[sortDescriptor release];
	[sortDescriptors release];
	
	return fetchedResultsController;
}    


// NSFetchedResultsControllerDelegate method to notify the delegate that all section and object changes have been processed. 
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	// In the simplest, most efficient, case, reload the table view.
	[self.tableView reloadData];
}

/*
 Instead of using controllerDidChangeContent: to respond to all changes, you can implement all the delegate methods to update the table view in response to individual changes.  This may have performance implications if a large number of changes are made simultaneously.
 
 // Notifies the delegate that section and object changes are about to be processed and notifications will be sent. 
 - (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
 [self.tableView beginUpdates];
 }
 
 - (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
 // Update the table view appropriately.
 }
 
 - (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
 // Update the table view appropriately.
 }
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
 [self.tableView endUpdates];
 } 
 */


#pragma mark -
#pragma mark AddViewControllerDelegate methods
- (void)addViewController:(AddViewController *)controller didFinishWithSave:(BOOL)save
{    
    if (save) {
        NSNotificationCenter *dnc = [NSNotificationCenter defaultCenter];
        // register rootViewController to be notified of NSManagedObjectContextDidSaveNotification
        // if self is notified, call addControllerContextDidSave:
        [dnc addObserver:self 
                selector:@selector(addControllerContextDidSave:)
                    name:NSManagedObjectContextDidSaveNotification 
                  object:self.addingManagedObjectContext];
        NSError *error;
        if (![self.addingManagedObjectContext save:&error]) {
            // Add real error handling code here.
            DLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
        [dnc removeObserver:self
                       name:NSManagedObjectContextDidSaveNotification
                     object:self.addingManagedObjectContext];
    }
    self.addingManagedObjectContext = nil;
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark Notification handling

-(void)addControllerContextDidSave:(NSNotification *)saveNotification
{
    NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
    // Merging changes causes the fetched results controller to update its results
    [context mergeChangesFromContextDidSaveNotification:saveNotification];
}

@end

