//
//  PlayerBetsViewController.m
//  PropBet
//
//  Created by Kagan Riedel on 1/26/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "PlayerBetsViewController.h"
#import "PropBet.h"

@interface PlayerBetsViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation PlayerBetsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
}



#pragma mark UITableViewDataSource & Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView cellForRowAtIndexPath:indexPath].imageView.image == nil)
    {
        PropBet *propBet = _propBetsArray[indexPath.row];
        [propBet.yays addObject:_player];
    }
    else if ([tableView cellForRowAtIndexPath:indexPath].imageView.image == [UIImage imageNamed:@"ThumbsUpButton.jpg"])
    {
        PropBet *propBet = _propBetsArray[indexPath.row];
        [propBet.yays removeObject:_player];
        [propBet.nays addObject:_player];
    }
    else if ([tableView cellForRowAtIndexPath:indexPath].imageView.image == [UIImage imageNamed:@"ThumbsDownButton.jpg"])
    {
        PropBet *propBet = _propBetsArray[indexPath.row];
        [propBet.nays removeObject:_player];
    }
    [tableView reloadData];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerBetsCell"];
    PropBet *propBet = _propBetsArray[indexPath.row];
    cell.textLabel.text = propBet.title;
    cell.detailTextLabel.text = propBet.detail;
    
    if ([propBet.yays containsObject:_player])
    {
        cell.imageView.image = [UIImage imageNamed:@"ThumbsUpButton.jpg"];
    } else if ([propBet.nays containsObject:_player])
    {
        cell.imageView.image = [UIImage imageNamed:@"ThumbsDownButton.jpg"];
    } else
    {
        cell.imageView.image = nil;
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _propBetsArray.count;
}

@end
