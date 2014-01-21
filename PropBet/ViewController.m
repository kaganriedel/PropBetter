//
//  ViewController.m
//  PropBet
//
//  Created by Kagan Riedel on 1/18/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "ViewController.h"
#import "NewPropBetViewController.h"
#import "PlayerListViewController.h"
#import "PropBetViewController.h"
#import "Player.h"
#import "PropBet.h"


@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView *propTableView;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _playersArray = [NSMutableArray new];
    
    Player *player = [Player new];
    player.name = @"Kagan Riedel";
    [_playersArray addObject:player];
    
    player = [Player new];
    player.name = @"Josef Hilbert";
    [_playersArray addObject:player];
    
    PropBet *testProp = [PropBet new];
    testProp.title = @"Super Bowl Winner";
    testProp.detail = @"The Vikings or the Browns?";
    _propBetsArray = [NSMutableArray arrayWithObject:testProp];
    
    testProp = [PropBet new];
    testProp.title = @"Total rushing yards";
    testProp.detail = @"Over/under 175 yards";
    [_propBetsArray addObject:testProp];
    
    testProp = [PropBet new];
    testProp.title = @"Adrian Peterson TDs";
    testProp.detail = @"Will AP score 8 TDs?";
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
    if ([segue.identifier isEqualToString:@"NewPropSegue"])
    {
        NewPropBetViewController *vc = segue.destinationViewController;
        vc.propBetArray = self.propBetsArray;
    } else if ([segue.identifier isEqualToString:@"NewPlayerSegue"])
    {
        PlayerListViewController *vc = segue.destinationViewController;
        vc.playersArray = self.playersArray;
    } else if ([segue.identifier isEqualToString:@"PropBetSegue"])
    {
        PropBetViewController *vc = segue.destinationViewController;
        vc.playerArray = self.playersArray;
    }
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
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [_propBetsArray removeObjectAtIndex:indexPath.row];
        [propTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}




@end
