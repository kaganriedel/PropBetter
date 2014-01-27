//
//  PropBetViewController.m
//  PropBet
//
//  Created by Kagan Riedel on 1/20/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "PropBetViewController.h"
#import "Player.h"

@interface PropBetViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>
{
    __weak IBOutlet UILabel *detailsLabel;
    __weak IBOutlet UITableView *playersTableView;
    __weak IBOutlet UIButton *winnerButton;
}

@end

@implementation PropBetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	detailsLabel.text = _propBet.detail;
    if (_propBet.hasBeenCalculated == YES)
    {
        winnerButton.userInteractionEnabled = NO;
    }
}

- (IBAction)onWinnerButtonPressed:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_propBet.title message:@"Who won?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Over", @"Under", nil];
    [alert show];
    winnerButton.userInteractionEnabled = NO;
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) //Cancel
    {
        winnerButton.userInteractionEnabled = YES;
    }
    
    else if (buttonIndex == 1) //Over
    {
        _propBet.hasBeenCalculated = YES;

        for (Player *player in _propBet.yays)
        {
            player.score++;
        }
        for (UITableViewCell *cell in playersTableView.visibleCells)
        {
            if (cell.imageView.image == [UIImage imageNamed:@"ThumbsUpButton.jpg"]) {
                cell.backgroundColor = [UIColor colorWithRed:0.0 green:0.65 blue:0.99 alpha:1.0];
            }
        }
    }
    
    else if (buttonIndex == 2) //Under
    {
        _propBet.hasBeenCalculated = YES;

        for (Player *player in _propBet.nays)
        {
            player.score++;
        }
        for (UITableViewCell *cell in playersTableView.visibleCells)
        {
            if (cell.imageView.image == [UIImage imageNamed:@"ThumbsDownButton.jpg"]) {
                cell.backgroundColor = [UIColor colorWithRed:0.0 green:0.65 blue:0.99 alpha:1.0];
            }
        }
    }
}


#pragma mark UITableViewDelegate & DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _playerArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerCell"];
    Player *player = [Player new];
    player = [_playerArray objectAtIndex:indexPath.row];
    cell.textLabel.text = player.name;
    
    if ([_propBet.yays containsObject:player])
    {
        cell.imageView.image = [UIImage imageNamed:@"ThumbsUpButton.jpg"];
    }
    else if ([_propBet.nays containsObject:player])
    {
        cell.imageView.image = [UIImage imageNamed:@"ThumbsDownButton.jpg"];
    }
    else
    {
        cell.imageView.image = nil;
    }
    
    return cell;
}



@end
