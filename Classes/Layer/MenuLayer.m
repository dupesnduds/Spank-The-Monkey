//
//	Created by Cleave Pokotea on 1/03/09
//
//	Project: Bull Rush
//	File: MenuLayer.m
//
//	Last modified: 1/03/09
//


#import "MenuLayer.h"
#import "STMAppDelegate.h"
#import "STMConfig.h"
#import "SlideShow.h"
#import "AdMobView.h"


#define kBuy 0x00ee09


@implementation MenuLayer


-(void) dealloc
{
    if(buyNow) 
    {
        [buyNow release];
        buyNow = nil;
    }
    
    if(adContainer) 
    {
       [adContainer release];
    }
    
    [adMobAd release];
	[super dealloc];
}


- (id)init 
{
	if(self = [super init])
    {
        // Request an ad
        adMobAd = [AdMobView requestAdWithDelegate:self]; // start a new ad request
        [adMobAd retain]; // this will be released when it loads (or fails to load)ß
        
		// Create the main menu
		[MenuItemFont setFontSize:[[STMConfig get] fontSize]];
		[MenuItemFont setFontName:[[STMConfig get] fontName]];
		
		letsPlay = [MenuItemFont itemFromString:@"Let's play!" target:self selector:@selector(menuPlay:)];
		instructions = [MenuItemFont itemFromString:@"Instructions" target:self selector:@selector(menuInstructions:)];
		highScores = [MenuItemFont itemFromString:@"High Scores" target:self selector:@selector(menuHighScores:)];
        credits = [MenuItemFont itemFromString:@"Credits" target:self selector:@selector(menuCredits:)];
		

        [[letsPlay label] setRGB:75:52:41];
        [[instructions label] setRGB:75:52:41];
        [[highScores label] setRGB:75:52:41];
        [[credits label] setRGB:75:52:41];
        
		
		Menu *menu = [Menu menuWithItems:letsPlay, instructions, highScores,credits, nil];
		[menu alignItemsVertically]; 		
		[self addChild:menu z:4];
        
        isTouchEnabled = YES;
        buyNow = [[Sprite spriteWithFile:@"buy.png"] retain]; 
        [self addChild:buyNow z:3 tag:kBuy];
        [buyNow setPosition:ccp(390, 200)];
        [buyNow runAction: [RotateTo actionWithDuration:1.4 angle:16.0]];
	}
	
	return self;
}

         
- (void)menuPlay:(id)sender 
{

    [STMAppDelegate playEffect:kEffectButton];
    [STMAppDelegate stopBackgroundMusic];
    [[Director sharedDirector] replaceScene:[SplitColsTransition transitionWithDuration:[[STMConfig get] transitionDuration] scene:[[STMAppDelegate get] loadScene:kSceneGame]]];
    
    [self removeAd];
}

         
- (void)menuInstructions:(id)sender 
{
    [STMAppDelegate playEffect:kEffectButton];
    [[Director sharedDirector] replaceScene:[SplitRowsTransition transitionWithDuration:[[STMConfig get] transitionDuration] scene:[[STMAppDelegate get] loadScene:kSceneInfo]]];

    [self removeAd];
}

         
- (void) menuHighScores:(id)sender
{
	[STMAppDelegate playEffect:kEffectButton];
    [[Director sharedDirector] replaceScene:[FadeUpTransition transitionWithDuration:[[STMConfig get] transitionDuration] scene:[[STMAppDelegate get] loadScene:kSceneScore]]];
    
    [self removeAd];
}


- (void)menuCredits:(id)sender 
{
    [STMAppDelegate playEffect:kEffectButton];
    [[Director sharedDirector] replaceScene:[SplitRowsTransition transitionWithDuration:[[STMConfig get] transitionDuration] scene:[[STMAppDelegate get] loadScene:kSceneInfo]]];
    
    [self removeAd];
}


- (void)goToAppStore 
{
	UIApplication * application=[UIApplication sharedApplication]; 
	
	[application openURL: 
	 //[NSURL URLWithString: @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=304298032"] 
     [NSURL URLWithString: @"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=304298032&mt=8"]
	 ]; 
};


- (void) removeAd 
{
    if(adContainer)
    {
        [adContainer removeFromSuperview];
        [adContainer release];
    }
}


- (CGRect) rect:(Sprite *) item 
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
                    if(item.tag == kBuy) 
                    {
                        [buyNow runAction:[ScaleTo actionWithDuration:0.1 scale:0.9f]];
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
                    if(item.tag == kBuy)
                    {
                        [buyNow runAction:[ScaleTo actionWithDuration:0.1 scale:1.2f]];
                        [self goToAppStore];
                        return kEventHandled;
                    }

                }
            } 
        }
    }
    
    return kEventIgnored;
}


#pragma mark -
#pragma mark AdMobDelegate methods

- (NSString *)publisherId 
{
    return @"_____"; // this should be prefilled; if not, get it from www.admob.com
}

- (UIColor *)adBackgroundColor 
{
    return [UIColor colorWithRed:0.271 green:0.592 blue:0.247 alpha:1]; // this should be prefilled; if not, provide a UIColor
}

- (UIColor *)adTextColor 
{
    return [UIColor colorWithRed:1 green:1 blue:1 alpha:1]; // this should be prefilled; if not, provide a UIColor
}

- (BOOL)mayAskForLocation 
{
    return YES; // this should be prefilled; if not, see AdMobProtocolDelegate.h for instructions
}

// Sent when an ad request loaded an ad; this is a good opportunity to attach
// the ad view to the hierachy.
- (void)didReceiveAd:(AdMobView *)adView 
{
    NSLog(@"AdMob: Did receive ad");
    
    //adMobAd.frame = CGRectMake(0, 432, 320, 48); // put the ad at the bottom of the screen
    //[[[STMAppDelegate get] window] addSubview:adMobAdß];
    
    // Create UIView container and add AdMod View
    adContainer = [[UIView alloc] initWithFrame:CGRectMake(-120, 216, 320, 48)];
    adMobAd.frame = CGRectMake(0, 0, 320, 48);
    [adContainer addSubview:adMobAd];
    
    // Rotate UIView container
    CGAffineTransform landscapeTransform = CGAffineTransformMakeRotation(CC_DEGREES_TO_RADIANS(90));
    landscapeTransform = CGAffineTransformTranslate (landscapeTransform, 0.0, 0.0);
    [adContainer setTransform:landscapeTransform];   
    
    // Add UIView container to main window
    [[[STMAppDelegate get] window] addSubview:adContainer];
    
    autoslider = [NSTimer scheduledTimerWithTimeInterval:AD_REFRESH_PERIOD target:self selector:@selector(refreshAd:) userInfo:nil repeats:YES];
}

// Request a new ad. If a new ad is successfully loaded, it will be animated into location.
- (void)refreshAd:(NSTimer *)timer 
{
    [adMobAd requestFreshAd];
}

// Sent when an ad request failed to load an ad
- (void)didFailToReceiveAd:(AdMobView *)adView
{
    NSLog(@"AdMob: Did fail to receive ad");
    [adMobAd release];
    adMobAd = nil;
    // we could start a new ad request here, but in the interests of the user's battery life, let's not
}


@end
