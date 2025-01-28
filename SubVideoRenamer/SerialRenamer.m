//
//  SerialRenamer.m
//  SubVideoRenamer
//
//  Created by Jarvis on 1/28/25.
//  Copyright © 2025 AMS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SerialRenamer : NSObject

@property (nonatomic, strong) NSMutableArray<NSString *> *originalFileNames;
@property (nonatomic, strong) NSMutableArray<NSString *> *renamedFiles;

@property (nonatomic, strong) NSString *beforeName;
@property (nonatomic, strong) NSString *afterName;
@property (nonatomic, assign) NSInteger startNumber;
@property (nonatomic, strong) NSString *folderPath;

- (instancetype)initWithBeforeName:(NSString *)beforeName
                         afterName:(NSString *)afterName
                       startNumber:(NSInteger)startNumber
                        folderPath:(NSString *)folderPath;

- (NSArray<NSString *> *)startRename:(NSArray<NSString *> *)files;
- (void)redoRenameWithOriginalList:(NSArray<NSString *> *)originalList renamedList:(NSArray<NSString *> *)renamedList;

@end

@implementation SerialRenamer

- (instancetype)initWithBeforeName:(NSString *)beforeName
                         afterName:(NSString *)afterName
                       startNumber:(NSInteger)startNumber
                        folderPath:(NSString *)folderPath {
    self = [super init];
    if (self) {
        self.beforeName = beforeName;
        self.afterName = afterName;
        self.startNumber = startNumber;
        self.folderPath = folderPath;
        self.originalFileNames = [NSMutableArray array];
        self.renamedFiles = [NSMutableArray array];
    }
    return self;
}

- (NSArray<NSString *> *)startRename:(NSArray<NSString *> *)files {
    [self.originalFileNames removeAllObjects];
    [self.renamedFiles removeAllObjects];
    
    NSInteger currentNumber = self.startNumber;
    
    for (NSString *file in files) {
        [self.originalFileNames addObject:file];
        NSString *extension = [file pathExtension];
        NSString *newName = [NSString stringWithFormat:@"%@%02ld %@.%@", self.beforeName, (long)currentNumber, self.afterName, extension];
        NSString *newPath = [self.folderPath stringByAppendingPathComponent:newName];
        NSString *oldPath = [self.folderPath stringByAppendingPathComponent:file];
        
        [[NSFileManager defaultManager] moveItemAtPath:oldPath toPath:newPath error:nil];
        
        [self.renamedFiles addObject:newName];
        currentNumber++;
    }
    
    return [self.renamedFiles copy];
}

- (void)redoRenameWithOriginalList:(NSArray<NSString *> *)originalList renamedList:(NSArray<NSString *> *)renamedList {
    for (NSUInteger i = 0; i < renamedList.count; i++) {
        NSString *oldPath = [self.folderPath stringByAppendingPathComponent:renamedList[i]];
        NSString *newPath = [self.folderPath stringByAppendingPathComponent:originalList[i]];
        
        [[NSFileManager defaultManager] moveItemAtPath:oldPath toPath:newPath error:nil];
    }
}

@end
