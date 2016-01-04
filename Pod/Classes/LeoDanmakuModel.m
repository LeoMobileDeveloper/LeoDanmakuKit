//
//  LeoDanmkuModel.m
//  LeoDanmakuKit
//
//  Created by huangwenchen on 15/12/21.
//  Copyright © 2015年 WenchenHuang. All rights reserved.
//

#import "LeoDanmakuModel.h"

@implementation LeoDanmakuModel
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.text = [aDecoder decodeObjectForKey:@"kLeoDannmakuModelText"];
        self.textColor = [aDecoder decodeObjectForKey:@"kLeoDanmakuModelTextColor"];
        self.backgroundColor = [aDecoder decodeObjectForKey:@"kLeoDanmakuModelBackgroundColor"];
        self.fontSize = [[aDecoder decodeObjectForKey:@"kLeoDanmakuModelFontSize"] integerValue];
        self.removedWhenBufferFull = [[aDecoder decodeObjectForKey:@"kDanmakuModelRemovedWhenFull"] boolValue];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
   if(self.text) [aCoder encodeObject:self.text forKey:@"kLeoDannmakuModelText"];
   if(self.textColor) [aCoder encodeObject:self.textColor forKey:@"kLeoDanmakuModelTextColor"];
   if(self.backgroundColor) [aCoder encodeObject:self.backgroundColor forKey:@"kLeoDanmakuModelBackgroundColor"];
    [aCoder encodeObject:@(self.fontSize) forKey:@"kLeoDanmakuModelFontSize"];
    [aCoder encodeObject:@(self.removedWhenBufferFull) forKey:@"kLeoDanmakuModelFontSize"];
}
-(instancetype)copyWithZone:(NSZone *)zone{
    LeoDanmakuModel * copyModel = [[self.class allocWithZone:zone] init];
    copyModel->_text = self.text;
    copyModel->_fontSize = self.fontSize;
    copyModel->_backgroundColor = self.backgroundColor;
    copyModel->_textColor = self.textColor;
    copyModel->_removedWhenBufferFull = self.removedWhenBufferFull;
    return copyModel;
}
-(instancetype)init{
    if (self = [super init]) {
        _textColor = [UIColor greenColor];
        _backgroundColor = [UIColor clearColor];
        _fontSize = 14;
        _removedWhenBufferFull = true;
    }
    return self;
}
+(instancetype)danmkuWithString:(NSString *)text{
    LeoDanmakuModel * danmku = [[self alloc] init];
    danmku.text = text;
    return danmku;
}
+(instancetype)randomDanmkuWithColors:(NSArray *)colors MaxFontSize:(NSInteger)maxFont MinFontSize:(NSInteger)minFont{
    LeoDanmakuModel * danmku  = [[self alloc] init];
    danmku.fontSize = minFont + arc4random() % (maxFont - minFont);
    danmku.textColor = colors[arc4random() % colors.count];
    return danmku;
}
@end
