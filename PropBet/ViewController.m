//
//  ViewController.m
//  PropBet
//
//  Created by Kagan Riedel on 1/18/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "ViewController.h"
#import "NewPropBetViewController.h"
#import "Player.h"
#import "PropBet.h"


@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    __weak IBOutlet UITableView *propTableView;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PropBet *testProp = [PropBet new];
    testProp.title = @"Super Bowl Winner";
    testProp.detail = @"The Vikings or the Browns?";
    _propBetsArray = [NSMutableArray arrayWithObject:testProp];
    
    testProp = [PropBet new];
    testProp.title = @"Total rushing yards";
    testProp.detail = @"Over/under 175 yards";
    [_propBetsArray addObject:testProp];
    
    testProp = [PropBet new];
    testProp.title = @"Adrian Peterson TD";
    testProp.detail = @"Will AP score a TD?";
    [_propBetsArray addObject:testProp];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [propTableView reloadData];
    NSLog(@"%i",_propBetsArray.count);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NewPropBetViewController *vc = segue.destinationViewController;
    vc.propBetArray = self.propBetsArray;
}







#pragma mark UITableViewDelegate & DataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PropCellID"];
    PropBet *propBet = [PropBet new];
    propBet = [_propBetsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = propBet.title;
    cell.detailTextLabel.text = propBet.detail;
    
    return cell;
                             
                             
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _propBetsArray.count;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete" message:@"Are you sure?" delegate:self cancelButtonTitle:@"Oops, no thanks" otherButtonTitles:@"Delete", nil];
        [alert show];
    }
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:alertView.tag inSection:0];
        [_propBetsArray removeObjectAtIndex:indexPath.row];
        [propTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


@end
