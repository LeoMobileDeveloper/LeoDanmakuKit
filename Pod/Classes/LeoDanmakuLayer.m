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
    self.borderColor = danmku.borderColor.CGColor;
    self.borderWidth = 2.0;
    self.shadowColor = [UIColor blackColor].CGColor;
    self.shadowOffset = CGSizeMake(2, 2);
    self.shadowRadius = 2.0;
    self.alignmentMode = kCAAlignmentCenter;
    CGRect bound;
    UILabel * label = [UILabel new];
    label.text = danmku.text;
    label.font = [UIFont systemFontOfSize:danmku.fontSize];
    [label sizeToFit];
    bound.origin = CGPointZero;
    bound.size = CGSizeMake(CGRectGetWidth(label.frame) + 6, CGRectGetHeight(label.frame));
    self.bounds = bound;
}
@end
