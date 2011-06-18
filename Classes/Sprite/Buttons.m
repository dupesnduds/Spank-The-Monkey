//
//  Buttons.m
//  STM009
//
//  Created by Cleave Pokotea on 9/03/09.
//  Copyright 2009-2011 Tumunu. All rights reserved.
//

#import "Buttons.h"


@implementation Buttons

@synthesize currentState;
@synthesize mm_normal;
@synthesize mm_green;


-(void) dealloc {
    
    if(mm_normal) {
        [mm_normal release];
        mm_normal = nil;
    }
    
    if(mm_green) {
        [mm_green release];
        mm_green = nil;
    }
    
    [super dealloc];
}


- (id) init {
    self = [super init];
    if (self != nil) {
        
        [self setCurrentState: YES];        
        mm_normal = [[Sprite spriteWithFile:@"b_mainmenu.png"] retain]; 
        mm_green = [[Sprite spriteWithFile:@"b_mainmenu_g.png"] retain]; 
    }
    
    return self;
}


-(Sprite *)currentSprite {
    
    if(currentState) {
        
        return mm_normal;
    } else {
        
        return mm_green;
    }
}


-(BOOL)currentState {
    
    return currentState;
}
-(void) setCurrentState:(BOOL)b {
    
	currentState = b;
}


@end
