//
//  ExtendNSLogFunctionality.h
//  VjLive
//
//  Created by Alessandro Belli on 26/09/13.
//  Copyright (c) 2013 Alessandro Belli. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifdef DEBUG
#define NSLog(args...) ExtendNSLog(__FILE__,__LINE__,__PRETTY_FUNCTION__,args);
#else
#define NSLog(x...)
#endif
void ExtendNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...);
@interface ExtendNSLogFunctionality : NSObject

@end
