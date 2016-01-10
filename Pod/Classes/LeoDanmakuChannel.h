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

/*!
 * @discussion Add an active layer in to channel
 * @param danmakuLayer a LeoDanmakuLayer instance
 * @return void
 */

-(void)addActiveLayer:(LeoDanmakuLayer *)danmakuLayer;

/*!
 * @discussion Remove an active layer in to channel
 * @param danmakuLayer a LeoDanmakuLayer instance
 * @return void
 */
-(void)removeActiveLayer:(LeoDanmakuLayer *)danmakuLayer;

/*!
 * @discussion Clear all layers
 * @param void
 * @return void
 */
-(void)clearAllLayers;

/*!
 * @discussion Get the current active layer
 * @param void
 * @return LeoDanmakuLayer instance
 */
-(LeoDanmakuLayer *)activeLayer;

/*!
 * @discussion Factory method to create a channel
 */

+(instancetype)channel;
/*!
 * @discussion Get all active layers
 */
-(NSArray *)allActiveLayers;

@end
