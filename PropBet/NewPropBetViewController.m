//
//  NewPropBetViewController.m
//  PropBet
//
//  Created by Kagan Riedel on 1/18/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "NewPropBetViewController.h"

@interface NewPropBetViewController () <UITextFieldDelegate, UIAlertViewDelegate>
{
    __weak IBOutlet UITextField *propTextField;
    __weak IBOutlet UITextField *detailTextField;
    PropBet *propBet;
}

@end

@implementation NewPropBetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)onSaveButtonPressed:(id)sender
{
    NSString *propTrimmedString = [propTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *detailTrimmedString = [detailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([propTrimmedString isEqualToString:@""] == NO && [detailTrimmedString isEqualToString:@""] == NO)
    {
        propTextField.text = propTrimmedString;
        detailTextField.text = detailTrimmedString;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Looks good" message:@"Should I save it?" delegate:self cancelButtonTitle:@"Hold up a sec" otherButtonTitles:@"Yup", nil];
        [alert show];
    }
    else if ([propTrimmedString isEqualToString:@""] == YES) //if the propTestField is empty, alert the user
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Give it a name!" message:@"What's the bet name?" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if ([detailTrimmedString isEqualToString:@""] == YES)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tell me more!" message:@"What are the details?" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        propBet = [PropBet new];
        propBet.title = propTextField.text;
        propBet.detail = detailTextField.text;
        propBet.yays = [NSMutableArray new];
        propBet.nays = [NSMutableArray new];
        [_propBetArray addObject:propBet];
        [propTextField resignFirstResponder];
        [detailTextField resignFirstResponder];
        propTextField.text = @"";
        detailTextField.text = @"";
    }
}



@end
