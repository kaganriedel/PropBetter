//
//  ViewController.m
//  PropBet
//
//  Created by Kagan Riedel on 1/18/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "MasterViewController.h"
#import "NewPropBetViewController.h"
#import "PlayerListViewController.h"
#import "PropBetViewController.h"
#import "Player.h"
#import "PropBet.h"
#import "AppDelegate.h"


@interface MasterViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, NSFetchedResultsControllerDelegate>
{
    __weak IBOutlet UITableView *propTableView;
    __weak IBOutlet UIButton *gameOnButton;
    __weak IBOutlet UIButton *goodLuckButton;
    __weak IBOutlet UIButton *newPropBetButton;
    
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedResultsController;
    
    NSUserDefaults *userDefaults;

}
@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    _isGameOn = [userDefaults boolForKey:@"isGameOn"];
    
    managedObjectContext = ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"PropBet"];
    fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES selector:@selector(caseInsensitiveCompare:)]];
    
    fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"cache"];
    fetchedResultsController.delegate = self;

    [fetchedResultsController performFetch:nil];
    
    if (fetchedResultsController.fetchedObjects.count == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Let The Games Begin" message:@"Add some PropBets with the + button" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
        
//        Player *player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:managedObjectContext];
//        player.name = @"Kagan Riedel";
//        
//        player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:managedObjectContext];
//        player.name = @"Aquaman";
//        
//        player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:managedObjectContext];
//        player.name = @"Tom Anderson";
//        
//        player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:managedObjectContext];
//        player.name = @"Billy Blanks";
//        
//        player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:managedObjectContext];
//        player.name = @"John Madden";
//        
//        player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:managedObjectContext];
//        player.name = @"Cher";
//        
//        player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:managedObjectContext];
//        player.name = @"Aaron Riedel";
//        
//        player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:managedObjectContext];
//        player.name = @"Charlotte 'Charlie' Riedel";
//        
//        PropBet *testProp = [NSEntityDescription insertNewObjectForEntityForName:@"PropBet" inManagedObjectContext:managedObjectContext];
//        testProp.title = @"Super Bowl Winner";
//        testProp.detail = @"Will the Vikings win the Super Bowl?";
//        
//        testProp = [NSEntityDescription insertNewObjectForEntityForName:@"PropBet" inManagedObjectContext:managedObjectContext];
//        testProp.title = @"Christian Ponder";
//        testProp.detail = @"Over/under 25 total passing yards";
//        
//        testProp = [NSEntityDescription insertNewObjectForEntityForName:@"PropBet" inManagedObjectContext:managedObjectContext];
//        testProp.title = @"Adrian Peterson TDs";
//        testProp.detail = @"Will AP score more than 8 TDs?";
//        
//        testProp = [NSEntityDescription insertNewObjectForEntityForName:@"PropBet" inManagedObjectContext:managedObjectContext];
//        testProp.title = @"Total Turnovers";
//        testProp.detail = @"3 or more total TOs?";
//        
//        testProp = [NSEntityDescription insertNewObjectForEntityForName:@"PropBet" inManagedObjectContext:managedObjectContext];
//        testProp.title = @"TDs in 2nd";
//        testProp.detail = @"2 or more TDs in the 2nd quarter?";
//        
//        testProp = [NSEntityDescription insertNewObjectForEntityForName:@"PropBet" inManagedObjectContext:managedObjectContext];
//        testProp.title = @"Wild card plays";
//        testProp.detail = @"Will there be a safety, blocked kick, onside kick, or TD on a TO?";
//        
//        testProp = [NSEntityDescription insertNewObjectForEntityForName:@"PropBet" inManagedObjectContext:managedObjectContext];
//        testProp.title = @"Coors light";
//        testProp.detail = @"7 or more coors light commercials?";
//        
//        testProp = [NSEntityDescription insertNewObjectForEntityForName:@"PropBet" inManagedObjectContext:managedObjectContext];
//        testProp.title = @"Groundhog";
//        testProp.detail = @"Will the groundhog see its shadow?";
//        
//        
//        testProp = [NSEntityDescription insertNewObjectForEntityForName:@"PropBet" inManagedObjectContext:managedObjectContext];
//        testProp.title = @"Wood chuck";
//        testProp.detail = @"If a wood chuck could chuck wood, would it chuck more than 6?";
//        
//        [managedObjectContext save:nil];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (_isGameOn)
    {
        [self gameOn];
    }
}

- (IBAction)gameOnPressed:(UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game On!" message:@"Ready to lock in all the players and bets?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Lock 'em in", nil];
    alert.tag = 0;
    [alert show];
}

- (IBAction)goodLuckPressed:(UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New Game?" message:@"Want to start a new game?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes Please", nil];
    alert.tag = 1;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 0)
    {
        if (buttonIndex == 1)
        {
            _isGameOn = YES;
            [userDefaults setBool:YES forKey:@"isGameOn"];
            [userDefaults synchronize];
            [self gameOn];
        }
    }
    else if (alertView.tag == 1)
    {
        if (buttonIndex == 1)
        {
            _isGameOn = NO;
            [userDefaults setBool:NO forKey:@"isGameOn"];
            [userDefaults synchronize];
            [self newGame];
        }
    }
}

-(void)gameOn
{
    gameOnButton.alpha = 0.0;
    goodLuckButton.alpha = 1.0;
    newPropBetButton.alpha = 0.0;
}

-(void)newGame
{
    gameOnButton.alpha = 1.0;
    goodLuckButton.alpha = 0.0;
    newPropBetButton.alpha = 1.0;
    
//    [fetchedResultsController performFetch:nil];
//    NSArray *objects = fetchedResultsController.fetchedObjects;
//    for (PropBet *propBet in objects)
//    {
//        [managedObjectContext deleteObject:propBet];
//    }
//    
//    [managedObjectContext save:nil];
//    
//    NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc] initWithEntityName:@"Player"];
//    fetchRequest2.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)]];
//    
//    NSFetchedResultsController *fetchedResultsController2 = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest2 managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
//    fetchedResultsController.delegate = self;
//    
//    
//    [fetchedResultsController2 performFetch:nil];
//    objects = fetchedResultsController2.fetchedObjects;
//    for (Player *player in objects)
//    {
//        [managedObjectContext deleteObject:player];
//    }
//    
//    [managedObjectContext save:nil];

    
    
    

//    NSURL * storeURL = [[managedObjectContext persistentStoreCoordinator] URLForPersistentStore:[[[managedObjectContext persistentStoreCoordinator] persistentStores] lastObject]];
//
//    [managedObjectContext lock];
//    [managedObjectContext reset];
//    
//    if ([[managedObjectContext persistentStoreCoordinator] removePersistentStore:[[[managedObjectContext persistentStoreCoordinator] persistentStores] lastObject] error:nil])
//    {
//        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
//
//        [[managedObjectContext persistentStoreCoordinator] addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:nil];
//    }
//    [managedObjectContext unlock];
//    [fetchedResultsController fetchRequest];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"NewPropSegue"])
    {
        //
    }
    else if ([segue.identifier isEqualToString:@"PlayersSegue"])
    {
        PlayerListViewController *vc = segue.destinationViewController;
        vc.isGameOn = _isGameOn;
    }
    else if ([segue.identifier isEqualToString:@"PropBetSegue"])
    {
        PropBetViewController *vc = segue.destinationViewController;
        NSIndexPath *indexPath = [propTableView indexPathForSelectedRow];
        PropBet *propBet = fetchedResultsController.fetchedObjects[indexPath.row];
        vc.propBet = propBet;
        vc.navigationItem.title = vc.propBet.title;
        vc.isGameOn = _isGameOn;
    }
}

#pragma mark NSFetchedResultsControllerDelegate

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    [fetchedResultsController performFetch:nil];
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [propTableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [propTableView reloadRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [propTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            //Note: This line uses indexPath, not newIndexPath
            break;
        default:
            break;
    }
}

#pragma mark UITableViewDelegate & DataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PropCellID"];
    PropBet *propBet = fetchedResultsController.fetchedObjects[indexPath.row];
    cell.textLabel.text = propBet.title;
    cell.detailTextLabel.text = propBet.detail;
    
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
            PropBet *propBet = fetchedResultsController.fetchedObjects[indexPath.row];
            [managedObjectContext deleteObject:propBet];
            [managedObjectContext save:nil];
        }
    }
}




@end
