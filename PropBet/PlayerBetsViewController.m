//
//  PlayerBetsViewController.m
//  PropBet
//
//  Created by Kagan Riedel on 1/26/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "PlayerBetsViewController.h"
#import "PropBet.h"
#import "AppDelegate.h"

@interface PlayerBetsViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedResultsController;
}

@end

@implementation PlayerBetsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    managedObjectContext = ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"PropBet"];
    fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES]];
    
    fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    [fetchedResultsController performFetch:nil];


}



#pragma mark UITableViewDataSource & Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isGameOn == NO)
    {
        PropBet *propBet = fetchedResultsController.fetchedObjects[indexPath.row];
        if ([tableView cellForRowAtIndexPath:indexPath].imageView.image == nil)
        {
            [propBet addYaysObject:_player];
        }
        else if ([tableView cellForRowAtIndexPath:indexPath].imageView.image == [UIImage imageNamed:@"ThumbsUpButton.png"])
        {
            [propBet removeYaysObject:_player];
            [propBet addNaysObject:_player];
        }
        else if ([tableView cellForRowAtIndexPath:indexPath].imageView.image == [UIImage imageNamed:@"ThumbsDownButton.png"])
        {
            [propBet removeNaysObject:_player];
        }
        [managedObjectContext save:nil];
        [tableView reloadData];
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerBetsCell"];
    PropBet *propBet = fetchedResultsController.fetchedObjects[indexPath.row];
    cell.textLabel.text = propBet.title;
    cell.detailTextLabel.text = propBet.detail;
    
    if ([propBet.yays containsObject:_player])
    {
        cell.imageView.image = [UIImage imageNamed:@"ThumbsUpButton.png"];
    }
    else if ([propBet.nays containsObject:_player])
    {
        cell.imageView.image = [UIImage imageNamed:@"ThumbsDownButton.png"];
    }
    else
    {
        cell.imageView.image = nil;
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return fetchedResultsController.fetchedObjects.count;
}

@end
