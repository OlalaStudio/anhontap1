//
//  UICommonDefines.h
//  Toeic
//
//  Created by NguyenThanhLuan on 23/03/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#ifndef UICommonDefines_h
#define UICommonDefines_h

typedef enum : NSUInteger {
    kUnknow  = 0,
    kAnwserA = 1,
    kAnwserB = 2,
    kAnwserC = 3,
    kAnwserD = 4,
} AnwserState;

#define FONT_SIZE       20
#define SELECT_COLOR    [UIColor orangeColor]
#define DESELECT_COLOR  [UIColor blackColor]


#endif /* UICommonDefines_h */
