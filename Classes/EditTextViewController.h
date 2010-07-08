//
//  EditTextViewController.h
//  Pets
//
//  Created by Steve Baker on 2/9/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditViewController.h"

@interface EditTextViewController : EditViewController <UITextFieldDelegate> {
    // Xcode will automatically add instance variables to back properties
}

@property (nonatomic, retain) IBOutlet UITextField *textField;

- (void)save;

@end
