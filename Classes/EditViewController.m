//
//  EditViewController.m
//  Pets
//
//  Created by Steve Baker on 2/5/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import "EditViewController.h"
#import "BSGlobalValues.h"
#import "Pet.h"

@implementation EditViewController

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


// returns YES if the attribute of the object is a date type.
- (BOOL)attributeIsDateForObject:(NSManagedObject *)aManagedObject key:(NSString *)aKey {
    
    NSEntityDescription *currentEntityDescription = [aManagedObject entity];
    NSDictionary *currentEntityPropertiesDictionary = [currentEntityDescription propertiesByName];
    NSAttributeDescription *currentAttributeDescription = [currentEntityPropertiesDictionary valueForKey:aKey];
    // note NSAttributeType is NSUInteger, not a pointer.  Don't use *
    NSAttributeType currentAttributeType = [currentAttributeDescription attributeType];
    // DLog(@"%@", (NSDateAttributeType == currentAttributeType)? @"Attribute is a date" : @"Attribute is not a date");
    return (NSDateAttributeType == currentAttributeType);
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}


#pragma mark Memory management
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)setView:(UIView *)newView {
    [super setView:newView];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
    [editedObject release], editedObject = nil;
    [editedFieldKey release], editedFieldKey = nil;
    [editedFieldName release], editedFieldName = nil;
}

- (void)dealloc {
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

@end
