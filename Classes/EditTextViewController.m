//
//  EditTextViewController.m
//  Pets
//
//  Created by Steve Baker on 2/9/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import "EditTextViewController.h"
#import "BSGlobalValues.h"


@implementation EditTextViewController

@synthesize textField;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    DLog(@"in EditTextViewController viewDidLoad");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.textField.text = [self.editedObject valueForKey:self.editedFieldKey];
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
}

- (void)dealloc {
    [textField release], textField = nil;
    [super dealloc];
}


- (void)save {
    
    [self.editedObject setValue:self.textField.text forKey:self.editedFieldKey];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
