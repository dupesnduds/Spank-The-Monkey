//
//  CEnums.h
//  intothefire
//
//  Created by mtt on 23/06/09.
//  Copyright 2009-2011 Tumunu. All rights reserved.
//
typedef enum tagKeyState {
	kKeyStateGrabbed,
	kKeyStateUngrabbed
} KeyState;

typedef struct {
    GLfloat     s;
    GLfloat     t;
} TextureCoord3D;

// http://old_wiki.modthesims2.com/InstanceFormats?show_comments=1
enum { 
    kMgr = 0x07BDDF1C,
    kMgrKeys = kMgr | 0x01, 
    kMgrLetters = kMgr | 0x02, 
    kMgrAssests = kMgr | 0x03,
    kMgrCount, 
}; 

enum { 
    kGameWorld = 0x088E1962,
    kGameWorldPuzzle = kGameWorld | 0x01, 
    kGameWorldQuestion = kGameWorld | 0x02, 
    kGameWorldPlus = kGameWorld | 0x03,
    kGameWorldReturn = kGameWorld | 0x04,
    kGameWorldSpeech = kGameWorld | 0x05,
    kGameWorldSpeaker = kGameWorld | 0x06,
    kGameWorldCount, 
}; 

enum { 
    kGameBoard = 0x084344E0,
    kGameBoardKeyboard = kGameBoard | 0x01, 
    kGameBoardMask = kGameBoard | 0x02, 
    kGameBoardCount, 
}; 

enum { 
    kCloud = 0x096E6739,
    kCloudSprite = kCloud | 0x01, 
    kCloudCount, 
}; 

