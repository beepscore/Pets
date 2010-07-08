//
//  EditDateViewController.h
//  Pets
//
//  Created by Steve Baker on 2/9/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditViewController.h"

@interface EditDateViewController : EditViewController {
    // Xcode will automatically add instance variables to back properties
}

@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;

- (void)save;

@end
