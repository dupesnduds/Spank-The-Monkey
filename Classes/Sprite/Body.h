//
//	Created by Cleave Pokotea on 25/02/09
//
//	Project: Spank the Monkey
//	File: Body.h
//
//	Last modified: 25/02/09
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

@interface Body : Sprite {
    
    NSString * name;
    
}

@property (readwrite, retain) NSString * name;

-(CGRect) rect;


@end