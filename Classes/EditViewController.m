//
//  EditViewController.m
//  Pets
//
//  Created by Steve Baker on 2/5/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import "EditViewController.h"


@implementation EditViewController

@synthesize textField;
@synthesize editedObject;
@synthesize editedFieldKey;
@synthesize editedFieldName;


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


- (void)viewDidLoad {

    // Set the title to the user-visible name of the field
    self.title = editedFieldName;
    
    // Configure the save and cancel buttons
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] 
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                   target:self
                                   action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButton;
    [saveButton release];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] 
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                   target:self
                                   action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    [cancelButton release];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    textField.text = [editedObject valueForKey:editedFieldKey];
    textField.placeholder = self.title;
    [textField becomeFirstResponder];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark Memory management
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)setView:(UIView *)newView {
    if (nil == newView) {
        self.textField = nil;
    }
    [super setView:newView];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
    [textField release], textField = nil;
    [editedObject release], editedObject = nil;
    [editedFieldKey release], editedFieldKey = nil;
    [editedFieldName release], editedFieldName = nil;
}

- (void)dealloc {
    [textField release], textField = nil;
    [editedObject release], editedObject = nil;
    [editedFieldKey release], editedFieldKey = nil;
    [editedFieldName release], editedFieldName = nil;
    [super dealloc];
}


#pragma mark actions
- (void)cancel {
    // Don't pass current value to the edited object, just pop
    [self.navigationController popViewControllerAnimated:YES];   
}
- (void)save {
    [editedObject setValue:textField.text forKey:editedFieldKey];
    [self.navigationController popViewControllerAnimated:YES];
}
@end