//
//	Created by Cleave Pokotea on 25/02/09
//
//	Project: Spank the Monkey
//	File: Health.m
//
//	Last modified: 25/02/09
//


#import "HealthLayer.h"
#import "Star.h"
#import "STMConfig.h"


@implementation HealthLayer


-(void) dealloc 
{
    if(star1) 
    {
        [star1 release];
        star1 = nil;
    }
    
    if(star2) 
    {
        [star2 release];
        star2 = nil;
    }
    
    if(star3) 
    {
        [star3 release];
        star3 = nil;
    }
    
    if(star4) 
    {
        [star4 release];
        star4 = nil;
    }
    
    [super dealloc];
}


- (id) init 
{
    self = [super init];
    if (self != nil) 
    {
        star1 = [[Star alloc] init];
        [self addChild:[star1 currentSprite] z:10 tag:kStarOne];
        
        star2 = [[Star alloc] init];
        [self addChild:[star2 currentSprite] z:10 tag:kStarTwo];
        
        star3 = [[Star alloc] init];
        [self addChild:[star3 currentSprite] z:10 tag:kStarThree];
        
        star4 = [[Star alloc] init];
        [self addChild:[star4 currentSprite] z:10 tag:kStarFour];
        
        [self positionDefaults];
    }
    return self;
}


-(void) positionDefaults 
{
    CGSize s = [[Director sharedDirector] winSize];

    int h = s.height-298;
    int w = s.width/2-29;
    
    // 6 pixel spacing between objects
    [[star1 currentSprite] setPosition:ccp(w, h)];
    [[star2 currentSprite] setPosition:ccp(w+45, h)];
    [[star3 currentSprite] setPosition:ccp(w+90, h)];
    [[star4 currentSprite] setPosition:ccp(w+135, h)];
}


-(void) changeStar:(int)n 
{
    //[self removeByTag:n];
    [self removeChildByTag:n cleanup:NO];
    
    switch (n) 
    {
        case kStarOne:
            [star1 setCurrentState: YES];
            [self addChild:[star1 currentSprite] z:13 tag:n];
            [self morph:[star1 currentSprite]];
            break;
            
        case kStarTwo:
            [star2 setCurrentState: YES];
            [self addChild:[star2 currentSprite] z:13 tag:n];
            [self morph:[star2 currentSprite]];
            break;
            
        case kStarThree:
            [star3 setCurrentState: YES];
            [self addChild:[star3 currentSprite] z:13 tag:n];
            [self morph:[star3 currentSprite]];
            break;
        case kStarFour:
            [star4 setCurrentState: YES];
            [self addChild:[star4 currentSprite] z:13 tag:n];
            [self morph:[star4 currentSprite]];
            break;
            
        default:
            break;
    }
    
    [self positionDefaults];
}


-(void) morph:(Sprite *)s 
{
    [s runAction:[Sequence actions:[ScaleTo actionWithDuration: 0.5 scale:1.5f],[ScaleTo actionWithDuration: 0.5 scale:1.0f],nil]];
}


@end