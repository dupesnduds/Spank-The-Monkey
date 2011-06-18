//
//	Created by Cleave Pokotea on 25/02/09
//
//	Project: Spank the Monkey
//	File: StageLayer.h
//
//	Last modified: 25/02/09
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "Sun.h"
#import "CloudLayer.h"


@interface StageLayer : Layer {

    Sun * sun;
    CloudLayer * clouds;
}


@end