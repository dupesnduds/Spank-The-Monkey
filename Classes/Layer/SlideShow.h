//
//  SlideShow.h
//  STM008
//
//  Created by Cleave Pokotea on 27/02/09.
//  Copyright 2009-2011 Tumunu. All rights reserved.
//


/* 
 *  SlideShowLayer by Will Larson and Luke Hatcher. 10/29/2008.
 *  Released under MIT License.
 *  Please check out from repository for full license detail.
 *
 *  Nothing too exiting happening here.
 *  Apologies that it is not in Obj2.0
 *  syntax, but I'm still ambivalent about
 *  the ambiguousness of properties. 
 */

#import <UIKit/UIKit.h>
#import "CocosNode.h"
#import "Layer.h"
#import "Label.h"
#import "Sprite.h"

@interface SlideShow : Layer {
    
    int slidePosition;
    int backgroundXPosition;
    int backgroundYPosition;
    int descriptionXPosition;
    int descriptionYPosition;
    int descriptionHeight;
    int descriptionWidth;
    int fontSize;
    
    NSString * fontName;
    NSMutableArray * backgrounds;
    NSMutableArray * descriptions;
    
    Sprite * background;
    CocosNode * description;
}

/*
 *  This is the only method for adding slides to the slide show.
 */
-(void)addSlideWithBackground: (NSString *)imageString
               andDescription: (NSString *)descString;
/*
 *  Methods for advancing, retreating, and starting the slideshow.
 *  There currently isn't a UI mechanism for retreating to already
 *  seen slides, but you could rig something up if you tried hard 
 *  enough. ;)
 */
-(void)displayFirstSlide;
-(void)displayNextSlide;
-(void)displayPreviousSlide;
-(void)displaySlide: (int)slideNumber;
-(BOOL)hasPreviousSlide;
-(BOOL)hasNextSlide;

/*
 *  Mutators and Accessors
 */
-(NSMutableArray *)backgrounds;
-(NSMutableArray *)descriptions;
-(Sprite *)background;
-(void)setBackground: (Sprite *)aSprite;
-(CocosNode *)description;
-(void)setDescription: (CocosNode *)aCocosNode;
-(NSString *)fontName;
-(void)setFontName: (NSString *)aFontName;
-(int)fontSize;
-(void)setFontSize: (int)anInt;
-(int)slidePosition;
-(void)setSlidePosition: (int)anInt;
-(int)backgroundXPosition;
-(void)setBackgroundXPosition: (int)anInt;
-(int)backgroundYPosition;
-(void)setBackgroundYPosition: (int)anInt;
-(int)descriptionXPosition;
-(void)setDescriptionXPosition: (int)anInt;
-(int)descriptionYPosition;
-(void)setDescriptionYPosition: (int)anInt;
-(int)descriptionWidth;
-(void)setDescriptionWidth: (int)anInt;
-(int)descriptionHeight;
-(void)setDescriptionHeight: (int)anInt;
@end