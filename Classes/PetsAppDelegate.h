//
//  PetsAppDelegate.h
//  Pets
//
//  Created by Steve Baker on 2/3/10.
//  Copyright Beepscore LLC 2010. All rights reserved.
//

@interface PetsAppDelegate : NSObject <UIApplicationDelegate> {
    
    // Managed Object Model (MOM) - object representation of the database schema.
    // The database schema describes entities and relationships
    NSManagedObjectModel *managedObjectModel;
    // Managed Object Context (MOC) - scratchpad, manages object lifecycle.
    // Holds inserts, deletes, and updates until we save.
    NSManagedObjectContext *managedObjectContext;
    // Persistent Store Coordinator (PSC) manages Persistent Object Store (POS).
    // Gets objects in and out of database
    NSPersistentStoreCoordinator *persistentStoreCoordinator;

    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

- (NSString *)applicationDocumentsDirectory;

@end

