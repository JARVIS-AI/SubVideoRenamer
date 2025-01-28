//
//  FileListViewController.h
//  SubVideoRenamer
//
//  Created by Jarvis on 1/28/25.
//  Copyright © 2025 AMS. All rights reserved.
//

#ifndef FileListViewController_h
#define FileListViewController_h


// FileListViewController.h
#import <Cocoa/Cocoa.h>

@interface FileListViewController : NSViewController

@property (nonatomic, strong) NSArray<NSString *> *fileList; // Array to hold the file names
@property (weak) IBOutlet NSTableView *tableView; // Outlet for the table view

@end


#endif /* FileListViewController */
