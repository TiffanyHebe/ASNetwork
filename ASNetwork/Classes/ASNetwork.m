//
//  ASNetwork.m
//  ASNetwork
//
//  Created by 洛城 on 2025/12/18.
//

#import "ASNetwork.h"
#import "AFNetworking/AFNetworking.h"

@interface ASNetwork()

@end


@implementation ASNetwork
   
static AFHTTPSessionManager *_manager = nil;

+ (AFHTTPSessionManager *)manager{
    _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"www.baidu.com"]];
    _manager.responseSerializer.acceptableContentTypes =
    [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", @"application/x-www-form-urlencoded",@"application/javascript", nil];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    _manager.securityPolicy = securityPolicy;
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    _manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    return _manager;
}

+ (void)GET:(NSString *)URLString parameters:(id)parameters callback:(ASNetworkSuccessCallback)success failure:(ASNetworkFailure)failure{
    [_manager GET:URLString parameters:parameters headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            int code = 0;
            NSString *desc;
            ASNETWORKBLOCK_SAFE_RUN(success,responseObject,code,desc);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            ASNETWORKBLOCK_SAFE_RUN(failure,error);
    }];
}

@end
