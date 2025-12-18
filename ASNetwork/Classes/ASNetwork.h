//
//  ASNetwork.h
//  ASNetwork
//
//  Created by 洛城 on 2025/12/18.
//

#import <Foundation/Foundation.h>
#define ASNETWORKBLOCK_SAFE_RUN(block, ...) \
if(block){ \
if([NSThread isMainThread]){ \
block(__VA_ARGS__); \
} \
else{ \
dispatch_async(dispatch_get_main_queue(), ^{ \
block(__VA_ARGS__); \
}); \
} \
}

NS_ASSUME_NONNULL_BEGIN
typedef void (^ASNetworkSuccess)(id responseObject);
typedef void (^ASNetworkFailure)(NSError *error);
typedef void (^ASNetworkSuccessCallback)(id responseObject,int code,NSString *desc);

@interface ASNetwork : NSObject
/// GET请求
/// - Parameters:
///   - URLString: URL地址
///   - parameters: 请求参数
///   - success: 成功回调(代表网络请求是成功的/有可能业务异常)
///   - failure: 失败回调(网络异常)
+ (void)GET:(NSString *)URLString
        parameters:(nullable id)parameters
        callback:(ASNetworkSuccessCallback)success
        failure:(ASNetworkFailure)failure;
@end

NS_ASSUME_NONNULL_END
