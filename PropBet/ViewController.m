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


@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    __weak IBOutlet UITableView *propTableView;
    __weak IBOutlet UIButton *gameOnButton;
    __weak IBOutlet UILabel *goodLuckLabel;
    __weak IBOutlet UIButton *newPropBetButton;
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
    testProp.yays = [NSMutableArray new];
    testProp.nays = [NSMutableArray new];
    _propBetsArray = [NSMutableArray arrayWithObject:testProp];
    
    testProp = [PropBet new];
    testProp.title = @"Christian Ponder";
    testProp.detail = @"Over/under 25 total passing yards";
    testProp.yays = [NSMutableArray new];
    testProp.nays = [NSMutableArray new];
    [_propBetsArray addObject:testProp];
    
    testProp = [PropBet new];
    testProp.title = @"Adrian Peterson TDs";
    testProp.detail = @"Will AP score more than 8 TDs?";
    testProp.yays = [NSMutableArray new];
    testProp.nays = [NSMutableArray new];
    [_propBetsArray addObject:testProp];
    
    testProp = [PropBet new];
    testProp.title = @"Total Turnovers";
    testProp.detail = @"3 or more total TOs?";
    testProp.yays = [NSMutableArray new];
    testProp.nays = [NSMutableArray new];
    [_propBetsArray addObject:testProp];
    
    testProp = [PropBet new];
    testProp.title = @"TDs in 2nd";
    testProp.detail = @"2 or more TDs in the 2nd quarter?";
    testProp.yays = [NSMutableArray new];
    testProp.nays = [NSMutableArray new];
    [_propBetsArray addObject:testProp];
    
    testProp = [PropBet new];
    testProp.title = @"Wild card plays";
    testProp.detail = @"Will there be a safety, blocked kick, onside kick, or TD on a TO?";
    testProp.yays = [NSMutableArray new];
    testProp.nays = [NSMutableArray new];
    [_propBetsArray addObject:testProp];
    
    testProp = [PropBet new];
    testProp.title = @"Coors light";
    testProp.detail = @"7 or more coors light commercials?";
    testProp.yays = [NSMutableArray new];
    testProp.nays = [NSMutableArray new];
    [_propBetsArray addObject:testProp];
    
    testProp = [PropBet new];
    testProp.title = @"Groundhog";
    testProp.detail = @"Will the groundhog see its shadow?";
    testProp.yays = [NSMutableArray new];
    testProp.nays = [NSMutableArray new];
    [_propBetsArray addObject:testProp];
    
    testProp = [PropBet new];
    testProp.title = @"Wood chuck";
    testProp.detail = @"If a wood chuck could chuck wood, would it chuck more than 6?";
    testProp.yays = [NSMutableArray new];
    testProp.nays = [NSMutableArray new];
    [_propBetsArray addObject:testProp];
    

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [propTableView reloadData];
    if (_isGameOn)
    {
        newPropBetButton.alpha = 0.0;
    }
}

//-(void) save
//{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setObject:_playersArray forKey:@"playersArray"];
//    [userDefaults setObject:_propBetsArray forKey:@"propBetsArray"];
//    [userDefaults setBool:_isGameOn forKey:@"isGameOn"];
//
//    [userDefaults synchronize];
//}
//
//-(void) load
//{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    _playersArray = [userDefaults objectForKey:@"playersArray"] ?: [NSMutableArray new];
//    _propBetsArray = [userDefaults objectForKey:@"propBetsArray"] ?: [NSMutableArray new];
//    _isGameOn = [userDefaults boolForKey:@"isGameOn"];
//}



- (IBAction)gameOnPressed:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game On!" message:@"Ready to lock in all the players and bets?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Lock 'em in", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        _isGameOn = YES;
        gameOnButton.alpha = 0.0;
        goodLuckLabel.alpha = 1.0;
        newPropBetButton.alpha = 0.0;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"NewPropSegue"])
    {
        NewPropBetViewController *vc = segue.destinationViewController;
        vc.propBetArray = self.propBetsArray;
    } else if ([segue.identifier isEqualToString:@"PlayersSegue"])
    {
        PlayerListViewController *vc = segue.destinationViewController;
        vc.playersArray = self.playersArray;
        vc.propBetsArray = self.propBetsArray;
        vc.isGameOn = _isGameOn;
    } else if ([segue.identifier isEqualToString:@"PropBetSegue"])
    {
        PropBetViewController *vc = segue.destinationViewController;
        vc.playerArray = self.playersArray;
        NSIndexPath *indexPath = [propTableView indexPathForSelectedRow];
        vc.propBet = [_propBetsArray objectAtIndex:indexPath.row];
        vc.navigationItem.title = vc.propBet.title;
        vc.isGameOn = _isGameOn;
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
    if (_isGameOn == NO)
    {
        if (editingStyle == UITableViewCellEditingStyleDelete)
        {
            [_propBetsArray removeObjectAtIndex:indexPath.row];
            [propTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}




@end
