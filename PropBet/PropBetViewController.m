//
//  PropBetViewController.m
//  PropBet
//
//  Created by Kagan Riedel on 1/20/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "PropBetViewController.h"
#import "Player.h"
#import "AppDelegate.h"

@interface PropBetViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>
{
    __weak IBOutlet UILabel *detailsLabel;
    __weak IBOutlet UITableView *playersTableView;
    __weak IBOutlet UIButton *winnerButton;
    
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedResultsController;
}

@end

@implementation PropBetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    managedObjectContext = ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;

	detailsLabel.text = _propBet.detail;
    
    managedObjectContext = ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Player"];
    fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES]];
    
    fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"playercache"];
    
    [fetchedResultsController performFetch:nil];

    if (_propBet.hasBeenCalculated.boolValue == YES)
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
        _propBet.hasBeenCalculated = @YES;

        for (Player *player in _propBet.yays)
        {
            player.score = [NSNumber numberWithInt: player.score.intValue + 1];
        }
        for (UITableViewCell *cell in playersTableView.visibleCells)
        {
            if (cell.imageView.image == [UIImage imageNamed:@"ThumbsUpButton.png"]) {
                cell.backgroundColor = [UIColor colorWithRed:0.0 green:0.65 blue:0.99 alpha:1.0];
            }
        }
    }
    
    else if (buttonIndex == 2) //Under
    {
        _propBet.hasBeenCalculated = @YES;

        for (Player *player in _propBet.nays)
        {
            player.score = [NSNumber numberWithInt: player.score.intValue + 1];
        }
        for (UITableViewCell *cell in playersTableView.visibleCells)
        {
            if (cell.imageView.image == [UIImage imageNamed:@"ThumbsDownButton.png"]) {
                cell.backgroundColor = [UIColor colorWithRed:0.0 green:0.65 blue:0.90 alpha:1.0];
            }
        }
    }
}


#pragma mark UITableViewDelegate & DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return fetchedResultsController.fetchedObjects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerCell"];
    Player *player = [fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = player.name;
    
    if ([_propBet.yays containsObject:player])
    {
        cell.imageView.image = [UIImage imageNamed:@"ThumbsUpButton.png"];
    }
    else if ([_propBet.nays containsObject:player])
    {
        cell.imageView.image = [UIImage imageNamed:@"ThumbsDownButton.png"];
    }
    else
    {
        cell.imageView.image = nil;
    }
    
    return cell;
}



@end
