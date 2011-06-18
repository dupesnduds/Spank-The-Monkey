//
//  main.m
//  STM009
//
//  Created by Cleave Pokotea on 4/03/09.
//  Copyright Tumunu 2009-2011. All rights reserved.
//

#import <UIKit/UIKit.h>

/* 
 * Define LITE if building the lite version
 */
#define LITE

int main(int argc, char *argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"STMAppDelegate");
    [pool release];
    return retVal;
}
