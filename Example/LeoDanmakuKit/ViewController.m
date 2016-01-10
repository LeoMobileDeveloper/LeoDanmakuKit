//
//  ViewController.m
//  LeoDanmakuKit
//
//  Created by huangwenchen on 15/12/21.
//  Copyright © 2015年 WenchenHuang. All rights reserved.
//

#import "ViewController.h"
#import "LeoDanmaku.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstarint;
@property (weak, nonatomic) IBOutlet UITextField *textfiled;
@property (weak, nonatomic) IBOutlet LeoDanmakuView *danmakuView;

@end

@implementation ViewController
- (IBAction)send:(id)sender {
    if (self.textfiled.text != nil) {
        NSArray * colors = @[[UIColor redColor],[UIColor blueColor],[UIColor greenColor],[UIColor whiteColor]];
        LeoDanmakuModel * danmaku = [LeoDanmakuModel randomDanmkuWithColors:colors MaxFontSize:18 MinFontSize:15];
        danmaku.text = self.textfiled.text;
        danmaku.borderColor = [UIColor whiteColor];
        [self.danmakuView addDanmaku:danmaku];
        [self.textfiled endEditing:true];
    }
}
- (IBAction)pause:(id)sender {
    [self.danmakuView pause];
}
- (IBAction)resume:(id)sender {
    [self.danmakuView resume];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.danmakuView resume];
    self.danmakuView.allowOverlapping = true;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)keyboardWillShow:(NSNotification *)notification{
    NSDictionary * info = notification.userInfo;
    NSValue * value = info[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = value.CGRectValue;
    CGFloat duration = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.bottomConstarint.constant = CGRectGetHeight(keyboardFrame);
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}
-(void)keyboardWillHide:(NSNotification *)notification{
    NSDictionary * info = notification.userInfo;
    CGFloat duration = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.bottomConstarint.constant = 8;
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
