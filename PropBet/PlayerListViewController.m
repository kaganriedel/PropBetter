//
//  PlayerListViewController.m
//  PropBet
//
//  Created by Kagan Riedel on 1/20/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "PlayerListViewController.h"
#import "PlayerBetsViewController.h"
#import "Player.h"

@interface PlayerListViewController () <UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITextField *playerTextField;
    __weak IBOutlet UITableView *playerTableView;
    
}

@end

@implementation PlayerListViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)onAddPlayerButtonPressed:(id)sender
{
    if (_isGameOn == YES)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nope" message:@"The games have already begun!" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        [alert show];
        playerTextField.text = @"";
        [playerTextField resignFirstResponder];
    }
    else
    {
        NSString *trimmedString = [playerTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([trimmedString isEqualToString:@""] == NO)
        {
            Player *player = [Player new];
            player.name = trimmedString;
            [_playersArray addObject:player];
            [playerTableView reloadData];
            playerTextField.text = @"";
            [playerTextField resignFirstResponder];
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PlayerBetsViewController *vc = segue.destinationViewController;
    vc.propBetsArray = _propBetsArray;
    
    NSIndexPath *indexPath = [playerTableView indexPathForSelectedRow];
    vc.player = _playersArray[indexPath.row];
    UITableViewCell *cell = [playerTableView cellForRowAtIndexPath:indexPath];
    vc.navigationItem.title = cell.textLabel.text;
    vc.isGameOn = _isGameOn;
}

#pragma mark UITableViewDelegate & DataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerCell"];
    Player *player = [_playersArray objectAtIndex:indexPath.row];
    cell.textLabel.text = player.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Score: %i", player.score];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _playersArray.count;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isGameOn == NO)
    {
        if (editingStyle == UITableViewCellEditingStyleDelete)
        {
            [_playersArray removeObjectAtIndex:indexPath.row];
            [playerTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}


@end
