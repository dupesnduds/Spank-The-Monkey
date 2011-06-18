#import "Bputil.h"

@implementation Bputil
+(NSString *) currentTime
{
	NSDate *today = [NSDate date];
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"h:mma"];
	NSString *result = [dateFormat stringFromDate:today];
	[dateFormat release];
    return result;
}

+ (NSData *) getUrlAsData:(NSURL *)url
{
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
												cachePolicy:NSURLRequestReturnCacheDataElseLoad
											timeoutInterval:30];
	// Fetch the JSON response
	NSData *urlData;
	NSURLResponse *response;
	NSError *error;
	
	// Make synchronous request
	urlData = [NSURLConnection sendSynchronousRequest:urlRequest
									returningResponse:&response
												error:&error];
    return urlData;	
}

+ (int) randomInt:(int) maxValue
{
    return (random() % maxValue);
}

// Returns a random integer, and ensures it can't be the value that was used last time.
+ (int) newRandomInt:(int) maxValue oldValue:(int) aOldValue
{
	int result;
	for (int i=0; i < maxValue; i++)
	{
		result = [Bputil randomInt: maxValue];
        if (result != aOldValue)
			break;
	}	
	
    return result;
}

+ (NSString *) getUrlAsString:(NSURL *)url
{
	NSData *urlData = [Bputil getUrlAsData: url];
	return [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
}

+ (void) callJavascriptInWebView:(NSString *) jsCommand webView:(UIWebView *) aWebView
{
  [aWebView stringByEvaluatingJavaScriptFromString:jsCommand];
}

+(void) openUrl:(NSString *) anUrl
{
	NSURL *myURL = [NSURL URLWithString:anUrl];
	[[UIApplication sharedApplication] openURL:myURL];
}

+(NSString *) escapeString:(NSString *) anUrl
{
	NSString *result = [anUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	return result;
}

+(void) sendEmail:(NSString *) aRecipient subject:(NSString *) aSubject body:(NSString *) aBody
{
	NSString *recipient = [aRecipient stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSString *subject = [Bputil escapeString: aSubject];
	NSString *body = [Bputil escapeString: aBody];
	
	NSString *format = @"mailto:%@?subject=%@&body=%@";
	NSString *anUrl = [NSString stringWithFormat:format, recipient, subject, body];
	
	[Bputil openUrl: anUrl];	
}

// Display a number by the icon of your app. 
+(void) setBadge:(int) badgeNumber
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badgeNumber];
}

+(void) loadPageInWebView:(NSString *) htmlFilename webView:(UIWebView *) aWebView
{
	NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
	NSString *format = @"%@/%@";
	NSString *anUrl = [NSString stringWithFormat:format,resourcePath, htmlFilename];
	NSURL *baseURL = [NSURL fileURLWithPath:anUrl];
	
	NSString *htmlData = [Bputil getFileAsString:htmlFilename type:@"html"];
	if (htmlData) {  
		[aWebView loadHTMLString:htmlData baseURL:baseURL];  
	}  
}

+(BOOL) isIphone
{
	UIDevice *aDevice = [UIDevice currentDevice];
	
	NSString *deviceId = [aDevice model];
	
	BOOL result = [Bputil inStr:deviceId searchFor:@"iPhone"];
	
	return result;
}

+(BOOL) isItouch
{
	return ! [Bputil isIphone];
}

+(NSString *) uniqueIdentifier
{
	UIDevice *aDevice = [UIDevice currentDevice];
	
	return [aDevice uniqueIdentifier];
}

+(BOOL) inStr:(NSString *)subject searchFor:(NSString *) searchFor
{
    return ([subject rangeOfString:searchFor options:NSCaseInsensitiveSearch].location != NSNotFound);
}

+(NSString *) deviceName
{
	if ([Bputil isIphone])
		return @"iphone";
	return @"itouch";
}

+ (NSString *) getFileAsString:(NSString *)aFile type:(NSString *) aType
{
	NSString *docDirectory = [aFile stringByDeletingLastPathComponent];
	
	NSString *docFilename = [aFile lastPathComponent];
	
    NSString *filePath = [[NSBundle mainBundle] pathForResource:docFilename ofType:aType inDirectory:docDirectory];
	if (filePath) 
	{  
		NSString *result = [NSString stringWithContentsOfFile:filePath];  
		return result;
	}
	
	return nil;
} 
@end
