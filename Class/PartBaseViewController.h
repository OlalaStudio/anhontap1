//
//  PartBaseViewController.h
//  Toeic
//
//  Created by NguyenThanhLuan on 14/04/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Appirater.h"

@import GoogleMobileAds;

@interface PartBaseViewController : UIViewController <GADBannerViewDelegate,GADInterstitialDelegate,AppiraterDelegate>{
    GADBannerView           *_adBannerView;
    GADInterstitial         *_interstitial;
    
    BOOL        _adsloaded;
}

@end
