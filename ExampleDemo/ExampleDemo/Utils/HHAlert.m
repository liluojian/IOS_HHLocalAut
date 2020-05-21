//
//  HHAlert.m
//  WealthPartners
//
//  Created by 李罗坚 on 2020/3/20.
//  Copyright © 2020 李罗坚. All rights reserved.
//

#import "HHAlert.h"
@interface HHAlert()
@property (nonatomic , strong) UIAlertController *alert;
@end
@implementation HHAlert

+(HHAlert*)alert:(void(^ __nullable)(HHAlert *alert))block title:(NSString* __nullable)title message:(NSString* __nullable)message confirm:(NSString* __nullable)confirm confirmBlock:(void(^ __nullable)(HHAlert*alert))confirmBlock{
    return [self alert:block title:title message:message confirm:confirm cancel:nil confirmBlock:confirmBlock cancelBlock:nil];
}

+(HHAlert*)alert:(void(^ __nullable)(HHAlert *alert))block title:(NSString* __nullable)title message:(NSString*)message confirm:(NSString* __nullable)confirm cancel:(NSString* __nullable)cancel confirmBlock:(void(^ __nullable)(HHAlert*alert))confirmBlock cancelBlock:(void(^ __nullable)(HHAlert*alert))cancelBlock{
    HHAlert *alertView = [[HHAlert alloc] init];
    if(block){
        block(alertView);
    }
    
    alertView.alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:alertView.alertStyle==0?UIAlertControllerStyleAlert:UIAlertControllerStyleActionSheet];
    
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alertBgAction)];
    [alertView.alert.view addGestureRecognizer:tapG];
    
    for(UIAlertAction *actionItem in alertView.actions){
        [alertView.alert addAction:actionItem];
    }
    
    if(cancel!=nil && ![cancel isEqualToString:@""]){
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            if(cancelBlock){
                cancelBlock(alertView);
            }
            alertView.alert = nil;
        }];
        [cancelAction setValue:alertView.cancelColor?alertView.cancelColor:[UIColor redColor] forKey:@"titleTextColor"];
        [alertView.alert addAction:cancelAction];
    }
    if(confirm!=nil && ![confirm isEqualToString:@""]){
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:confirm style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            if(confirmBlock){
                confirmBlock(alertView);
            }
            alertView.alert = nil;
        }];
        //修改按钮字体颜色
        [defaultAction setValue:alertView.confirmColor?alertView.confirmColor:[UIColor blackColor] forKey:@"titleTextColor"];
        [alertView.alert addAction:defaultAction];
    }
    
    //修改title
    if(alertView.titleColor){
        NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:title];
        [alertControllerStr addAttributes:@{NSForegroundColorAttributeName:alertView.titleColor} range:NSMakeRange(0, title.length)];
        [alertView.alert setValue:alertControllerStr forKey:@"attributedTitle"];
    }
    
    //修改message
    NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:message];
    [alertControllerMessageStr addAttributes:@{NSForegroundColorAttributeName:alertView.messageColor?alertView.messageColor:[UIColor blackColor]} range:NSMakeRange(0, message.length)];
   [alertView.alert setValue:alertControllerMessageStr forKey:@"attributedMessage"];
    
    return alertView;
}

-(void)show{
    [[self topViewController] presentViewController:self.alert animated:YES completion:nil];
}


-(void)alertBgAction{
    [self dissMiss];
}

-(void)dissMiss{
    if(self.alert){
        [self.alert dismissViewControllerAnimated:YES completion:nil];
        self.alert = nil;
    }
}

-(NSMutableArray<UIAlertAction *> *)actions{
    if(_actions == nil){
        _actions = [NSMutableArray arrayWithCapacity:0];
    }
    return _actions;
}


-(void)dealloc{
    if(self.alert){
        self.alert = nil;
    }
}

- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}
@end
