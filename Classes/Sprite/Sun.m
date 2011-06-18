//
//	Created by Cleave Pokotea on 25/02/09
//
//	Project: Spank the Monkey
//	File: Sun.m
//
//	Last modified: 25/02/09
//


#import "Sun.h"
#import "STMConfig.h"


@implementation Sun


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
    if(!(self = [super initWithFile:@"sun.png"]))
    {
        return self;
    }
    
    [self runAction: [RepeatForever actionWithAction: [Sequence actions: [ScaleTo actionWithDuration:0.5 scale:1.5f],[ScaleTo actionWithDuration:0.5 scale:1.2f], nil]]];
    
    return self;
}


-(CGSize) contentSize 
{
    return CGSizeMake([super contentSize].width * [self scale], [super contentSize].height * [self scale]);
}


@end
