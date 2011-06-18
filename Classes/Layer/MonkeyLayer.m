//
//	Created by Cleave Pokotea on 25/02/09
//
//	Project: RageLite
//	File: Monkey.m
//
//	Last modified: 25/02/09
//


#import "MonkeyLayer.h"
#import "Body.h"
#import "NormalHead.h"
#import "HitHead.h"


@implementation MonkeyLayer


@synthesize nh, body;
@synthesize hh;


-(void) dealloc 
{
    if(nh) 
    {
        [nh release];
        nh = nil;
    }
    
    if(hh) 
    {
        [hh release];
        hh = nil;
    }
    
    if(body)
    {
        [body release];
        body = nil;
    }
    
    [super dealloc];
}


- (id) init 
{
    self = [super init];
    if (self != nil)
    {
        s = [[Director sharedDirector] winSize];
        
        body = [[Body alloc] init];
        [self addChild:body z:10];
        
        
        nh = [[NormalHead alloc] init];
        [self addChild:nh z:11];
        
        hh = [[HitHead alloc] init];
        [self addChild:hh z:12];
        [hh setVisible:NO];
        
        [self setCurrentState:YES];
        [self positionDefaults];
    }
    return self;
}


-(void) positionDefaults 
{
    [nh setPosition:ccp(s.width/2, s.height/2+10)];
    [hh setPosition:ccp(s.width/2, s.height/2+10)];
    [body setPosition:ccp(s.width/2, s.height/2-80)];
}


-(Sprite *)currentHead 
{
    NSLog(@"%d  [%s:%d] ",currentState,__FUNCTION__,__LINE__);
    if(currentState) {
        
        return nh;
    } else {
        [hh setVisible:YES];
        [nh setVisible:NO];
        return hh;
    }
}


-(BOOL)currentState 
{
    return currentState;
}
-(void) setCurrentState:(BOOL)b {
    
	currentState = b;
}


-(void) monkeyJump 
{
    NSLog(@" [%s:%d] ",__FUNCTION__,__LINE__);
    [body stopAllActions];
    [[self currentHead] stopAllActions];
    
    [body runAction:[JumpBy actionWithDuration:2 position:ccp(0,0) height:15 jumps:8]];
    [[self currentHead] runAction:[RotateBy actionWithDuration:1  angle: 360]];
}


-(void) monkeyScale 
{
    [body runAction:[Sequence actions:
                [MoveTo actionWithDuration: 0.1 position:ccp(s.width/2, s.height/2-50)],
                [MoveTo actionWithDuration: 0.1 position:ccp(s.width/2, s.height/2-80)],
                nil]
    ];
        
    [[self currentHead] runAction:[Sequence actions:
            [ScaleTo actionWithDuration: 0.1 scale:0.7f],
            [ScaleTo actionWithDuration: 0.1 scale:1.0f],
            nil]
    ];
}


-(void) monkeyMove 
{
    id jump = [JumpBy actionWithDuration:2 position:ccp(10,0) height:15 jumps:4];
	id action = [Sequence actions: jump, [jump reverse], nil];
	
	[[self currentHead] runAction:action];
    [body runAction:action];
}


-(void) monkeyWin 
{
    NSLog(@" [%s:%d] ",__FUNCTION__,__LINE__);
    [body stopAllActions];
    [[self currentHead] stopAllActions];
    
    [body runAction:[JumpBy actionWithDuration:2 position:ccp(0,0) height:15 jumps:8]];
}



@end