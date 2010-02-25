//
//  DetailViewController.m
//  Pets
//
//  Created by Steve Baker on 2/5/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import "Debug.h"
#import "DetailViewController.h"
#import "EditTextViewController.h"
#import "EditDateViewController.h"
#import "EditViewController.h"
#import "Pet.h"

@implementation DetailViewController

@synthesize pet;

- (void)viewDidLoad {
    [super viewDidLoad];
    DLog();

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
    
    EditViewController *controller = nil;
    
    switch (indexPath.row) {
        case 0: {
            controller = [[EditTextViewController alloc] 
                                                  initWithNibName:@"EditTextViewController"
                                                  bundle:nil];
            controller.editedObject = self.pet;
            controller.editedFieldKey = BSKeyName;
            controller.editedFieldName = NSLocalizedString(BSKeyName, @"display name for name");
        }
            break;
        case 1: {
            controller = [[EditTextViewController alloc] 
                                                  initWithNibName:@"EditTextViewController"
                                                  bundle:nil];
            controller.editedObject = self.pet;            
            controller.editedFieldKey = BSKeyAnimalType;
            controller.editedFieldName = NSLocalizedString(BSKeyAnimalType, @"display name for animal type");
        }
            break;
        case 2: {
            controller = [[EditTextViewController alloc] 
                                                  initWithNibName:@"EditTextViewController"
                                                  bundle:nil];
            controller.editedObject = self.pet;            
            controller.editedFieldKey = BSKeyBreed;
            controller.editedFieldName = NSLocalizedString(BSKeyBreed, @"display name for breed");
        }
            break;
        case 3: {
            controller = [[EditDateViewController alloc] 
                                                  initWithNibName:@"EditDateViewController"
                                                  bundle:nil];
            controller.editedObject = self.pet;            
            controller.editedFieldKey = BSKeyDateOfBirth;
            controller.editedFieldName = NSLocalizedString(BSKeyDateOfBirth, @"display name for date of birth");
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

