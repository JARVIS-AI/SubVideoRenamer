//
//  PathManager.h
//  SubVideoRenamer
//
//  Created by Jarvis on 1/28/25.
//  Copyright © 2025 AMS. All rights reserved.
//

#ifndef PathManager_h
#define PathManager_h

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface PathManager : NSObject

+ (BOOL)openPath:(NSString *)path;
+ (BOOL)isValidDirectory:(NSString *)path;
+ (void)showAlertWithMessage:(NSString *)message info:(NSString *)info style:(NSAlertStyle)style;

@end


#endif /* PathManager_h */
