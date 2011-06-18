//
//	Created by Cleave Pokotea on 27/02/09
//
//	Project: Spank The Monkey
//	File: Object.m
//
//	Last modified: 27/02/09
//

#import "Thing.h"


@implementation Thing


@synthesize name;
@synthesize currentState;
@synthesize paddle;
@synthesize glove;


-(void) dealloc {
    
    if(name) {
        [name release];
        name = nil;
    }
    
    if(paddle) {
        [paddle release];
        paddle = nil;
    }
    
    if(glove) {
        [glove release];
        glove = nil;
    }
    
    [super dealloc];
}


- (id) init {
    self = [super init];
    if (self != nil) {
        
        NSLog(@"%d  [%s:%d] ",[self currentState],__FUNCTION__,__LINE__);
        [self setCurrentState:YES];
        paddle = [[Sprite spriteWithFile:@"paddle.png"] retain]; 
        glove = [[Sprite spriteWithFile:@"glove.png"] retain]; 
    }
    
    return self;
}


-(Sprite *) currentSprite {
    
    NSLog(@"currentState: %d  [%s:%d] ",currentState,__FUNCTION__,__LINE__);
    if(currentState) {
        
        return paddle;
    } else {
        
        return glove;
    }
}


-(BOOL)currentState {
    
    return currentState;
}
-(void) setCurrentState:(BOOL)b {
    
	currentState = b;
}

@end
