//
//  RNCZNativeToast.m
//  Pods
//
//  Created by 杨硕 on 2019/9/11.
//

#import "RNCZNativeToast.h"

//背景透明度
static CGFloat kMCToastViewAlpha;

//Toast消失的时间
static CGFloat kMCToastViewDuring;

//Toast文字字体大小
static CGFloat kMCToastViewFont;
static CGFloat kMCToastViewLeftSpace;
static CGFloat kMCToastViewTopSpace;

//Toast图片和文字的间隙
static CGFloat KMCToastViewBottomSpace;

//是否带完成的Block回调
static BOOL isHavaBlock;

@interface RNCZNativeToast()
/**
 *  文字上方的图片
 */
@property (nonatomic, strong) UIImageView * titleImage;

/**
 *  文字文本
 */
@property (nonatomic, strong) UILabel * titleLabel;

/**
 *  文字的位置类型
 */
@property (nonatomic, assign) RNCZNativeToastType type;

/**
 *  定时器
 */
@property (nonatomic, strong) NSTimer * showTimer;
@end

@implementation RNCZNativeToast

+(instancetype)shareManager
{
    static RNCZNativeToast * custom = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        custom = [[RNCZNativeToast alloc] init];
        UIWindow * window = [self getMainWindow];
        custom.frame = window.bounds;
        [window addSubview:custom];
        custom.hidden = YES;
    });
    return custom;
}


+(UIWindow *)getMainWindow
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    if (!window)
    {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    return window;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initFrameParameters];
        
        self.bgView.alpha = kMCToastViewAlpha;
        
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = [UIColor grayColor];
        self.bgView.layer.cornerRadius = 5.0f;
        self.bgView.layer.masksToBounds = YES;
        [self addSubview:self.bgView];
        
        self.isFinished = YES;
        
        
        
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:kMCToastViewFont];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        [self.bgView addSubview:_titleLabel];
        
        
        self.titleImage = [[UIImageView alloc] init];
        [self.bgView addSubview:self.titleImage];
        
        
    }
    return self;
}

-(void)initFrameParameters
{
    kMCToastViewAlpha = 0.8f;
    kMCToastViewDuring = 2.0f;
    kMCToastViewFont = 15.0f;
    kMCToastViewLeftSpace = 10.0f;
    kMCToastViewTopSpace = 10.0f;
    KMCToastViewBottomSpace = 60.0f;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

-(void)showToastType:(RNCZNativeToastShowType)type text:(NSString *)text time:(CGFloat)time
{
    isHavaBlock = NO;
    _type = type;
    kMCToastViewDuring = time;
    
    [self changeSubViewsFrameAndAnimation:text];
}

/**
 @brief 获取文本的宽高
 @param font 字体
 */
+(CGSize)getTextActualSizeText:(NSString *)text font:(UIFont *)font
{
    
    //获取每一行的高度
    CGSize lineSize = [self getLineSizeText:text font:font];
    CGSize allSize = [self getAllSizeText:text font:font lines:0 maxWidth:[UIScreen mainScreen].bounds.size.width];
    lineSize = CGSizeMake((int)ceilf(lineSize.width), (int)ceilf(lineSize.height));
    allSize = CGSizeMake((int)ceilf(allSize.width), (int)ceilf(allSize.height));
    return [self getActualSize:lineSize allSize:allSize lines:0 maxWidth:[UIScreen mainScreen].bounds.size.width];
}

+(CGSize)getLineSizeText:(NSString *)text font:(UIFont *)font
{
    return [text sizeWithAttributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName]];
}

+(CGSize)getAllSizeText:(NSString *)text font:(UIFont *)font lines:(NSInteger)lines maxWidth:(CGFloat)maxWidth
{
    return [text boundingRectWithSize:CGSizeMake(maxWidth, 100000) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil].size;
}

+(CGSize)getActualSize:(CGSize)lineSize allSize:(CGSize)allSize lines:(NSInteger)lines maxWidth:(CGFloat)maxWidth
{
    if (allSize.width <= 0) {
        return CGSizeZero;
    } else {
        if (lines == 0) {
            return CGSizeMake(allSize.width < maxWidth ? allSize.width : maxWidth, allSize.height);
        } else {
            //实际行数
            NSInteger realLines = ceil((double)allSize.height/lineSize.height);
            return CGSizeMake(allSize.width < maxWidth ? allSize.width : maxWidth, (realLines > lines ? lines : realLines) * lineSize.height);
        }
    }
}

-(void)changeSubViewsFrameAndAnimation:(NSString *)toastString
{
    if (toastString == nil)
    {
        toastString = @"";
    }
    
    if ([self.showTimer isValid])
    {
        [self stopToastView];
        [self.showTimer invalidate];
    }
    self.hidden = NO;
    
    _titleLabel.text = toastString;
    _titleLabel.hidden = NO;
    _titleImage.hidden = YES;
    
    
    CGSize textSize = [RNCZNativeToast getTextActualSizeText:toastString font:_titleLabel.font];
    CGFloat SCREENW = [UIScreen mainScreen].bounds.size.width;
    CGFloat SCREENH = [UIScreen mainScreen].bounds.size.height;
    switch (_type) {
        case RNCZNativeToastShowTypeBottom:
        {
            _titleLabel.frame = CGRectMake(kMCToastViewLeftSpace, kMCToastViewTopSpace, textSize.width, textSize.height);
            self.frame = CGRectMake((SCREENW - textSize.width - kMCToastViewLeftSpace*2)/2, (SCREENH - KMCToastViewBottomSpace - textSize.height - kMCToastViewTopSpace*2), textSize.width + kMCToastViewLeftSpace*2, textSize.height + kMCToastViewTopSpace*2);
            break;
        }
        case RNCZNativeToastShowTypeCenter:
        {
            _titleLabel.frame = CGRectMake(kMCToastViewLeftSpace, kMCToastViewTopSpace, textSize.width, textSize.height);
            self.frame = CGRectMake((SCREENW - textSize.width - kMCToastViewLeftSpace*2)/2, (SCREENH - KMCToastViewBottomSpace - textSize.height - kMCToastViewTopSpace*2)/2, textSize.width + kMCToastViewLeftSpace*2, textSize.height + kMCToastViewTopSpace*2);
            break;
        }
        case RNCZNativeToastShowTypeTop:
        {
            _titleLabel.frame = CGRectMake(kMCToastViewLeftSpace, kMCToastViewTopSpace, textSize.width, textSize.height);
            self.frame = CGRectMake((SCREENW - textSize.width - kMCToastViewLeftSpace*2)/2, 78, textSize.width + kMCToastViewLeftSpace*2, textSize.height + kMCToastViewTopSpace*2);
            break;
        }
        default: {
            break;
        }
    }
    self.bgView.frame = self.bounds;
    
    dispatch_time_t toastDelay = dispatch_time(DISPATCH_TIME_NOW, kMCToastViewDuring * NSEC_PER_SEC);
    dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_after(toastDelay, currentQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self stopToastView];
        });
    });
    
    [self.showTimer invalidate];
    self.showTimer = nil;
    self.showTimer = [NSTimer scheduledTimerWithTimeInterval:kMCToastViewDuring target:self selector:@selector(stopToastView) userInfo:nil repeats:NO];
}

-(void)stopToastView
{
    self.hidden = YES;
}
@end
