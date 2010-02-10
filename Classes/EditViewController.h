//
//  EditViewController.h
//  Pets
//
//  Created by Steve Baker on 2/5/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EditViewController : UIViewController {
    NSManagedObject *editedObject;
    NSString *editedFieldKey;
    NSString *editedFieldName;
}

@property (nonatomic, retain) NSManagedObject *editedObject;
@property (nonatomic, retain) NSString *editedFieldKey;
@property (nonatomic, retain) NSString *editedFieldName;

- (void)cancel;

@end

