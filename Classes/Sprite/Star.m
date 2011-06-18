//
//	Created by Cleave Pokotea on 25/02/09
//
//	Project: Spank the Monkey
//	File: Star.m
//
//	Last modified: 25/02/09
//

#import "Star.h"


@implementation Star


@synthesize name;
@synthesize currentState;
@synthesize empty;
@synthesize full;


-(void) dealloc {
    
    if(name) {
        [name release];
        name = nil;
    }
    
    if(empty) {
        [empty release];
        empty = nil;
    }
    
    if(full) {
        [full release];
        full = nil;
    }
    
    [super dealloc];
}


- (id) init {
    self = [super init];
    if (self != nil) {
        
        [self setCurrentState: NO];
        NSLog(@"%d  [%s:%d] ",[self currentState],__FUNCTION__,__LINE__);
        
        empty = [[Sprite spriteWithFile:@"star_empty.png"] retain]; 
        full = [[Sprite spriteWithFile:@"star_filled.png"] retain]; 
    }
    
    return self;
}


-(Sprite *)currentSprite {
    
    //NSLog(@"%d  [%s:%d] ",currentState,__FUNCTION__,__LINE__);
    if(currentState) {
        
        return full;
    } else {
        
        return empty;
    }
}


-(BOOL)currentState {
    
    return currentState;
}


-(void) setCurrentState:(BOOL)b {
    
	currentState = b;
}


@end
