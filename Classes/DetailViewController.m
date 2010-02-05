//
//  DetailViewController.m
//  Pets
//
//  Created by Steve Baker on 2/5/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import "DetailViewController.h"
#import "Pet.h"

@implementation DetailViewController

@synthesize pet;

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];

    // Configure the title, title bar, and table view
    self.title = @"Pet Details";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.allowsSelectionDuringEditing = YES;    
}


- (void)viewWillAppear:(BOOL)animated {
    // Redisplay the data
    //[super viewWillAppear:animated];
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
 
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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

// TODO: Add row for species here
// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


// TODO:  Add case for species here
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
            cell.detailTextLabel.text = pet.name;
            break;
        case 1:
            cell.textLabel.text = @"Breed";
            cell.detailTextLabel.text = pet.breed;
            break;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

// Don't change appearance of cell while editing
- (UITableViewEditingStyle)tableView:(UITableView *)tableView
editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


- (void)dealloc {
    [pet release], pet = nil;
    [super dealloc];
}


@end

