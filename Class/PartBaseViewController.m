//
//  PartBaseViewController.m
//  Toeic
//
//  Created by NguyenThanhLuan on 14/04/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "PartBaseViewController.h"

@interface PartBaseViewController ()

@end

@implementation PartBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //load banner ads
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        _adBannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeFullBanner];
    }
    else{
        _adBannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    }
    
    [_adBannerView setAdUnitID:@"ca-app-pub-4039533744360639/3060560500"];
    [_adBannerView setDelegate:self];
    [_adBannerView setRootViewController:self];
    
    _adsloaded = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    //show ads
    _adsloaded = NO;
    _interstitial = [self createAndLoadInterstitial];
}

-(void)viewDidAppear:(BOOL)animated{
    GADRequest *request = [GADRequest request];
//    request.testDevices = @[kGADSimulatorID,@"aea500effe80e30d5b9edfd352b1602d"];
    
    [_adBannerView loadRequest:request];
    
    [self runRateApp];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Ads Delegate
-(void)interstitialDidReceiveAd:(GADInterstitial *)ad
{
    _interstitial = ad;
    _adsloaded = YES;
}

-(void)interstitialDidFailToPresentScreen:(GADInterstitial *)ad
{
    _adsloaded = NO;
    NSLog(@"Fail to load interstitial ads");
}

-(GADInterstitial*)createAndLoadInterstitial
{
    _interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-4039533744360639/4537293701"];
    
    GADRequest *request = [GADRequest request];
//    request.testDevices = @[kGADSimulatorID,@"aea500effe80e30d5b9edfd352b1602d"];
    
    [_interstitial setDelegate:self];
    [_interstitial loadRequest:request];
    
    return _interstitial;
}

#pragma mark - Setting
-(void)runRateApp
{
    //1190545147
    [Appirater setAppId:@"1255447586"];    // Change for your "Your APP ID"
    [Appirater setDaysUntilPrompt:1];     // Days from first entered the app until prompt
    [Appirater setUsesUntilPrompt:12];     // Number of uses until prompt
    [Appirater setTimeBeforeReminding:2]; // Days until reminding if the user taps "remind me"
    //[Appirater setDebug:YES];           // If you set this to YES it will display all the time
    
    //... Perhaps do stuff
    
    [Appirater appLaunched:YES];
}


@end
