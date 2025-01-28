#import <Foundation/Foundation.h>

// FileListViewController.m
#import "FileListViewController.h"

@interface FileListViewController () <NSTableViewDataSource, NSTableViewDelegate>

@end

@implementation FileListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"fileList: %@", self.fileList);

    
    // Check if fileList is populated, then reload the table view
    if (self.fileList) {
        [self.tableView reloadData];
    }
}

// Assuming you have a method to get the number of rows in the table
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.fileList.count;
}

// Assuming you have a method to display file names in the table
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    return self.fileList[row];
}

@end
