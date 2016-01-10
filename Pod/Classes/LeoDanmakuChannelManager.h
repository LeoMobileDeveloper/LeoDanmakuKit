//
//  LeoDanmakuChannelManager.h
//  LeoDanmakuKit
//
//  Created by huangwenchen on 15/12/21.
//  Copyright © 2015年 WenchenHuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LeoDanmakuChannel.h"

@class LeoDanmakuRandom;

@interface LeoDanmakuChannelManager : NSObject

@property (assign,nonatomic)CGFloat maxSpeed;

@property (assign,nonatomic)CGFloat minSpeed;//

@property (assign,nonatomic)CGFloat minSpace;//default 20

@property (assign,nonatomic)CGFloat inverval;//Default 0.25

@property (assign,nonatomic)NSInteger channelsCount;

+(instancetype)manager;

-(LeoDanmakuChannelState)stateForChannel:(NSInteger)channelIndex;

-(void)setState:(LeoDanmakuChannelState)state forChannel:(NSInteger)channelIndex;

-(void)addActiveLayer:(LeoDanmakuLayer *)danmakuLayer forChannel:(NSInteger)channelIndex;

-(void)removeActiveLayer:(LeoDanmakuLayer *)danmakuLayer forChannel:(NSInteger)channelIndex;


-(LeoDanmakuRandom *)randomFreeChannelWithWidth:(CGFloat)width CanOverLay:(BOOL)canOverlay;

-(void)clear;

-(NSArray *)allActiveLayers;

@end
