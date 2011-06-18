//
//  Bputil.h
//  YouBrokeMyIphone
//
//  Created by brad on 30/01/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bputil : NSObject 
{
}
+(void) setBadge:(int) badgeNumber;
+(BOOL) isIphone;
+(void) openUrl:(NSString *) anUrl;
+(NSString *) currentTime;
+(int) newRandomInt:(int) maxValue oldValue:(int) aOldValue;
+(int) randomInt:(int) maxValue;
+(void) callJavascriptInWebView:(NSString *) jsCommand webView:(UIWebView *) aWebView;
+(NSString *) deviceName;
+(NSString *) getUrlAsString:(NSURL *)url;
+(BOOL) inStr:(NSString *)subject searchFor:(NSString *) searchFor;
+(void) loadPageInWebView:(NSString *) htmlFilename webView:(UIWebView *) aWebView;
+(NSString *) getFileAsString:(NSString *)aFile type:(NSString *) aType;
+(void) sendEmail:(NSString *) aRecipient subject:(NSString *) aSubject body:(NSString *) aBody;
@end

