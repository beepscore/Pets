//
//  Pet.h
//  Pets
//
//  Created by Steve Baker on 2/5/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import <CoreData/CoreData.h>

extern NSString * const BSKeyAnimalType;
extern NSString * const BSKeyBreed;
extern NSString * const BSKeyDateOfBirth;
extern NSString * const BSKeyName;

@interface Pet :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * animalType;
@property (nonatomic, retain) NSString * breed;
@property (nonatomic, retain) NSDate * dateOfBirth;
@property (nonatomic, retain) NSString * name;

@end



