# LeoDanmakuKit

[![Version](https://img.shields.io/cocoapods/v/LeoDanmakuKit.svg?style=flat)](http://cocoapods.org/pods/LeoDanmakuKit)
[![License](https://img.shields.io/cocoapods/l/LeoDanmakuKit.svg?style=flat)](http://cocoapods.org/pods/LeoDanmakuKit)
[![Platform](https://img.shields.io/cocoapods/p/LeoDanmakuKit.svg?style=flat)](http://cocoapods.org/pods/LeoDanmakuKit)

## Screenshot

 <img src="https://raw.github.com/LeoMobileDeveloper/LeoDanmakuKit/master/Screenshots/s.png" width="320" />

## Requirements

- ARC
- iOS 7 +


## Support

- Storyboard
- Auto limit buffer size
- Random color or channel
- High performance

## Installation

LeoDanmakuKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:


```ruby
pod "LeoDanmakuKit"
```

## Manual installation

You can also download the Example project and copy the Class floder into your project

## Usage


```
#import "LeoDanmaku.h"
```


When you add a new danmaku,you first create a `LeoDanmakuModel`,for example,you may use the random factory method build in

```
NSArray * colors = @[[UIColor redColor],[UIColor blueColor],[UIColor greenColor],[UIColor whiteColor]];
LeoDanmkuModel * danmaku = [LeoDanmkuModel randomDanmkuWithColors:colors MaxFontSize:18 MinFontSize:15];
danmaku.text = self.textfiled.text;
```

Then

```
[self.danmakuView addDanmaku:danmaku];

```

## About remove 

When you want the view remove from superview and get dealloced,do not forget to call

```
[self.danmakuView stop]
```

## Propertys

You can set the speed and other related property of LeoDanmakuChannelManager

```
@property (assign,nonatomic)CGFloat maxSpeed;//Default 100 points/s

@property (assign,nonatomic)CGFloat minSpeed;//Default 50 points/s

@property (assign,nonatomic)CGFloat minSpace;//Default 20

@property (assign,nonatomic)CGFloat inverval;//Default 0.25

@property (assign,nonatomic)NSInteger channelsCount;//Number of channels
```

## Author

LeoMobileDeveloper, leomobiledeveloper@gmail.com

## License

LeoDanmakuKit is available under the MIT license. See the LICENSE file for more info.

------
## 中文文档请见我的[博客](http://blog.csdn.net/hello_hwc/article/details/50382078)
