//
//	Created by Cleave Pokotea on 15/02/09
//
//	Project: RageLite
//	File: Splash.m
//
//	Last modified: 15/02/09
//


#import "SplashScene.h"
#import "SplashLayer.h"
#import "StaticMethods.h"


@implementation SplashScene


- (void)dealloc 
{
    [super dealloc];
}


- (id) init 
{
    LOG(@"Scene Launched  [%s:%d] ",__FUNCTION__,__LINE__);

    self = [super init];
    
    if (self != nil)
    {        
        Sprite *splash = [[SplashLayer alloc] init];
        [self addChild:splash];
        
        [splash release];
    }
    return self;
}


@end