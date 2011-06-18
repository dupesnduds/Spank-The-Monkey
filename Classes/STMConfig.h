//
//  STMConfig.h
//  Spank The Monkey
//
//  Created by Cleave Pokotea on 25/02/09.
//  Copyright 2009-2011 Tumunu. All rights reserved.
//


#import "cocos2d.h"


enum 
{
	kTagTileMap = 1,
	kTagSpriteManagerOne = 1,
    kTagSpriteManagerTwo = 1,
	kTagAnimation1 = 1,
};


enum
{ 
    kStars = 0xaabbcc00, 
    kStarOne = kStars | 0x01, 
    kStarTwo = kStars | 0x02,
    kStarThree = kStars | 0x03,
    kStarFour = kStars | 0x04,
    kStarMax, 
}; 


@interface STMConfig : NSObject 
{
    @public BOOL b;
    NSUserDefaults * defaults;
}

//@property (readwrite) BOOL b;
@property (readonly) float stmScale;
@property (readwrite) int fontSize;
@property (readwrite) int smallFontSize;
@property (readwrite, assign) NSString * fontName;
@property (readwrite, assign) NSString * fixedFontName;
@property (readwrite) int timerFontSize;
@property (readwrite, assign) NSString * timerFontName;

@property (readwrite) ccTime transitionDuration;
@property (readwrite) int score;
@property (readwrite) int bonus;

@property (readwrite) BOOL hitEffect;

+(STMConfig *) get;


@end
