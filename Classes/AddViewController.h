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
@class AddViewController;

// declare protocol
@protocol AddViewControllerDelegate
- (void)addViewController:(AddViewController *)controller didFinishWithSave:(BOOL)save;
@end

@interface AddViewController : DetailViewController {
    // declare a delegate that implements AddViewControllerDelegate protocol
    id <AddViewControllerDelegate> delegate;
}

// delegate property always uses assign, not retain, to avoid circular retain.
// Instead, the delegate object will retain the object it is a delegate of
@property (nonatomic, assign) id <AddViewControllerDelegate> delegate;

// this action isn't in a nib file, so we can just use type void instead of IBAction
- (void)cancel:(id)sender;
- (void)save:(id)sender;
@end


