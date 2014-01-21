//
//  PropBetViewController.m
//  PropBet
//
//  Created by Kagan Riedel on 1/20/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "PropBetViewController.h"
#import "Player.h"

@interface PropBetViewController () <UITableViewDelegate, UITableViewDataSource>
{
    __weak IBOutlet UILabel *detailsLabel;
    __weak IBOutlet UITableView *playersTableView;
    
}

@end

@implementation PropBetViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	detailsLabel.text = _propBet.detail;
    _propBet.yays = [NSMutableArray new];
    _propBet.nays = [NSMutableArray new];
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
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView cellForRowAtIndexPath:indexPath].imageView.image == nil)
    {
        [tableView cellForRowAtIndexPath:indexPath].imageView.image = [UIImage imageNamed:@"ThumbsUpButton.jpg"];
        [_propBet.yays addObject:[_playerArray objectAtIndex:indexPath.row]];
    }
    else if ([tableView cellForRowAtIndexPath:indexPath].imageView.image == [UIImage imageNamed:@"ThumbsUpButton.jpg"])
    {
        [tableView cellForRowAtIndexPath:indexPath].imageView.image = [UIImage imageNamed:@"ThumbsDownButton.jpg"];
        [_propBet.yays removeObject:[_playerArray objectAtIndex:indexPath.row]];
        [_propBet.nays addObject:[_playerArray objectAtIndex:indexPath.row]];

    }
    else if ([tableView cellForRowAtIndexPath:indexPath].imageView.image == [UIImage imageNamed:@"ThumbsDownButton.jpg"])
    {
        [tableView cellForRowAtIndexPath:indexPath].imageView.image = nil;
        [_propBet.nays removeObject:[_playerArray objectAtIndex:indexPath.row]];
    }
    [tableView reloadData];
}

@end
