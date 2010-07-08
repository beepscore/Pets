//
//  DetailViewController.h
//  Pets
//
//  Created by Steve Baker on 2/5/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Pet;

@interface DetailViewController : UITableViewController {
    // Xcode will automatically add instance variables to back properties
}

@property (nonatomic, retain) Pet *pet;

- (void)updateRightBarButtonItemState;

@end
