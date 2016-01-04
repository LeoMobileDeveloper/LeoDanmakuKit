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

//! Allow overlapping or not
@property (readwrite,nonatomic,assign)BOOL allowOverlapping;

//! Current state of DanmakuView
@property (readonly,nonatomic,assign)LeoDanmakuViewState state;

@property (strong,nonatomic)LeoDanmakuChannelManager * channelManager;


//! Max size of view buffer,default is 300,if there are more than 300 elements in buffer,it will auto clear 20%(60 items)

@property (assign,nonatomic)NSInteger maxBufferSize;
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
-(void)resume;

/*!
 * @discussion Stop Playing
 * @param void
 * @return void
 */
-(void)stop;

/*!
 * @discussion hide/unhidden all danmku
 * @param void
 * @return void
 */

-(void)setAllDanmukuHidden:(BOOL)isHidden;

-(void)pause;



@end
