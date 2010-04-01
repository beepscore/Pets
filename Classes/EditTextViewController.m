//
//  EditTextViewController.m
//  Pets
//
//  Created by Steve Baker on 2/9/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import "EditTextViewController.h"
#import "Debug.h"


@implementation EditTextViewController

@synthesize textField;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    DLog();
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.textField.placeholder = self.editedFieldName;
    // if valueForKey is nil, placeholder will show instead
    self.textField.text = [self.editedObject valueForKey:self.editedFieldKey];
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
    self.textField = nil;
    
    [super viewDidUnload];
}

- (void)dealloc {

    [super dealloc];
}


- (void)save {
    
    [self.editedObject setValue:self.textField.text forKey:self.editedFieldKey];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark textField delegate methods
// When user presses Return (or Done) key, resignFirstResponder will dismiss the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)aTextField {
    [aTextField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)aTextField {
    // do nothing.  Make user press save button
}

@end
