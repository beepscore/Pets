//
//  EditViewController.m
//  Pets
//
//  Created by Steve Baker on 2/5/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import "EditViewController.h"
#import "BSGlobalValues.h"

@implementation EditViewController

@synthesize textField;
@synthesize editedObject;
@synthesize editedFieldKey;
@synthesize editedFieldName;


- (void)viewDidLoad {
    
    DLog(@"in EditViewController viewDidLoad");
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
    
    if (BSKeyDateOfBirth == editedFieldKey) {
        
        NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];                
            [dateFormatter setTimeStyle:NSDateFormatterNoStyle];                
            [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        }
        self.textField.text = [dateFormatter stringFromDate:[editedObject valueForKey:editedFieldKey]];
        [dateFormatter release];
        
    } else {
        self.textField.text = [editedObject valueForKey:editedFieldKey];
    }
    self.textField.placeholder = self.title;
    [self.textField becomeFirstResponder];
}


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
    if (BSKeyDateOfBirth == editedFieldKey) {
        
        NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];                
            [dateFormatter setTimeStyle:NSDateFormatterNoStyle];                
            [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        }
        [editedObject setValue:[dateFormatter dateFromString:self.textField.text] forKey:editedFieldKey];
        [dateFormatter release];
        
    } else {
        [editedObject setValue:self.textField.text forKey:editedFieldKey];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
