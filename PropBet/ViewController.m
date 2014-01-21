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
    player.name = @"Aquaman";
    [_playersArray addObject:player];
    
    player = [Player new];
    player.name = @"Tom Anderson";
    [_playersArray addObject:player];
    
    player = [Player new];
    player.name = @"Billy Blanks";
    [_playersArray addObject:player];
    
    player = [Player new];
    player.name = @"John Madden";
    [_playersArray addObject:player];
    
    player = [Player new];
    player.name = @"Cher";
    [_playersArray addObject:player];
    
    player = [Player new];
    player.name = @"Aaron Riedel";
    [_playersArray addObject:player];
    
    player = [Player new];
    player.name = @"Charlotte 'Charlie' Riedel";
    [_playersArray addObject:player];
    
    PropBet *testProp = [PropBet new];
    testProp.title = @"Super Bowl Winner";
    testProp.detail = @"Will the Vikings win the Super Bowl?";
    _propBetsArray = [NSMutableArray arrayWithObject:testProp];
    
    testProp = [PropBet new];
    testProp.title = @"Christian Ponder pass yards";
    testProp.detail = @"Over/under 25 total passing yards";
    [_propBetsArray addObject:testProp];
    
    testProp = [PropBet new];
    testProp.title = @"Adrian Peterson TDs";
    testProp.detail = @"Will AP score more than 8 TDs?";
    [_propBetsArray addObject:testProp];
    
    testProp = [PropBet new];
    testProp.title = @"Total Turnovers";
    testProp.detail = @"3 or more total TOs?";
    [_propBetsArray addObject:testProp];
    
    testProp = [PropBet new];
    testProp.title = @"TDs in the 2nd quarter";
    testProp.detail = @"2 or more TDs in the 2nd quarter?";
    [_propBetsArray addObject:testProp];
    
    testProp = [PropBet new];
    testProp.title = @"Wild card plays";
    testProp.detail = @"Will there be a safety, blocked kick, onside kick, or TD on a TO?";
    [_propBetsArray addObject:testProp];
    
    testProp = [PropBet new];
    testProp.title = @"How many Coors Light commercials will be played?";
    testProp.detail = @"7 or more?";
    [_propBetsArray addObject:testProp];
    
    testProp = [PropBet new];
    testProp.title = @"Groundhog";
    testProp.detail = @"Will the groundhog see its shadow?";
    [_propBetsArray addObject:testProp];
    
    testProp = [PropBet new];
    testProp.title = @"Wood chuck";
    testProp.detail = @"If a wood chuck could chuck wood, would it chuck more than 6?";
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
        NSIndexPath *indexPath = [propTableView indexPathForSelectedRow];
        vc.propBet = [_propBetsArray objectAtIndex:indexPath.row];
        vc.navigationItem.title = vc.propBet.title;
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
