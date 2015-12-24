//
//  LeoDanmakuLayer.h
//  LeoDanmakuKit
//
//  Created by huangwenchen on 15/12/21.
//  Copyright © 2015年 WenchenHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeoDanmakuModel;

@interface LeoDanmakuLayer : CATextLayer

-(instancetype)initWithDanmku:(LeoDanmakuModel *)danmku;

+(instancetype)danmuLayerWith:(LeoDanmakuModel *)danmku;

-(void)setupWithDanmu:(LeoDanmakuModel *)danmku;


@property (assign,nonatomic)CGFloat leoDanmakuSpeed;

@property (assign,nonatomic)NSInteger leoChannelIndex;
@end
