#import "RNCzToast.h"

#if __has_include("HHZToastView.h")
#import "HHZToastView.h"
#else
#import <HHZAlert/HHZToastView.h>
#endif

@implementation RNCzToast

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()
RCT_EXPORT_METHOD(showToastWithType:(NSInteger)type text:(NSString *)text time:(CGFloat)time)
{
  dispatch_async(dispatch_get_main_queue(), ^{
    [[HHZToastView shareManager] showToastType:type text:text time:time];
  });
}
@end
  
