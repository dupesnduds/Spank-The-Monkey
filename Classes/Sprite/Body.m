//
//	Created by Cleave Pokotea on 25/02/09
//
//	Project: Spank the Monkey
//	File: Body.m
//
//	Last modified: 25/02/09
//


#import "Body.h"
#import "STMConfig.h"


@implementation Body


@synthesize name;


-(void) dealloc 
{
    if(name)
    {
        [name release];
        name = nil;
    }
    
    [super dealloc];
}


-(id) init 
{
    if(!(self = [super initWithFile:@"body.png"]))
    {
        return self;
    }
        
    return self;
}


-(CGRect) rect 
{ 
    float w = [self contentSize].width; 
    float h = [self contentSize].height; 
    
    CGPoint point = CGPointMake([self position].x - (w/2), [self position].y + (h/2)); 
    point = [[Director sharedDirector] convertCoordinate:point]; 
    
    return CGRectMake(point.x, point.y, w, h); 
}

@end
