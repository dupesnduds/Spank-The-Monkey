//
//  SpankTheMonkeyAppDelegate.m
//  Spank The Monkey
//
//  Created by Cleave Pokotea on 25/02/09.
//  Copyright Tumunu 2009-2011. All rights reserved.
//
#include <sys/time.h>
#import "cocoslive.h"

#import "StaticMethods.h"
#import "STMAppDelegate.h"
#import "MenuScene.h"
#import "HighScore.h"
#import "GameScene.h"
#import "SoundEngine.h"
#import "STMConfig.h"
#import "SplashScene.h"
#import "EndScene.h"
#import "InfoScene.h"
#import "ScoresLayer.h"


#define kListenerDistance 1.0  // Used for creating a realistic sound field
#define kOptionsSetKey @"options"

#define kUpdateInterval (1.0f/10.0f)



/* 
 * Static members related to sound effects and background music 
 */
static BOOL bgMusicPlaying = NO;		// Background music is currently playing
static BOOL bgMusicEnabled = YES;		// Background music is enabled
static BOOL fxEnabled = YES;			// Sound effects are enabled
static UInt32 sounds[kNumEffects];		// References to the loaded sound effects


@implementation STMAppDelegate


@synthesize window;
@synthesize globalScores;
@synthesize mgrOne, mgrTwo;
@synthesize bkgnds;


-(void)dealloc 
{
    if(mgrOne) {
        
        [mgrOne release];
    }
    
    if(mgrTwo) {
        
        [mgrTwo release];
    }
    
    if(bkgnds) {
        
        [bkgnds release];
    }
    
    [globalScores release];
	[super dealloc];
}


+(STMAppDelegate *) get 
{
    return (STMAppDelegate *) [[UIApplication sharedApplication] delegate];
}


- (void)applicationDidFinishLaunching:(UIApplication *)application 
{
    //[[Director sharedDirector] setPixelFormat:kRGBA8];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    NSBundle* bundle = [NSBundle mainBundle];
    
    // Random seed with timestamp.
    srandom(time(nil));

    /*
	 * Initialize the audio engine
	 *
	 * Pilfered from the Apple Crash Landing example
	 */
	SoundEngine_Initialize(44100);									// Set the bitrate
	SoundEngine_SetListenerPosition(0.0, 0.0, kListenerDistance);	// Set the listener position
	
	SoundEngine_LoadEffect([[bundle pathForResource:@"fart" ofType:@"caf"] UTF8String], &sounds[kEffectFart]);
	SoundEngine_LoadEffect([[bundle pathForResource:@"ding" ofType:@"caf"] UTF8String], &sounds[kEffectDing]);
	SoundEngine_LoadEffect([[bundle pathForResource:@"chatter" ofType:@"caf"] UTF8String], &sounds[kEffectChatter]);
	SoundEngine_LoadEffect([[bundle pathForResource:@"gasp" ofType:@"caf"] UTF8String], &sounds[kEffectGasp]);
	SoundEngine_LoadEffect([[bundle pathForResource:@"giggle" ofType:@"caf"] UTF8String], &sounds[kEffectGiggle]);
	SoundEngine_LoadEffect([[bundle pathForResource:@"slap" ofType:@"caf"] UTF8String], &sounds[kEffectSlap]);
    SoundEngine_LoadEffect([[bundle pathForResource:@"punch" ofType:@"caf"] UTF8String], &sounds[kEffectPunch]);
    SoundEngine_LoadEffect([[bundle pathForResource:@"button" ofType:@"caf"] UTF8String], &sounds[kEffectButton]);

    SoundEngine_LoadEffect([[bundle pathForResource:@"instructions_trans" ofType:@"caf"] UTF8String], &sounds[kTransInfo]);
    SoundEngine_LoadEffect([[bundle pathForResource:@"scores_trans" ofType:@"caf"] UTF8String], &sounds[kTransScore]);
    SoundEngine_LoadEffect([[bundle pathForResource:@"forest" ofType:@"caf"] UTF8String], &sounds[kMenuMusic]);


	LOG(@"Audio Engine set [%s:%d] ",__FUNCTION__,__LINE__);
    
	// NEW: Init the window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[window setUserInteractionEnabled:YES];
	[window setMultipleTouchEnabled:YES];

	[[Director sharedDirector] setDeviceOrientation: CCDeviceOrientationLandscapeLeft];
#ifdef DEBUG
	[[Director sharedDirector] setDisplayFPS:YES];
#endif
    [[Director sharedDirector] setAnimationInterval:1.0/60];
	[[Director sharedDirector] attachInWindow:window];

	[window makeKeyAndVisible];
	
	[[Director sharedDirector] runWithScene:[self loadScene:kSplash]];
    //[[Director sharedDirector] runWithScene:[self loadScene:kSceneEnd]];
    [STMAppDelegate setEffectsEnabled:YES];
    
    self.globalScores = [[NSMutableArray alloc] initWithCapacity:50];
	category = kCategoryShake;
	world = kWorld;
    
    [STMAppDelegate playBackgroundMusic];
    
    //[Texture2D saveTexParameters];
    //[Texture2D setAliasTexParameters];
    //mgrTwo = [AtlasSpriteManager spriteManagerWithFile:@"s_bkgnd_2.png" capacity:4];
    //[self addChild:mgrTwo z:0 tag:kTagSpriteManagerTwo];
    //[Texture2D restoreTexParameters];
}


/**
 * This is where I load the scenes.  I do it here so I can replace them
 * and I don't have to change my code everywhere I reference the scenes.
 **/
- (Scene *)loadScene:(NSInteger)sceneId 
{
    LOG_CURRENT_METHOD;
    
	Scene *scene = nil;
	
	//anti piracy
	NSBundle *bundle = [NSBundle mainBundle];
	NSDictionary *info = [bundle infoDictionary];
	
	if ([info objectForKey: @"SignedIdentity"] != nil) {
        
		[scene removeAllChildrenWithCleanup:YES];
	}
    
    switch (sceneId) 
    {
		case kSceneMenu:
			scene = [MenuScene node];
			break;
		case kSceneGame:
			scene = [GameScene node];
			break;
		case kSplash:
            scene = [SplashScene node];
            break;
		case kSceneScore:
			scene = [HighScore node];
			break;
            
		case kSceneInfo:
			scene = [InfoScene node];
			break;
            
		case kSceneEnd:
			scene = [EndScene node];
			break;
	}
	
	return scene;
}


// Somebody doesn't love us anymore.  Close everything up.
-(void) applicationWillTerminate: (UIApplication*) application 
{
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}
-(void) applicationWillResignActive:(UIApplication *)application
{
	[[Director sharedDirector] pause];
}
-(void) applicationDidBecomeActive:(UIApplication *)application
{
	[[Director sharedDirector] resume];
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
	[[TextureMgr sharedTextureMgr] removeAllTextures];
}


#pragma mark Static Members

/*
 * The methods are all related to music and sound effects.  If you aren't going
 * to use any, you can safely remove these
 */

+ (void)setEffectsEnabled:(BOOL)enabled 
{
	fxEnabled = enabled;
}

+ (BOOL)isEffectsEnabled 
{
	return fxEnabled;
}

+ (void)playEffect:(Effect)effect 
{
	if(!fxEnabled) return;
	SoundEngine_StartEffect(sounds[effect]);
}

+ (void)setMusicEnabled:(BOOL)enabled 
{
	bgMusicEnabled = enabled;
}

+ (BOOL)isMusicEnabled 
{
	return bgMusicEnabled;
}

/*
 * This is called to start the background music.  I return a BOOL indicating
 * whether this actually did anything or not.
 */
+ (BOOL)playBackgroundMusic 
{
    NSLog(@"Playing background music [%s:%d] ",__FUNCTION__,__LINE__);
    
	// Ignore this call if the bg music is already playing or bg music is disabled.
	if(bgMusicPlaying || !bgMusicEnabled) return NO;
	
	/*
	 * Have to load the music before we can play it.
	 * You may want to store the filenames somewhere more accesible.
	 */
	SoundEngine_LoadBackgroundMusicTrack([[[NSBundle mainBundle] pathForResource:@"forest" ofType:@"caf"] UTF8String], FALSE, FALSE);
	SoundEngine_SetBackgroundMusicVolume(0.4);
	SoundEngine_StartBackgroundMusic();
	bgMusicPlaying = YES;
	return YES;
}

/*
 * This is called to stop the background music.  I return a BOOL indicating
 * whether this actually did anything or not. 
 */
+ (BOOL)stopBackgroundMusic 
{
    NSLog(@"Stopped background music [%s:%d] ",__FUNCTION__,__LINE__);
    
	// If the background music isn't already playing, we don't have to do anything
	if(!bgMusicPlaying) return NO;
	
	SoundEngine_StopBackgroundMusic(FALSE);
	bgMusicPlaying = NO;
	return YES;
}


//===========================
-(void) updateScoreArray:(NSMutableArray *) sa 
{
    self.globalScores = sa;
}


@end
