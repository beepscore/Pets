//
//  AddViewController.m
//  Pets
//
//  Created by Steve Baker on 2/5/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import "AddViewController.h"
#import "Pet.h"
#import "Debug.h"

@implementation AddViewController

@synthesize delegate;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    DLog();
    
    // Override the DetailViewController viewDidLoad with different navigation bar items and title
    self.title = @"New Pet";
    self.navigationItem.leftBarButtonItem = 
    [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                   target:self
                                                   action:@selector(cancel:)] autorelease];
    self.navigationItem.rightBarButtonItem = 
    [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                   target:self
                                                   action:@selector(save:)] autorelease];      
    self.editing = YES;    
}

#pragma mark actions
- (void)cancel:(id)sender {
    // this isn't adding a view controller.  It's passing a reference to an addViewController
    [delegate addViewController:self didFinishWithSave:NO];
}


- (void)save:(id)sender {
    [delegate addViewController:self didFinishWithSave:YES];
}


#pragma mark Memory management
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


//- (void)dealloc {
//    // delegate property was assigned, not retained. Don't release it
//    [super dealloc];
//}

@end
