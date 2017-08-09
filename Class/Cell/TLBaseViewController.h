//
//  TLBaseViewController.h
//  Toeic
//
//  Created by NguyenThanhLuan on 23/03/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICommonDefines.h"
#import "FCAlertView.h"

@interface TLBaseViewController : UIViewController{
    AnwserState     _anwser;
}

@property AnwserState   anwser;

-(void)showAnwser:(BOOL)result;

@end
