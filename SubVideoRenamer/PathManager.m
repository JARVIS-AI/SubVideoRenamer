//
//  PathManager.m
//  SubVideoRenamer
//
//  Created by Jarvis on 1/28/25.
//  Copyright © 2025 AMS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PathManager.h"

@implementation PathManager

+ (BOOL)openPath:(NSString *)path {
    BOOL isDir;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir] && isDir) {
        [[NSWorkspace sharedWorkspace] openFile:path];
        return YES;
    }
    return NO;
}

+ (BOOL)isValidDirectory:(NSString *)path {
    BOOL isDir;
    return [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir] && isDir;
}

+ (void)showAlertWithMessage:(NSString *)message info:(NSString *)info style:(NSAlertStyle)style {
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = message;
    alert.informativeText = info;
    [alert addButtonWithTitle:@"OK"];
    [alert setAlertStyle:style];
    [alert runModal];
}

@end
