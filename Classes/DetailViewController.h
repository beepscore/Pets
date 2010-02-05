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
    Pet *pet;
}

@property (nonatomic, retain) Pet *pet;

- (void)updateRightBarButtonItemState;

@end
