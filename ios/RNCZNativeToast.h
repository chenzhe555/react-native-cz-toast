//
//  RNCZNativeToast.h
//  Pods
//
//  Created by 杨硕 on 2019/9/11.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RNCZNativeToastType){
    RNCZNativeToastTypeOnlyOnce,
    RNCZNativeToastTypeAlways
};

NS_ASSUME_NONNULL_BEGIN

@interface RNCZNativeToast : NSObject
/**
 *  放置控件的View
 */
@property (nonatomic, strong) UIView * bgView;

/**
 *  动画是否完成
 */
@property (nonatomic, assign) BOOL isFinished;
/**
 *  暂存的数据
 */
@property (nonatomic, strong) NSMutableArray * dataArray;

/**
 *  显示Alert的类型
 */
@property (nonatomic, assign) RNCZNativeToastType showAlertType;


/**
 *  获取AlertView实例
 *
 */
+(instancetype)shareManager;

/**
 *  显示Alert视图
 */
-(void)showAlertView;


-(void)showToastType:(RNCZNativeToastType)type text:(NSString *)text time:(CGFloat)time;
@end

NS_ASSUME_NONNULL_END
