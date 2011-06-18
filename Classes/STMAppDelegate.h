//
//  SpankTheMonkeyAppDelegate.h
//  Spank The Monkey
//
//  Created by Cleave Pokotea on 25/02/09.
//  Copyright Tumunu 2009-2011. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "cocoslive.h"
#import "cocos2d.h"


/*
 * LoadScene enums
 *
 * This enum is used as an index to the loadScene: method.  Add
 * additional scenes here if you are going to use the central
 * 
 */
enum 
{
    kSplash = 0,
	kSceneMenu,         // Main Menu Scene
    kSceneGame,         // Game Scene
    kSceneInfo,         // Info Score
    kSceneScore,        // High scores
    kSceneEnd,
	kSceneCount			// Total count of scenes.  Not used in this example but good to have
};


/*
 * Sound effect enum.  
 *
 * Pass in one of these to playEffect: to
 * play the cached sound effect.  Sound effects are all loaded
 * during initialization.
 */
typedef enum 
{
	kEffectFart = 0,
	kEffectDing,
	kEffectChatter,		
	kEffectGasp,
	kEffectGiggle,	
	kEffectSlap, 
    kEffectPunch,
    
    kEffectButton,
    
    kTransInfo,
    kTransScore,
    
    kMenuMusic,

	kNumEffects
} Effect;


enum 
{
	kCategoryShake = 0,
};


enum 
{
	kWorld = 0,
	kCountry = 1,
};



@interface STMAppDelegate : NSObject <UIAccelerometerDelegate, UIAlertViewDelegate, UITextFieldDelegate, UIApplicationDelegate> 
{
	@public UIWindow *window;
    
    // scores category
	int			category;
	// scores world
	int			world;
	
	NSMutableArray *globalScores;
    
    AtlasSpriteManager *mgrOne;
    AtlasSpriteManager *mgrTwo;
    AtlasSprite * bkgnds;
}


@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) NSMutableArray *globalScores;
@property (nonatomic, retain) AtlasSpriteManager *mgrOne;
@property (nonatomic, retain) AtlasSpriteManager *mgrTwo;
@property (nonatomic, retain) AtlasSprite *bkgnds;


-(void) updateScoreArray:(NSMutableArray *) sa;

/*
 * Control all scene loading
 */
- (Scene *)loadScene:(NSInteger)sceneId;

/* 
 * Sound effect methods
 */
+ (void)setEffectsEnabled:(BOOL)enabled;
+ (void)playEffect:(Effect)effect;

+ (BOOL)isEffectsEnabled;


/* 
 * Background music methods 
 */
+ (void)setMusicEnabled:(BOOL)enabled;

+ (BOOL)isMusicEnabled;
+ (BOOL)playBackgroundMusic;
+ (BOOL)stopBackgroundMusic;

+(STMAppDelegate *) get;


@end
