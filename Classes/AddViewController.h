//
//  AddViewController.h
//  Pets
//
//  Created by Steve Baker on 2/5/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

// import base class
#import "DetailViewController.h"

// declare protocol.  It could be defined here, but Apple convention
// defines at end of .h file
@protocol AddViewControllerDelegate;

@interface AddViewController : DetailViewController {
    // create a delegate that implements AddViewControllerDelegate protocol
    id <AddViewControllerDelegate> delegate;
}

// !!!!:delegate property always uses assign, not retain, to avoid circular retain.
// Instead, the delegate object will retain the object it is a delegate of,
// the AddViewController instance.
@property (nonatomic, assign) id <AddViewControllerDelegate> delegate;

- (void)cancel:(id)sender;
- (void)save:(id)sender;
@end

// define protocol required methods
@protocol AddViewControllerDelegate
- (void)addViewController:(AddViewController *)controller didFinishWithSave:(BOOL)save;
@end

