//
//  LeoDanmakuView.m
//  LeoDanmakuKit
//
//  Created by huangwenchen on 15/12/21.
//  Copyright © 2015年 WenchenHuang. All rights reserved.
//

#import "LeoDanmakuView.h"
#import "LeoDanmakuLayer.h"
#import "LeoDanmakuModel.h"
#import "LeoDanmakuChannelManager.h"
#import "LeoDanmakuRandom.h"

@interface LeoDanmakuView ()

@property (strong,nonatomic)NSMutableArray * danmakuBuffers;

@property (strong,nonatomic)NSTimer * fireTimer;

@property (readwrite,nonatomic,assign)LeoDanmakuViewState state;

@property (strong,nonatomic)dispatch_queue_t dataQueue;

@end

@implementation LeoDanmakuView

#pragma mark - Init method
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

-(instancetype)init{
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

//TODO: Need to be done
#pragma mark - Private mehod

-(void)commonInit{
    _danmakuBuffers = [[NSMutableArray alloc] init];
    _channelManager = [LeoDanmakuChannelManager manager];
    _maxBufferSize = 100;
    _dataQueue = dispatch_queue_create("com.LeodanmakuKit.dataQueue", DISPATCH_QUEUE_SERIAL);
}

-(void)timeToUpdateView{
    if (self.danmakuBuffers.count == 0) {
        return;
    }
    LeoDanmakuRandom * random = [self.channelManager randomFreeChannelWithWidth:CGRectGetWidth(self.frame) CanOverLay:self.allowOverlapping];
    if (random == nil) {
        return;
    }
    __block LeoDanmakuModel * danmkuModel;
    dispatch_sync(self.dataQueue, ^{
        danmkuModel = [self.danmakuBuffers firstObject];
        [self.danmakuBuffers removeObjectAtIndex:0];
    });
    LeoDanmakuLayer * danmkuLayer = [[LeoDanmakuLayer alloc] initWithDanmku:danmkuModel];
    [self.layer addSublayer:danmkuLayer];
    danmkuLayer.leoDanmakuSpeed = random.speed;
    danmkuLayer.leoChannelIndex = random.channelIndex;
    //Calculate duration
    CGFloat randomSpeed = random.speed;
    CGFloat totalInterval = (CGRectGetWidth(self.bounds) + CGRectGetWidth(danmkuLayer.bounds))/randomSpeed;
    [self.channelManager setState:LeoDanmakuChannelStateBusy forChannel:random.channelIndex];
    CGFloat x = CGRectGetWidth(self.bounds);
    CGFloat y = CGRectGetHeight(self.bounds)/self.channelManager.channelsCount * random.channelIndex;
    danmkuLayer.position = CGPointMake(x, y);
    CABasicAnimation * animation = [CABasicAnimation animation];
    animation.keyPath = @"position.x";
    animation.toValue = @(0 - CGRectGetWidth(danmkuLayer.bounds));
    animation.duration = totalInterval;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.removedOnCompletion = false;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    [animation setValue:danmkuLayer forKey:@"leoLayer"];
    [animation setValue:@(random.channelIndex) forKey:@"leochannel"];
    [danmkuLayer addAnimation:animation forKey:@"leoanimation"];
    [self.channelManager addActiveLayer:danmkuLayer forChannel:random.channelIndex];
    
    CGFloat freeInterval = (CGRectGetWidth(danmkuLayer.bounds) + self.channelManager.minSpace)/randomSpeed;
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(freeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.channelManager setState:LeoDanmakuChannelStateFree forChannel:random.channelIndex];
    });
}

-(void)setChannelFreeWithindex:(NSNumber *)index{
    
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        [self clearWithAnimation:anim];
        return;
    }
    if (self.state == LeoDanmakuViewStateStoped) {
        [self clearWithAnimation:anim];
    }
}
-(void)clearWithAnimation:(CAAnimation *)anim{
    LeoDanmakuLayer *layer = [anim valueForKey:@"leoLayer"];
    NSNumber * channel = [anim valueForKey:@"leochannel"];
    if(layer) {
        layer.opaque = NO;
        layer.opacity = 0.0;
        [layer removeFromSuperlayer];
        [layer removeAllAnimations];
        [self.channelManager removeActiveLayer:layer forChannel:channel.integerValue];
    }
}
#pragma mark - API

-(void)addDanmakuWithArray:(NSArray *)danmkus{
    dispatch_async(self.dataQueue, ^{
        [_danmakuBuffers addObjectsFromArray:danmkus];
        [self limitBufferSize];
    });
}

-(void)addDanmaku:(LeoDanmakuModel *)danmku{
    dispatch_async(self.dataQueue, ^{
        [_danmakuBuffers addObject:danmku];
        [self limitBufferSize];
    });
}
-(void)limitBufferSize{
    if (_danmakuBuffers.count > self.maxBufferSize) {//remove
        NSMutableIndexSet * setToRemove = [NSMutableIndexSet new];
        for (int index = 0; index < 5;index ++) {
            NSRange toRemoveRange = NSMakeRange(index * self.maxBufferSize * 0.2,self.maxBufferSize * 0.04);
            for (NSUInteger removeIndex = toRemoveRange.location; removeIndex < toRemoveRange.location + toRemoveRange.length; removeIndex++) {
                LeoDanmakuModel * model = [_danmakuBuffers objectAtIndex:removeIndex];
                if (model.removedWhenBufferFull == true) {
                    [setToRemove addIndex:removeIndex];
                }
            }
        }
        [_danmakuBuffers removeObjectsAtIndexes:setToRemove];
    }
}
-(void)resume{
    self.state = LeoDanmakuViewStatePlaying;
    if (self.fireTimer == nil) {
        _fireTimer = [NSTimer timerWithTimeInterval:self.channelManager.inverval target:self selector:@selector(timeToUpdateView) userInfo:nil repeats:true];
        [[NSRunLoop mainRunLoop] addTimer:_fireTimer forMode:NSRunLoopCommonModes];
        [_fireTimer fire];
    }
    NSArray * activeLayers = [self.channelManager allActiveLayers];
    for (LeoDanmakuLayer * danmkuLayer in activeLayers) {
        CALayer * presentLayer = danmkuLayer.presentationLayer;
        CGPoint currentPosition = presentLayer.position;
        CGFloat currentWidth = CGRectGetWidth(presentLayer.bounds);
        CGFloat currentDistanceToGo = currentPosition.x + currentWidth;
        if (currentDistanceToGo <= 0) {
            continue;
        }
        CGFloat currentDuration = currentDistanceToGo/danmkuLayer.leoDanmakuSpeed;
        CABasicAnimation * animation = [CABasicAnimation animation];
        animation.keyPath = @"position.x";
        animation.toValue = @(0 - CGRectGetWidth(danmkuLayer.bounds));
        animation.duration = currentDuration;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.delegate = self;
        [animation setValue:danmkuLayer forKey:@"leoLayer"];
        [animation setValue:@(danmkuLayer.leoChannelIndex) forKey:@"leochannel"];
        [danmkuLayer addAnimation:animation forKey:@"leoanimation"];
    }
}

-(void)pause{
    self.state = LeoDanmakuViewStatePaused;
    for (CALayer * sublayer in self.layer.sublayers) {
        if ([sublayer.name isEqualToString:@"LeoDanmaKuLayer"] && [sublayer isKindOfClass:[LeoDanmakuLayer class]]) {
            LeoDanmakuLayer * danmakuLayer = (LeoDanmakuLayer *)sublayer;
            [danmakuLayer removeAllAnimations];
            CALayer * presentLayer = danmakuLayer.presentationLayer;
            danmakuLayer.position = presentLayer.position;
        }
    }
    [_fireTimer invalidate];
    _fireTimer = nil;
}

-(void)stop{
    self.state = LeoDanmakuViewStateStoped;
    [self.fireTimer invalidate];
    self.fireTimer = nil;
    [self.channelManager clear];
    for (int index = 0;index < self.layer.sublayers.count;index ++) {
        CALayer * sublayer = [self.layer.sublayers objectAtIndex:index];
        [sublayer removeAllAnimations];
        if ([sublayer.name isEqualToString:@"LeoDanmaKuLayer"]) {
            [sublayer removeFromSuperlayer];
        }
    }
    [self.danmakuBuffers removeAllObjects];
    self.channelManager = nil;
}

-(void)setAllDanmukuHidden:(BOOL)isHidden{
    self.hidden = isHidden;
}

@end
