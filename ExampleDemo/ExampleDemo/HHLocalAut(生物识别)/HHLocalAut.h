//
//  HHLocalAut.h
//  生物识别
//  Created by liluojian on 2020/3/16.
//  Copyright © 2020 liluojian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <LocalAuthentication/LocalAuthentication.h>
NS_ASSUME_NONNULL_BEGIN
typedef enum biometryTyle{
    biometryTyleNone,//不支持生物识别
    biometryTyleTouchID,//支持指纹识别
    biometryTyleFaceID//支持面容识别
} BiometryTyle;
@interface HHLocalAut : NSObject
//获取当前设备支持的生物识别类型、指纹或者Face
- (BiometryTyle)getSupportType;
//开始识别
- (void)evaluatePolicy:(void(^)(BOOL success,LAError error,NSString *reason))resulte;
@end

NS_ASSUME_NONNULL_END
