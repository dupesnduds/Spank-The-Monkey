//
//	Created by Cleave Pokotea on 2/03/09
//
//	Project: Spank The Monkey
//	File: EndLayer.h
//
//	Last modified: 2/03/09
//


#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "MonkeyLayer.h"
#import "Buttons.h"


@interface EndLayer : Layer <UIAlertViewDelegate> 
{
    Sprite * fb;
    Sprite * so;
    
    Buttons * mm;
    MonkeyLayer * monkey;

    Label * rankLabel;
    Label * scoreLabel;
    Label * endLabel;
    MenuItemFont *score;
    
    Label * loadingLabel;
    
    BOOL currentState;
    NSString *scoreText;
    UITextField * nameField;
    UIActivityIndicatorView *spinner;
    
    int finalScore;
    NSString * finalRank;
}


@property (readwrite, assign) BOOL currentState;

-(void) message: (NSString *)msg;
-(void) resetMessage: (id) sender;

-(void) positionDefaults;
-(void) goMainMenu;
-(void) preSend;
-(void) postScore:(NSString *) name;
-(CGRect) rect:(Sprite *) item;


@end