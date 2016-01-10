//
//  LeoDanmkuModel.h
//  LeoDanmakuKit
//
//  Created by huangwenchen on 15/12/21.
//  Copyright © 2015年 WenchenHuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LeoDanmakuModel : NSObject<NSCopying,NSCoding>

@property (copy,nonatomic)NSString * text;

@property (copy,nonatomic)UIColor * textColor;

@property (copy,nonatomic)UIColor * backgroundColor;

@property (assign,nonatomic)NSInteger  fontSize;

@property (assign,nonatomic)BOOL removedWhenBufferFull;

@property (copy,nonatomic)UIColor * borderColor;

+(instancetype)danmkuWithString:(NSString *)text;

+(instancetype)randomDanmkuWithColors:(NSArray *)colors MaxFontSize:(NSInteger)maxFont MinFontSize:(NSInteger)minFont;


@end
