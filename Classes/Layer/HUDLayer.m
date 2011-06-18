//
//	Created by Cleave Pokotea on 25/02/09
//
//	File: HUDLayer.m
//
//	Last modified: 25/02/09
//

#import "HUDLayer.h"
#import "HealthLayer.h"
#import "STMAppDelegate.h"
#import "STMConfig.h"
#import "MenuScene.h"
#import "SoundFx.h"

#define kMainMenuG 0x00ff00
#define kFx 0x00ff01
#define kThing 0x00ff02


@implementation HUDLayer


-(void) dealloc {
    
    if(health) {
        
        [health release];
        health = nil;
    }
    
    if(hudMenu) {
        
        [hudMenu release];
        hudMenu = nil;
    }
    
    if(fx) {
        
        [fx release];
        fx = nil;
    }
    
    if(thing) {
        
        [thing release];
        thing = nil;
    }
    
    [super dealloc];
}


+(HUDLayer *) get {
    
    static HUDLayer *instance;
    if(!instance) {
        
        instance = [[HUDLayer alloc] init];
    }
    
    return instance;
}


- (id) init {
    self = [super init];
    if (self != nil) {
        
        NSLog(@"  [%s:%d] ",__FUNCTION__,__LINE__);
        isTouchEnabled = YES;
        
        [mm setCurrentState:NO];
        mm = [[Buttons alloc] init];
        [self addChild:[mm currentSprite] z:11 tag:kMainMenuG];
        
        health = [[HealthLayer alloc] init];
        [self addChild:health z:10];

        fx = [[SoundFx alloc] init];
        [self addChild:[fx currentSprite] z:13 tag:kFx];
        
        thing = [[Thing alloc] init];  
        [thing setCurrentState: ![[STMConfig get] hitEffect]];
        [self addChild:[thing currentSprite] z:14 tag:kThing];
        
        [self positionDefaults];
    }
    return self;
}


-(void) positionDefaults {
    
    CGSize s = [[Director sharedDirector] winSize];
    //int h = s.height/2;
    //int w = s.width-s.width;
    int h = s.height;
    int w = s.width;
    
    //[[fx currentSprite] setPosition:cpv(w+35, h*2 - 290)];
    [[fx currentSprite] setPosition:ccp(w-32, h/2-136)];
    [[thing currentSprite] setPosition:ccp(s.width-55, s.height-60)];
    [[mm currentSprite] setPosition: ccp([[mm currentSprite] contentSize].width/2+14, 20)];

}


-(void) goMainMenu {
    
    [STMConfig get]->b = YES;
    [[STMConfig get] setScore:0];
    
    [STMAppDelegate playBackgroundMusic];
    [[Director sharedDirector] replaceScene:[FlipXTransition transitionWithDuration:[[STMConfig get] transitionDuration] scene:[[STMAppDelegate get] loadScene:kSceneMenu]]];
}


-(void) changeStar:(int)n {
    
    NSLog(@"%d [%s:%d] ",n,__FUNCTION__,__LINE__);
    [health changeStar:n];
}


-(void) changeSpeaker {
	    
    [STMAppDelegate setEffectsEnabled: ![STMAppDelegate isEffectsEnabled]];
    [fx setCurrentState: [STMAppDelegate isEffectsEnabled]];

    [self removeChildByTag:kFx cleanup:NO];
    [self addChild:[fx currentSprite] z:13 tag:kFx];
    [STMAppDelegate playEffect:kEffectButton];

    [self positionDefaults];
}


-(void) changeThing {
    
    [self removeChildByTag: kThing cleanup:NO];
        
    [self addChild:[thing currentSprite] z:14 tag:kThing];
    [thing setCurrentState: ![thing currentState]];
    [self positionDefaults];
    
    [[STMConfig get] setHitEffect: [thing currentState]];
}


-(CGRect) rect:(Sprite *) item { 
    
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


- (BOOL)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event { 
    
    for(UITouch *touch in touches) { 
        
        CGPoint location = [touch locationInView: [touch view]];   
        location = [[Director sharedDirector] convertCoordinate: location];
        
        for( Sprite *item in children ) { 
            
            if (item.tag != 0xFFFFFFFF) {
                
                if (CGRectContainsPoint([self rect:item], location)) { 
                    
                    if(item.tag == kFx) {
                        
                        return kEventHandled;
                    }
                    
                    if(item.tag == kThing) {
                        
                        return kEventHandled;
                    }
                    
                    if(item.tag == kMainMenuG) {
                        [[mm currentSprite] runAction:[ScaleTo actionWithDuration:0.1 scale:1.2f]];
                        return kEventHandled;
                    }
                }
            } 
        }
    }
    
    return kEventIgnored;
}


- (BOOL)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event { 
    
    for(UITouch *touch in touches) { 
        
        CGPoint location = [touch locationInView: [touch view]];   
        location = [[Director sharedDirector] convertCoordinate: location];
        
        for( Sprite *item in children ) { 
            
            if (item.tag != 0xFFFFFFFF) {
                
                if (CGRectContainsPoint([self rect:item], location)) { 

                    if(item.tag == kFx) {
                        NSLog (@"Speaker Touched!"); 
                        [self changeSpeaker];
                        return kEventHandled;
                    }
                
                    if(item.tag == kThing) {
                        NSLog (@"Thing Touched!"); 
                        [self changeThing];
                        return kEventHandled;
                    }
                    
                    if(item.tag == kMainMenuG) {
                        [[mm currentSprite] runAction:[ScaleTo actionWithDuration:0.1 scale:1.0f]];
                        [STMAppDelegate playEffect:kEffectButton];
                        [self goMainMenu];
                        return kEventHandled;
                    }
                }
            } 
        }
    }
    
    return kEventIgnored;
}


@end