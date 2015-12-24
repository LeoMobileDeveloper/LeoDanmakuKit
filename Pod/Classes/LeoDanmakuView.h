//
//  LeoDanmakuView.h
//  LeoDanmakuKit
//
//  Created by huangwenchen on 15/12/21.
//  Copyright © 2015年 WenchenHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LeoDanmakuViewState){
    LeoDanmakuViewStatePlaying,
    LeoDanmakuViewStatePaused,
    LeoDanmakuViewStateStoped
};
@class LeoDanmakuModel;
@class LeoDanmakuChannelManager;
/**
 @abstract LeoDanmakuView is subview of UIView,it is the visual state of DanmakuView,you usually create an isntance of it,then add it as a subview
 */
@interface LeoDanmakuView : UIView

//! Allow overlapping if line
@property (readwrite,nonatomic,assign)BOOL allowOverlapping;

@property (readonly,nonatomic,assign)LeoDanmakuViewState state;

@property (strong,nonatomic)LeoDanmakuChannelManager * channelManager;

/*!
 * @discussion Add a danmku
 * @param danmku object of LeoDanmkuModel
 * @return void
 */

-(void)addDanmaku:(LeoDanmakuModel *)danmku;

/*!
 * @discussion Add a danmku
 * @param danmku object of LeoDanmkuModel
 * @return void
 */
-(void)addDanmakuWithArray:(NSArray *)danmkus;

/*!
 * @discussion Start Playing
 * @param void
 * @return void
 */
-(void)resumePlaying;

/*!
 * @discussion Stop Playing
 * @param void
 * @return void
 */
-(void)stopPlaying;

/*!
 * @discussion hide/unhidden all danmku
 * @param void
 * @return void
 */

-(void)setAllDanmukuHidden:(BOOL)isHidden;

-(void)pausePlaying;



@end
