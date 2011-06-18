//
//	Created by Cleave Pokotea on 1/03/09
//
//	Project: Bull Rush
//	File: MenuLayer.h
//
//	Last modified: 1/03/09
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "AdMobDelegateProtocol.h";


#define AD_REFRESH_PERIOD 40.0 // display fresh ads once per minute


@class AdMobView;


@interface MenuLayer : Layer <AdMobDelegate> {
    
    UIView *adContainer;
    AdMobView *adMobAd;   // the actual ad; self.view is the location where the ad will be placed
    NSTimer *autoslider; // timer to slide in fresh ads
    
    Sprite * buyNow;

    MenuItemFont *letsPlay;
    MenuItemFont *instructions;
    MenuItemFont *highScores;
    MenuItemFont *credits;
}

- (void)menuPlay:(id)sender;
- (void)menuInstructions:(id)sender;
- (void)menuHighScores:(id)sender;


- (void)goToAppStore;
- (void) removeAd;

-(CGRect) rect:(Sprite *) item;

@end