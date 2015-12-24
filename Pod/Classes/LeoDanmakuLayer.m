//
//  LeoDanmakuLayer.m
//  LeoDanmakuKit
//
//  Created by huangwenchen on 15/12/21.
//  Copyright © 2015年 WenchenHuang. All rights reserved.
//

#import "LeoDanmakuLayer.h"
#import "LeoDanmakuModel.h"
@implementation LeoDanmakuLayer

-(instancetype)initWithDanmku:(LeoDanmakuModel *)danmku{
    if (self = [super init]) {
        self.name = @"LeoDanmaKuLayer";
        self.anchorPoint = CGPointMake(0, 0);
        self.contentsScale = [[UIScreen mainScreen] scale];
        [self setupWithDanmu:danmku];
    }
    return self;
}

+(instancetype)danmuLayerWith:(LeoDanmakuModel *)danmku{
    return [[self alloc] initWithDanmku:danmku];
}

-(void)setupWithDanmu:(LeoDanmakuModel *)danmku{
    self.foregroundColor = danmku.textColor.CGColor;
    self.backgroundColor = danmku.backgroundColor.CGColor;
    self.fontSize = danmku.fontSize;
    self.string = danmku.text;
    CGSize textSize = [self.string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 100) options:NSStringDrawingUsesDeviceMetrics | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:self.fontSize]} context:nil].size;
    CGRect bound;
    bound.origin = CGPointZero;
    bound.size = CGSizeMake(textSize.width + 5, 100);
    self.bounds = bound;
}
@end
