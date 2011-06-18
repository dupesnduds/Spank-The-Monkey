//
//	Created by Cleave Pokotea on 9/03/09
//
//	Project: Spank The Monkey
//	File: InfoLayer.m
//
//	Last modified: 9/03/09
//


#import "InfoLayer.h"
#import "STMAppDelegate.h"
#import "STMConfig.h"

#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGLDrawable.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "TextureMgr.h"
#import "TextureNode.h"


#define kMainMenu 0x00ff30


@implementation InfoLayer


- (id) init
{
    self = [super init];
    
    if (self != nil)
    {
        isTouchEnabled = YES;
        
        [mm setCurrentState:YES];
        mm = [[Buttons alloc] init];
        [self addChild:[mm currentSprite] z:12 tag:kMainMenu];
        
        [self positionDefaults];
        [STMAppDelegate playEffect:kTransInfo];
    }
    return self;
}


-(void) positionDefaults 
{
    [[mm currentSprite] setPosition: ccp([[mm currentSprite] contentSize].width/2+14, 20)];
}


-(void) goMainMenu 
{
    [STMConfig get]->b = YES;
    [[STMConfig get] setScore:0];
    

    [STMAppDelegate playEffect:kEffectButton];
    [STMAppDelegate playEffect:kTransInfo];

    [[Director sharedDirector] replaceScene:[SplitRowsTransition transitionWithDuration:[[STMConfig get] transitionDuration] scene:[[STMAppDelegate get] loadScene:kSceneMenu]]];
}


- (BOOL)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{ 
    for(UITouch *touch in touches) 
    { 
        CGPoint location = [touch locationInView: [touch view]];   
        location = [[Director sharedDirector] convertCoordinate: location];
        
        for( Sprite *item in children )
        { 
            if (item.tag != 0xFFFFFFFF) 
            {
                if (CGRectContainsPoint([self rect:item], location)) 
                { 
                    if(item.tag == kMainMenu) 
                    {
                        [[mm currentSprite] runAction:[ScaleTo actionWithDuration:0.1 scale:1.2f]];
                        return kEventHandled;
                    }
                }
            } 
        }
    }
    
    return kEventIgnored;
}



- (BOOL)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{ 
    for(UITouch *touch in touches) 
    { 
        CGPoint location = [touch locationInView: [touch view]];   
        location = [[Director sharedDirector] convertCoordinate: location];
        
        for( Sprite *item in children ) 
        { 
            if (item.tag != 0xFFFFFFFF) 
            {
                if (CGRectContainsPoint([self rect:item], location)) 
                { 
                    if(item.tag == kMainMenu) 
                    {
                        [[mm currentSprite] runAction:[ScaleTo actionWithDuration:0.1 scale:1.0f]];
                        [self goMainMenu];
                        return kEventHandled;
                    }
                }
            } 
        }
    }
    
    return kEventIgnored;
}


-(CGRect) rect:(Sprite *) item 
{ 
    CGSize s = [item contentSize]; 
    
    CGRect r = CGRectMake( item.position.x - s.width/2, 
                          item.position.y-s.height/2, 
                          s.width, s.height); 
    
    //cpVect offset = [self absolutePosition]; 
    CGPoint offset = [self convertToWorldSpace:CGPointZero]; 
    
    r.origin.x += offset.x; 
    r.origin.y += offset.y; 
    
    return r; 
}


@end