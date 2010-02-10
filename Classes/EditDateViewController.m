//
//  EditDateViewController.m
//  Pets
//
//  Created by Steve Baker on 2/9/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import "BSGlobalValues.h"
#import "EditDateViewController.h"


@implementation EditDateViewController

@synthesize datePicker;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    DLog();
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSDate *dateFromEditedObject = [self.editedObject valueForKey:self.editedFieldKey];
    
    if (nil == dateFromEditedObject) {
        NSDate *dateNow = [[NSDate alloc] init];
        self.datePicker.date = dateNow;
        [dateNow release];
    } else {
        self.datePicker.date = dateFromEditedObject;
    }
}



#pragma mark Memory management
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)setView:(UIView *)newView {
    if (nil == newView) {
        self.datePicker = nil;
    }
    [super setView:newView];
}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    [datePicker release], datePicker = nil;
}

- (void)dealloc {
    [datePicker release], datePicker = nil;
    [super dealloc];
}


- (void)save {
    
    [self.editedObject setValue:self.datePicker.date forKey:self.editedFieldKey];    
    [self.navigationController popViewControllerAnimated:YES];
}

@end


