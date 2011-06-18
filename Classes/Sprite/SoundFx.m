//
//	Created by Cleave Pokotea on 26/02/09
//
//	Project: Spank the Monkey
//	File: Speaker.m
//
//	Last modified: 26/02/09
//


#import "SoundFx.h"


@implementation SoundFx

@synthesize name;
@synthesize currentState;
@synthesize mute;
@synthesize on;


-(void) dealloc 
{
    if(name) 
    {
        [name release];
        name = nil;
    }
    
    if(mute) 
    {
        [mute release];
        mute = nil;
    }
    
    if(on) 
    {
        [on release];
        on = nil;
    }
    
    [super dealloc];
}


- (id) init
{
    self = [super init];
    if (self != nil)
    {
        [self setCurrentState: YES];        
        mute = [[Sprite spriteWithFile:@"sound_mute.png"] retain]; 
        on = [[Sprite spriteWithFile:@"sound.png"] retain]; 
    }
    
    return self;
}


-(Sprite *)currentSprite
{
    if(currentState)
    {
        return on;
    } else {
        
        return mute;
    }
}


-(BOOL)currentState
{
    return currentState;
}

-(void) setCurrentState:(BOOL)b 
{
	currentState = b;
}


@end
