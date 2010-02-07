//
//  DetailViewController.m
//  Pets
//
//  Created by Steve Baker on 2/5/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import "DetailViewController.h"
#import "Pet.h"
#import "EditViewController.h"

@implementation DetailViewController

@synthesize pet;


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"in DetailViewController viewDidLoad");

    // Configure the title, title bar, and table view
    self.title = @"Pet Details";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.allowsSelectionDuringEditing = YES;    
}


- (void)viewWillAppear:(BOOL)animated {
    // Redisplay the data
    // If you have a lot of data, you may want to load only the changes.
    // Reloading the entire table could be expensive.
    // In our example we have a small database so it's ok.
    [self.tableView reloadData];
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    // Hide the back button when editing starts, and show it again when editing finishes
    [self.navigationItem setHidesBackButton:editing animated:animated];
    [self.tableView reloadData];
}

- (void)updateRightBarButtonItemState {
    // Conditionally enable the right bar button item
    // enable only if the book is in a valid state for saving
    self.navigationItem.rightBarButtonItem.enabled = [self.pet validateForUpdate:NULL];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2
                                       reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Name";
            cell.detailTextLabel.text = self.pet.name;
            break;
        case 1:
            cell.textLabel.text = @"Animal Type";
            cell.detailTextLabel.text = self.pet.animalType;
            break;
        case 2:
            cell.textLabel.text = @"Breed";
            cell.detailTextLabel.text = self.pet.breed;
            break;
        case 3:
            // Ref http://developer.apple.com/iphone/library/documentation/DataManagement/Conceptual/iPhoneCoreData01/Articles/04_Adding.html
            cell.textLabel.text = @"Date of Birth";
            
            NSDateFormatter *dateFormatter = nil;
            if (dateFormatter == nil) {
                dateFormatter = [[NSDateFormatter alloc] init];                
                [dateFormatter setTimeStyle:NSDateFormatterNoStyle];                
                [dateFormatter setDateStyle:NSDateFormatterShortStyle];
            }
            cell.detailTextLabel.text = [dateFormatter stringFromDate:self.pet.dateOfBirth];
            [dateFormatter release];
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.editing) return;
    
    EditViewController *controller = [[EditViewController alloc] 
                                      initWithNibName:@"EditViewController"
                                      bundle:nil];
    
    controller.editedObject = self.pet;
    switch (indexPath.row) {
        case 0: {
            controller.editedFieldKey = @"name";
            controller.editedFieldName = NSLocalizedString(@"name", @"display name for name");
        }
            break;
        case 1: {
            controller.editedFieldKey = @"animalType";
            controller.editedFieldName = NSLocalizedString(@"animalType", @"display name for animal type");
        }
            break;
        case 2: {
            controller.editedFieldKey = @"breed";
            controller.editedFieldName = NSLocalizedString(@"breed", @"display name for breed");
        }
            break;
        case 3: {
            controller.editedFieldKey = @"dateOfBirth";
            controller.editedFieldName = NSLocalizedString(@"dateOfBirth", @"display name for date of birth");
        }
            break;
    }
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}


// Don't change appearance of cell while editing
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView 
shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


- (void)dealloc {
    [pet release], pet = nil;
    [super dealloc];
}

@end

