//
//  RNCZNativeToast.h
//  Pods
//
//  Created by 杨硕 on 2019/9/11.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RNCZNativeToastType){
    RNCZNativeToastTypeOnlyOnce,
    RNCZNativeToastTypeAlways
};

typedef NS_ENUM(NSUInteger, RNCZNativeToastShowType) {
    RNCZNativeToastShowTypeBottom = 1001,
    RNCZNativeToastShowTypeCenter = 1002,
    RNCZNativeToastShowTypeTop = 1003,
};


NS_ASSUME_NONNULL_BEGIN

// TODO: 先直接复制代码放这，有时间换掉
@interface RNCZNativeToast : UIView
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


-(void)showToastType:(RNCZNativeToastShowType)type text:(NSString *)text time:(CGFloat)time;
@end

NS_ASSUME_NONNULL_END
