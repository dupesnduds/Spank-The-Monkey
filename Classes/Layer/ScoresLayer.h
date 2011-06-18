//
//	Created by Cleave Pokotea on 25/02/09
//
//	Project: Spank the Monkey
//	File: HighScore.h
//
//	Last modified: 25/02/09
//


#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "Buttons.h"


enum 
{
	kCellHeight = 22,
};


@interface ScoresLayer : Layer <UITableViewDelegate, UITableViewDataSource> 
{
    Sprite * rf;
    Sprite * ds;
    
    Buttons * mm;
    Label * loadingLabel;
    MenuItemFont *item1;
    
    UITableView * myTable;
    
    UIActivityIndicatorView *spinner;
}


+(ScoresLayer *) get;


-(void) positionDefaults;

-(void) message: (NSString *)msg;
-(void) resetMessage: (id) sender;

-(void) goMainMenu;
-(void) downloadScores;
-(void) reloadTable;
-(void) initUIKitStuff;
-(CGRect) rect:(Sprite *) item;

-(void) requestScore;


@end