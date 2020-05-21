//
//  HHLocalAut.m
//
//  Created by liluojian on 2020/3/16.
//  Copyright © 2020 liluojian. All rights reserved.
//

#import "HHLocalAut.h"
@interface HHLocalAut()
@property (nonatomic , strong) LAContext *context;
@end
@implementation HHLocalAut
-(instancetype)init{
    if(self = [super init]){
        self.context = [[LAContext alloc] init];
    }
    return self;
}

-(BiometryTyle)getSupportType{
    if([UIDevice currentDevice].systemVersion.floatValue >= 8.0){
        //错误对象
        NSError* error =nil;
        BOOL isSupport = [_context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
        if(isSupport){
            if (@available(iOS 11.0, *)) {
                if(_context.biometryType == LABiometryTypeTouchID){
                    //支持指纹识别
                    return biometryTyleTouchID;
                }else if(_context.biometryType == LABiometryTypeFaceID){
                    //支持面容ID
                    return biometryTyleFaceID;
                }else{
                    return biometryTyleNone;
                }
            } else {
                //支持指纹解锁
                return biometryTyleTouchID;
            }
        }else{
            //不支持手势密码或者人脸识别功能
            return biometryTyleNone;
        }
    }else{
        //不支持手势密码或者人脸识别功能
        return biometryTyleNone;
    }
}

-(void)evaluatePolicy:(void(^)(BOOL success,LAError error, NSString *reason))resulte{
    _context.localizedFallbackTitle = @"输入密码";
    NSString *localizedReason = [self getSupportType] == biometryTyleTouchID?@"请验证您的TouchID":@"请验证您的FaceID";
    NSError *error = nil;
    if([_context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]){
        [_context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:localizedReason reply:^(BOOL success, NSError * _Nullable error) {
            NSString *resulteReason = @"";
            if(success){
                if(resulte){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        resulte(true,0,@"验证成功");
                    });
                }
            }else{
                switch (error.code) {
                    case LAErrorAuthenticationFailed:
                        resulteReason = @"身份验证失败";
                        break;
                    case LAErrorUserCancel:
                        resulteReason = @"用户在认证时点击取消";
                        break;
                    case LAErrorUserFallback:
                        resulteReason = @"用户点击输入密码取消指纹验证";
                        break;
                    case LAErrorSystemCancel:
                        resulteReason = @"身份认证被系统取消(按下Home键或电源键)";
                        break;
                    case LAErrorTouchIDNotEnrolled:
                        resulteReason = @"用户未录入指纹";
                        break;
                    case LAErrorPasscodeNotSet:
                        resulteReason = @"设备未设置密码";
                        break;
                    case LAErrorTouchIDNotAvailable:
                        resulteReason = @"该设备未设置生物识别";
                        break;
                    case LAErrorTouchIDLockout:
                        resulteReason = @"连续五次密码错误,被锁定";
                        break;
                    case LAErrorAppCancel:
                        resulteReason = @"用户不能控制情况下App被挂起";
                        break;
                    default:
                        break;
                }
                if(resulte){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        resulte(false,error.code,resulteReason);
                    });
                }
            }
        }];
    }else{
        NSLog(@"当前设备不支持或已被锁定");
        if(resulte){
            dispatch_async(dispatch_get_main_queue(), ^{
                resulte(false,error.code,@"当前设备不支持或已被锁定");
            });
        }
    }
}
@end
