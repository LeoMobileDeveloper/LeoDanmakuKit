//
//  LeoDanmakuLayer.h
//  LeoDanmakuKit
//
//  Created by huangwenchen on 15/12/21.
//  Copyright © 2015年 WenchenHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeoDanmkuModel;

@interface LeoDanmakuLayer : CATextLayer

-(instancetype)initWithDanmku:(LeoDanmkuModel *)danmku;

+(instancetype)danmuLayerWith:(LeoDanmkuModel *)danmku;

-(void)setupWithDanmu:(LeoDanmkuModel *)danmku;


@property (assign,nonatomic)CGFloat leoDanmakuSpeed;

@property (assign,nonatomic)NSInteger leoChannelIndex;
@end
