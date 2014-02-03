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
#import "AppDelegate.h"

@interface PlayerListViewController () <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>
{
    __weak IBOutlet UITextField *playerTextField;
    __weak IBOutlet UITableView *playerTableView;
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedResultsController;
}

@end

@implementation PlayerListViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    managedObjectContext = ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Player"];
    fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)]];
    
    fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"playercache"];
    fetchedResultsController.delegate = self;
    [fetchedResultsController performFetch:nil];

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
            Player *player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:managedObjectContext];
            player.name = trimmedString;
            [managedObjectContext save:nil];
            
            playerTextField.text = @"";
            [playerTextField resignFirstResponder];
        }
    }
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    [fetchedResultsController performFetch:nil];
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [playerTableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [playerTableView reloadRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [playerTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            //Note: This line uses indexPath, not newIndexPath
            break;
        default:
            break;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PlayerBetsViewController *vc = segue.destinationViewController;
    
    NSIndexPath *indexPath = [playerTableView indexPathForSelectedRow];
    vc.player = fetchedResultsController.fetchedObjects[indexPath.row];
    vc.navigationItem.title = vc.player.name;
    vc.isGameOn = _isGameOn;
}

#pragma mark UITableViewDelegate & DataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerCell"];
    Player *player = fetchedResultsController.fetchedObjects[indexPath.row];
    cell.textLabel.text = player.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Score: %i", player.score.intValue];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return fetchedResultsController.fetchedObjects.count;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isGameOn == NO)
    {
        if (editingStyle == UITableViewCellEditingStyleDelete)
        {
            Player *player = fetchedResultsController.fetchedObjects[indexPath.row];
            [managedObjectContext deleteObject:player];
            [managedObjectContext save:nil];
        }
    }
}


@end
