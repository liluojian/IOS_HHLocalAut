//
//  HHAlert.h
//  WealthPartners
//
//  Created by 李罗坚 on 2020/3/20.
//  Copyright © 2020 李罗坚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface HHAlert : NSObject
@property (nonatomic , strong) UIColor *titleColor;
@property (nonatomic , strong) UIColor *messageColor;
@property (nonatomic , strong) UIColor *confirmColor;
@property (nonatomic , strong) UIColor *cancelColor;
@property (nonatomic , assign) NSInteger alertStyle;//默认0警告框 1action
@property (nonatomic , strong) NSMutableArray<UIAlertAction*> *actions;

+(HHAlert*)alert:(void(^ __nullable)(HHAlert *alert))block title:(NSString* __nullable)title message:(NSString*)message confirm:(NSString* __nullable)confirm cancel:(NSString* __nullable)cancel confirmBlock:(void(^ __nullable)(HHAlert*alert))confirmBlock cancelBlock:(void(^ __nullable)(HHAlert*alert))cancelBlock;
+(HHAlert*)alert:(void(^ __nullable)(HHAlert *alert))block title:(NSString* __nullable)title message:(NSString* __nullable)message confirm:(NSString* __nullable)confirm confirmBlock:(void(^ __nullable)(HHAlert*alert))confirmBlock;
-(void)show;
-(void)dissMiss;
@end

NS_ASSUME_NONNULL_END
