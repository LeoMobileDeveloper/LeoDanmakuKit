//
//  LeoDanmakuChannel.m
//  LeoDanmakuKit
//
//  Created by huangwenchen on 15/12/21.
//  Copyright © 2015年 WenchenHuang. All rights reserved.
//

#import "LeoDanmakuChannel.h"
@interface LeoDanmakuChannel ()

@property (strong,nonatomic)NSMutableArray * activeLayers;

@end

@implementation LeoDanmakuChannel

+(instancetype)channel{
    return [[self alloc] init];    
}
-(instancetype)init{
    if (self = [super init]) {
        _activeLayers = [NSMutableArray new];
        _state = LeoDanmakuChannelStateFree;
    }
    return self;
}

-(void)addActiveLayer:(LeoDanmakuLayer *)danmakuLayer{
    [_activeLayers addObject:danmakuLayer];
}

-(void)removeActiveLayer:(LeoDanmakuLayer *)danmakuLayer{
    [_activeLayers removeObject:danmakuLayer];
}

-(void)clearAllLayers{
    [_activeLayers removeAllObjects];
}

-(LeoDanmakuLayer *)activeLayer{
    return _activeLayers.lastObject;
}
-(NSArray *)allActiveLayers{
    return [_activeLayers copy];
}
@end
