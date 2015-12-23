//
//  LeoDanmakuChannel.h
//  LeoDanmakuKit
//
//  Created by huangwenchen on 15/12/21.
//  Copyright © 2015年 WenchenHuang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LeoDanmakuLayer;
typedef NS_ENUM(NSInteger,LeoDanmakuChannelState){
    LeoDanmakuChannelStateFree,
    LeoDanmakuChannelStateBusy,
};

@interface LeoDanmakuChannel : NSObject

@property (nonatomic)LeoDanmakuChannelState state;


-(void)addActiveLayer:(LeoDanmakuLayer *)danmakuLayer;

-(void)removeActiveLayer:(LeoDanmakuLayer *)danmakuLayer;

-(void)clearAllLayers;

-(LeoDanmakuLayer *)activeLayer;

+(instancetype)channel;

-(NSArray *)allActiveLayers;

@end
