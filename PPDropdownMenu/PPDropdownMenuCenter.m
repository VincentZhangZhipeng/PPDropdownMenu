//
//  PPDropdownMenuCenter.m
//  PPDropDownMenu
//
//  Created by Zhipeng on 15/3/2016.
//  Copyright © 2016 Zhipeng. All rights reserved.
//

#import "PPDropdownMenuCenter.h"

@implementation PPDropdownMenuCenter
@synthesize dropdownButton, contentTable, contentTableDelegate, blockView,showContentTableView, contentFrame;

+(id)SharedPPDropdownMenuCenter{
    static PPDropdownMenuCenter *SharedPPDropdownMenuCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SharedPPDropdownMenuCenter = [[self alloc] init];
    });
    return SharedPPDropdownMenuCenter;
}

-(void)setUpWithDropdownButtonFrame:(CGRect)buttonFrame ContentTableView:(CGRect)contentTableFrame{
    dropdownButton = [[PPDropdownButton alloc] initWithFrame:buttonFrame];
    contentTable = [[DropdownContentTable alloc] initWithFrame:contentTableFrame];
    contentFrame = contentTableFrame;
   
    [dropdownButton addTarget:self
             action:@selector(dropdownButtonClicked) forControlEvents:UIControlEventTouchUpInside];


}

- (void)setUpWithMainViewController:(UIViewController*) mainViewController DropdownButtonFrame:(CGRect)buttonFrame ContentTableView:(CGRect)contentTableFrame andContentTableNameList: (NSArray*)contentTableNameList{
    
    [self setUpWithDropdownButtonFrame:buttonFrame ContentTableView:contentTableFrame];
    
    contentTableDelegate = [[ContentTable alloc] init];
    contentTableDelegate.delegate = self;
    contentTableDelegate.dropdownContentList = contentTableNameList;
    NSMutableArray* selectedList = [NSMutableArray array];
    for(NSInteger i = 0; i< [contentTableNameList count]; i++){
        [selectedList addObject:[NSNumber numberWithBool:NO]];
    
    }
    [selectedList replaceObjectAtIndex:0 withObject:[NSNumber numberWithBool:YES]];
    
    contentTableDelegate.cellSelectedList = selectedList;
    
    [contentTable setDelegate:contentTableDelegate];
    [contentTable setDataSource:contentTableDelegate];
    contentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    dropdownButton.backgroundColor = [UIColor orangeColor];
    _dropDownButtonDelegate = mainViewController;
    [mainViewController.view addSubview:dropdownButton];
    [mainViewController.view addSubview:contentTable];
    [mainViewController.view bringSubviewToFront:contentTable];
    
    CGFloat blockViewY = contentTable.frame.origin.y + contentTable.frame.size.height;
    blockView = [[UIView alloc] initWithFrame: CGRectMake(0, blockViewY, mainViewController.view.frame.size.width, mainViewController.view.frame.size.height - blockViewY)];
    blockView.hidden = YES;
    blockView.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideBlockView)];
    
    [blockView addGestureRecognizer:singleFingerTap];
    [mainViewController.view addSubview:blockView];
    [mainViewController.view bringSubviewToFront:blockView];
    
    contentTable.frame = CGRectMake(contentTable.frame.origin.x, contentTable.frame.origin.y, contentTable.frame.size.width, 0);
    
    
}

- (void)setDropdownButtonTitle:(NSString*)title{
    [dropdownButton setTitle:title forState:UIControlStateNormal];
}

- (void)dropdownButtonClicked{
    showContentTableView = !showContentTableView;
    dropdownButton.selected = showContentTableView;
    if (showContentTableView) {
        [self showAnimation];
        [contentTable reloadData];
        
    }else{
        [self hideAnimation];
    
        
    }
    
    [_dropDownButtonDelegate dropdownButtonDidClick:dropdownButton];
    blockView.hidden = NO;
    
}
- (void)contentTabledidSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    blockView.hidden = YES;
    showContentTableView = NO;
    dropdownButton.selected = NO;
    [self hideAnimation];
    [_dropDownButtonDelegate dropdownContentTableDidSelected:indexPath];
    
}

- (void)hideBlockView{
    blockView.hidden = YES;
    showContentTableView = NO;
    dropdownButton.selected = NO;
    [self hideAnimation];
}

- (void)hideAnimation{
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^(void) {
                         contentTable.frame = CGRectMake(contentTable.frame.origin.x, contentTable.frame.origin.y, contentTable.frame.size.width, 0);

                     }
                     completion:NULL];

}

- (void)showAnimation{
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCurlDown
                     animations:^(void) {
                         contentTable.frame = contentFrame;
                     }
                     completion:NULL];

}


@end
