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

-(instancetype)init
{
    if (self = [super init]) {
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = [UIColor grayColor];
        self.bgView.layer.cornerRadius = 5.0f;
        self.bgView.layer.masksToBounds = YES;
        [self addSubview:self.bgView];
        
        self.isFinished = YES;
    }
    return self;
}

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
        
        
        
        self.titleLabel = [[HHZLabel alloc] init];
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


- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

-(void)showToastType:(HHZToastViewShowType)type text:(NSString *)text time:(CGFloat)time
{
    isHavaBlock = NO;
    _type = type;
    kMCToastViewDuring = time;
    
    [self changeSubViewsFrameAndAnimation:text];
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
    switch (_type) {
        case HHZToastViewShowTypeBottom:
        {
            _titleLabel.frame = CGRectMake(kMCToastViewLeftSpace, kMCToastViewTopSpace, _titleLabel.width, _titleLabel.height);
            self.frame = CGRectMake((SCREENW - _titleLabel.width - kMCToastViewLeftSpace*2)/2, (SCREENH - KMCToastViewBottomSpace - _titleLabel.height - kMCToastViewTopSpace*2), _titleLabel.width + kMCToastViewLeftSpace*2, _titleLabel.height + kMCToastViewTopSpace*2);
            break;
        }
        case HHZToastViewShowTypeCenter:
        {
            _titleLabel.frame = CGRectMake(kMCToastViewLeftSpace, kMCToastViewTopSpace, _titleLabel.width, _titleLabel.height);
            self.frame = CGRectMake((SCREENW - _titleLabel.width - kMCToastViewLeftSpace*2)/2, (SCREENH - _titleLabel.height - kMCToastViewTopSpace*2)/2, _titleLabel.width + kMCToastViewLeftSpace*2, _titleLabel.height + kMCToastViewTopSpace*2);
            break;
        }
        case HHZToastViewShowTypeImageCenter:
        {
            _titleImage.hidden = NO;
            if (toastString == nil)
            {
                _titleLabel.hidden = YES;
                _titleImage.frame = CGRectMake(kMCToastViewLeftSpace, kMCToastViewTopSpace, _titleImage.image.size.width, _titleImage.image.size.height);
                self.frame = CGRectMake((SCREENW - _titleImage.width - kMCToastViewLeftSpace*2)/2, (SCREENH - _titleImage.height - kMCToastViewTopSpace*2)/2, _titleImage.width + kMCToastViewLeftSpace*2, _titleImage.height + kMCToastViewTopSpace*2);
            }
            else
            {
                if (_titleLabel.width >= _titleImage.image.size.width)
                {
                    _titleImage.frame = CGRectMake((_titleLabel.width + kMCToastViewLeftSpace*2 - _titleImage.image.size.width)/2, kMCToastViewTopSpace, _titleImage.image.size.width, _titleImage.image.size.height);
                    _titleLabel.frame = CGRectMake(kMCToastViewLeftSpace, _titleImage.y + _titleImage.height + kMCToastViewTopSpace, _titleLabel.width, _titleLabel.height);
                    self.frame = CGRectMake((SCREENW - _titleLabel.width - kMCToastViewLeftSpace*2)/2, (SCREENH - _titleLabel.y - _titleLabel.height - kMCToastViewTopSpace)/2, _titleLabel.width + kMCToastViewLeftSpace*2,_titleLabel.y + _titleLabel.height + kMCToastViewTopSpace);
                }
                else
                {
                    _titleImage.frame = CGRectMake(kMCToastViewLeftSpace, kMCToastViewTopSpace, _titleImage.image.size.width, _titleImage.image.size.height);
                    _titleLabel.frame = CGRectMake((_titleImage.width + kMCToastViewLeftSpace*2 - _titleLabel.width)/2, _titleImage.y + _titleImage.height + kMCToastViewTopSpace, _titleLabel.width, _titleLabel.height);
                    self.frame = CGRectMake((SCREENW - _titleImage.width - kMCToastViewLeftSpace*2)/2, (SCREENH - _titleLabel.y - _titleLabel.height - kMCToastViewTopSpace)/2, _titleImage.width + kMCToastViewLeftSpace*2, _titleLabel.y + _titleLabel.height + kMCToastViewTopSpace);
                    
                }
            }
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
    if (isHavaBlock)
    {
        if (_toastBlock)
        {
            _toastBlock();
        }
    }
    self.hidden = YES;
}
@end
