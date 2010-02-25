// 
//  Pet.m
//  Pets
//
//  Created by Steve Baker on 2/5/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import "Pet.h"

NSString * const BSKeyAnimalType = @"animalType";
NSString * const BSKeyBreed = @"breed";
NSString * const BSKeyDateOfBirth = @"dateOfBirth";
NSString * const BSKeyName = @"name";

@implementation Pet 

// @dynamic tells compiler that another class will supply accessor methods at run time.
@dynamic animalType;
@dynamic breed;
@dynamic dateOfBirth;
@dynamic name;

@end
