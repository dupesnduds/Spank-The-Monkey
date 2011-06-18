//
//	Created by Cleave Pokotea on 15/02/09
//
//	Project: RageLite
//	File: Splash.m
//
//	Last modified: 15/02/09
//

#import "SplashLayer.h"
#import "STMAppDelegate.h"
#import "STMConfig.h"


@implementation SplashLayer

- (id) init {
    
    // NOTE: CHanged from Sprite to AtlasSprite 27/3/09
    //self = [super initWithFile:@"splash.png"];
    self = [super initWithRect:CGRectMake(0, 0, 85, 121) spriteManager: [[STMAppDelegate get] mgrTwo]];
    if (self != nil) {
        
        [self setPosition:ccp([self contentSize].width / 2, [self contentSize].height / 2)];
        switching = NO;
    }
    return self;
}


-(void) onEnter {
    [super onEnter];
    [self schedule:@selector(switchScene:)];
}

-(void) switchScene: (ccTime) dt {
    @synchronized(self) {
        
        if(switching) {
            
            return;
        }
        
        switching = YES;
        [self unschedule:@selector(switchScene:)];
        
        
        // Build a transition scene from the splash scene to the game scene.
        /*
        TransitionScene *transitionScene = [[ZoomFlipYTransition alloc] initWithDuration:[[STMConfig get] transitionDuration]
                                                                                   scene:[[STMAppDelegate get] loadScene:kSceneMenu]
                                                                             orientation:kOrientationDownOver];
        */
        TransitionScene *transitionScene = [[FadeTRTransition alloc] initWithDuration:[[STMConfig get] transitionDuration] 
                                                                                   scene:[[STMAppDelegate get] loadScene:kSceneMenu]];
        
        // Start the scene and bring up the menu.
        [[Director sharedDirector] replaceScene:transitionScene];
        [transitionScene release];
    }
}


@end