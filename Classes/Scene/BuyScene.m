//
//	Created by Cleave Pokotea on 25/03/09
//
//	Project: Spank The Monkey
//	File: BuyScene.m
//
//	Last modified: 25/03/09
//


#import "BuyScene.h"
#import "BuyLayer.h"


@implementation BuyScene

- (id) init 
{
    self = [super init];
    
    if (self != nil) 
    {
        BuyLayer *layer = [BuyLayer node];
		[self addChild:layer];
    }
    return self;
}


@end