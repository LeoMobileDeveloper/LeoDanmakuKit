//
//  LeoDanmkuModel.m
//  LeoDanmakuKit
//
//  Created by huangwenchen on 15/12/21.
//  Copyright © 2015年 WenchenHuang. All rights reserved.
//

#import "LeoDanmkuModel.h"

@implementation LeoDanmkuModel
-(instancetype)init{
    if (self = [super init]) {
        _textColor = [UIColor greenColor];
        _backgroundColor = [UIColor clearColor];
        _fontSize = 14;
    }
    return self;
}
+(instancetype)danmkuWithString:(NSString *)text{
    LeoDanmkuModel * danmku = [[self alloc] init];
    danmku.text = text;
    return danmku;
}
+(instancetype)randomDanmkuWithColors:(NSArray *)colors MaxFontSize:(NSInteger)maxFont MinFontSize:(NSInteger)minFont{
    LeoDanmkuModel * danmku  = [[self alloc] init];
    danmku.fontSize = minFont + arc4random() % (maxFont - minFont);
    danmku.textColor = colors[arc4random() % colors.count];
    return danmku;
}
@end
