**IOS 指纹识别以及面容识别**

```
typedef enum biometryTyle{
biometryTyleNone,//不支持生物识别 
biometryTyleTouchID,//支持指纹识别 
biometryTyleFaceID//支持面容识别 
} BiometryTyle;
```
@interface HHLocalAut : NSObject //获取当前设备支持的生物识别类型、指纹或者Face.   
`-(BiometryTyle)getSupportType;` //一句代码实现识别==>开始识别.  
`-(void)evaluatePolicy:(void(^)(BOOL success,LAError error,NSString *reason))resulte.`  
