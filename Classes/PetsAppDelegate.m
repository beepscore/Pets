//
//  PetsAppDelegate.m
//  Pets
//
//  Created by Steve Baker on 2/3/10.
//  Copyright Beepscore LLC 2010. All rights reserved.
//

#import "PetsAppDelegate.h"
#import "RootViewController.h"
#import "Debug.h"

// declare anonymous category for "private" methods, avoid showing in .h file
// Note in Objective C no method is private, it can be called from elsewhere.
// Ref http://stackoverflow.com/questions/1052233/iphone-obj-c-anonymous-category-or-private-category
@interface PetsAppDelegate ()

- (void) saveManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext;
- (void) handleManagedObjectContextSaveError:(NSError *)anError;
- (void) handlePersistentStoreCoordinatorAddError:(NSError *)anError;

@end


@implementation PetsAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    

	RootViewController *rootViewController = (RootViewController *)[self.navigationController topViewController];
	rootViewController.managedObjectContext = self.managedObjectContext;
	
	[window addSubview:[self.navigationController view]];
    [window makeKeyAndVisible];
}

/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application
{
	[self saveManagedObjectContext:managedObjectContext];
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // for iOS4, implement applicationDidEnterBackground: similar to applicationWillTerminate:
    // ref http://stackoverflow.com/questions/3106732/ios-4-core-data-any-changes-with-multitasking
	[self saveManagedObjectContext:managedObjectContext];
}


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    // The store coordinator wasn't set previously.  We wait until here to load it, an example of "lazy loading".	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        // The managed object context wasn't instantiated previously.
        // We wait until here to load it, an example of "lazy loading".	
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        // The persistent store coordinator wasn't set previously.
        // We wait until here to set it, another example of "lazy loading".	
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"Pets.sqlite"]];
	
	NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) 
    {
        //	Typical reasons for an error here include:
        //	The persistent store is not accessible
        //	The schema for the persistent store is incompatible with current managed object model
        //	Check the error message to determine what the actual problem was.
        
        // handle error
        [self handlePersistentStoreCoordinatorAddError:error];        
    }	
    return persistentStoreCoordinator;
}


- (void) saveManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext
{
    NSError *error = nil;
    if (aManagedObjectContext != nil)
    {
        // if we have changes, call save, pass pointer (address) to store any error(s), get BOOL result.
        // - (BOOL)save:(NSError **)errorPointer returns YES if successful, otherwise NO        
        if ([aManagedObjectContext hasChanges] && ![aManagedObjectContext save:&error])
        {
			// handle error
            [self handleManagedObjectContextSaveError:error];
        } 
    }    
}


- (void) handleManagedObjectContextSaveError:(NSError *)anError
{
    DLog(@"Unresolved error %@, %@", anError, [anError userInfo]);
    
    // abort() causes the application to generate a crash log and terminate.
    // if abort() runs, the console will show something like Program received signal: "SIGABORT".
    // You should not use abort() in a shipping application, although it may be useful during development.
    // abort();
    
    // If it is not possible to recover from the error, 
    // display an alert panel that instructs the user to quit the application by pressing the Home button.
    
    UIAlertView *MOCSaveErrorAlert = [[UIAlertView alloc] 
                                      initWithTitle:@"Error saving data"
                                      message:@"Please press OK, then close program"
                                      delegate:nil
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
    [MOCSaveErrorAlert show];
    [MOCSaveErrorAlert release];    
}


- (void) handlePersistentStoreCoordinatorAddError:(NSError *)anError
{
    DLog(@"Unresolved error %@, %@", anError, [anError userInfo]);
    
    // display an alert panel that instructs the user to quit the application by pressing the Home button.
    UIAlertView *PSCAddErrorAlert = [[UIAlertView alloc] 
                                     initWithTitle:@"Error adding data"
                                     message:@"Please press OK, then close program"
                                     delegate:nil
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
    [PSCAddErrorAlert show];
    [PSCAddErrorAlert release];    
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	
    [managedObjectContext release], managedObjectContext = nil;
    [managedObjectModel release], managedObjectModel = nil;
    [persistentStoreCoordinator release], persistentStoreCoordinator = nil;
    
	[navigationController release], navigationController = nil;
	[window release], window = nil;
	[super dealloc];
}


@end

