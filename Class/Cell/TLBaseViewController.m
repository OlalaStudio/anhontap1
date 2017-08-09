//
//  TLBaseViewController.m
//  Toeic
//
//  Created by NguyenThanhLuan on 23/03/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLBaseViewController.h"

@interface TLBaseViewController ()

@end

@implementation TLBaseViewController
@synthesize anwser = _anwser;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setAnwser:(AnwserState)anwser{
    _anwser = anwser;
}

-(AnwserState)anwser{
    return _anwser;
}

-(void)showAnwser:(BOOL)result{

    FCAlertView *alert = [[FCAlertView alloc] init];
    
    if (result) {
        [alert showAlertWithTitle:@"Correct!" withSubtitle:nil withCustomImage:nil withDoneButtonTitle:nil andButtons:nil];
        [alert makeAlertTypeSuccess];
    }
    else{
        [alert showAlertWithTitle:@"Wrong!" withSubtitle:nil withCustomImage:nil withDoneButtonTitle:nil andButtons:nil];
        [alert makeAlertTypeWarning];
    }
}

@end
