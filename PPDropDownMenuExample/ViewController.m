//
//  ViewController.m
//  PPDropDownMenu
//
//  Created by Zhipeng on 14/3/2016.
//  Copyright © 2016 Zhipeng. All rights reserved.
//

#import "ViewController.h"
#import "PPDropdownMenuCenter.h"

@interface ViewController ()< UITableViewDelegate, UITableViewDelegate, DropdownButtonDelegate>
@property (strong, nonatomic)NSMutableArray* dropdownIndexShowList;
@property (strong, nonatomic)ContentTable* contentTableDelegate;
//@property (strong, nonatomic)PPDropdownMenuCenter* dropdownMenuCenter;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dropdownIndexShowList = [NSMutableArray array];
    for (int i = 0; i< 10; i ++){
        [self.dropdownIndexShowList addObject: [NSString stringWithFormat:@"%d",i ]];
    }
    
    [[PPDropdownMenuCenter SharedPPDropdownMenuCenter] setUpWithMainViewController:self DropdownButtonFrame:CGRectMake (0, 30, self.view.frame.size.width, 30) ContentTableView:CGRectMake(0, 60, self.view.frame.size.width, 178) andContentTableNameList:@[@"click1", @"click2", @"click3", @"click4", @"click5"]];
    [[PPDropdownMenuCenter SharedPPDropdownMenuCenter] setDropdownButtonTitle:@"Filter"];
}

- (void)dropdownButtonDidClick:(UIButton *)button{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dropdownContentTableDidselectAtIndex:(NSIndexPath *)index andDataSource:(NSArray *)dataSource{
    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:index];
    cell.backgroundColor = [UIColor redColor];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [self.dropdownIndexShowList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [self.dropdownIndexShowList objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - drop down button delegate
- (void)dropdownContentTableDidSelected:(NSIndexPath *)indexPath{
    for(NSIndexPath*index in self.tableView.indexPathsForVisibleRows){
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:index];
        cell.backgroundColor = [UIColor whiteColor];
    
    }
    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
}

@end
