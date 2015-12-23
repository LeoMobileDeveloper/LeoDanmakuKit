//
//  LeoDanmakuChannelManager.m
//  LeoDanmakuKit
//
//  Created by huangwenchen on 15/12/21.
//  Copyright © 2015年 WenchenHuang. All rights reserved.
//

#import "LeoDanmakuChannelManager.h"
#import "LeoDanmakuRandom.h"
#import "LeoDanmakuLayer.h"
#define ARC4RANDOM_MAX  0x100000000

@interface LeoDanmakuChannelManager ()

@property (strong,nonatomic)NSMutableDictionary * indexToChannelDic;

@end

@implementation LeoDanmakuChannelManager
-(NSArray *)allActiveLayers{
    NSMutableArray * mutableArray = [NSMutableArray new];
    for (LeoDanmakuChannel * channel in  _indexToChannelDic.allValues) {
        NSArray * activeLayers = [channel allActiveLayers];
        [mutableArray addObjectsFromArray:activeLayers];
    }
    return mutableArray;
}
-(void)clear{
    for (LeoDanmakuChannel * channel  in _indexToChannelDic.allValues) {
        [channel clearAllLayers];
        channel.state = LeoDanmakuChannelStateFree;
    }
}
-(instancetype)init{
    if (self = [super init]) {
        _indexToChannelDic = [NSMutableDictionary new];
        _minSpace = 20;
        _minSpeed = 50;
        _maxSpeed = 100;
        _inverval = 0.5;
        _channelsCount = 8;
        for (int index = 0; index < _channelsCount; index ++) {
            [_indexToChannelDic setObject:[LeoDanmakuChannel channel] forKey:@(index)];
        }
    }
    return self;
}

-(void)addActiveLayer:(LeoDanmakuLayer *)danmakuLayer forChannel:(NSInteger)channelIndex{
    LeoDanmakuChannel * channel = [_indexToChannelDic objectForKey:@(channelIndex)];
    [channel addActiveLayer:danmakuLayer];
}

-(void)removeActiveLayer:(LeoDanmakuLayer *)danmakuLayer forChannel:(NSInteger)channelIndex{
    LeoDanmakuChannel * channel = [_indexToChannelDic objectForKey:@(channelIndex)];
    [channel removeActiveLayer:danmakuLayer];
}
-(void)setState:(LeoDanmakuChannelState)state forChannel:(NSInteger)channelIndex{
    
    LeoDanmakuChannel * channel = [_indexToChannelDic objectForKey:@(channelIndex)];
    channel.state = state;
}

-(LeoDanmakuChannelState)stateForChannel:(NSInteger)channelIndex{
    LeoDanmakuChannel * channel = [_indexToChannelDic objectForKey:@(channelIndex)];

    return channel.state;
}

+(instancetype)manager{
    return [[self alloc] init];
}

-(LeoDanmakuRandom *)randomFreeChannelWithWidth:(CGFloat)width CanOverLay:(BOOL)canOverlay{
    NSInteger randomChannel = arc4random() % self.channelsCount;
    LeoDanmakuRandom * random = nil;
    NSNumber * targetChannel = nil;
    if ([self stateForChannel:randomChannel] == LeoDanmakuChannelStateBusy) {
        NSInteger randomSetp = (arc4random() % 2 == 0)?-1:1;
        NSInteger nextChannel = [self limitChannelIndex:randomChannel WithSetp:randomSetp];
        while (nextChannel != randomChannel) {
            if ([self stateForChannel:nextChannel] == LeoDanmakuChannelStateFree) {
                targetChannel = @(nextChannel);
                break;
            }
            nextChannel = [self limitChannelIndex:nextChannel WithSetp:randomSetp];
        }
    }else{
        targetChannel = @(randomChannel);
    }
    if (targetChannel != nil) {
        random = [[LeoDanmakuRandom alloc] init];
        random.channelIndex = targetChannel.integerValue;
        LeoDanmakuChannel * channel = [[self indexToChannelDic] objectForKey:targetChannel];
        LeoDanmakuLayer * activeLayer = [channel activeLayer];
        
        if (activeLayer == nil) {
            random.speed = self.minSpeed + (self.maxSpeed - self.minSpeed)*arc4random()/ARC4RANDOM_MAX;
        }else{
            if (canOverlay) {
                random.speed = self.minSpeed + (self.maxSpeed - self.minSpeed)*arc4random()/ARC4RANDOM_MAX;
            }else{
                CALayer * presentLayer = activeLayer.presentationLayer;
                CGPoint location = presentLayer.position;
                CGFloat layerWidth = CGRectGetWidth(presentLayer.bounds);
                CGFloat lastIndex = location.x + layerWidth;
                CGFloat activeSpeed = activeLayer.leoDanmakuSpeed;
                CGFloat maxSpeed = activeSpeed * width /lastIndex;
                if (maxSpeed < self.minSpeed) {
                    maxSpeed = self.minSpeed;
                }
                if (maxSpeed > self.maxSpeed) {
                    maxSpeed = self.maxSpeed;
                }
                random.speed = self.minSpeed + (maxSpeed - self.minSpeed)*arc4random()/ARC4RANDOM_MAX;
            }

        }
    }
    return random;
}
-(NSInteger)limitChannelIndex:(NSInteger)index WithSetp:(NSInteger)step{
    NSInteger nextIndex = index + step;
    if (step > 0 && nextIndex == self.channelsCount) {
        return 0;
    }
    if (step < 0 && nextIndex == -1) {
        return self.channelsCount - 1 ;
    }
    return nextIndex;
}
@end
