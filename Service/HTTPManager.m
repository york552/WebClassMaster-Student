//
//  HttpManager.m
//  WebClassMaster-Student
//
//  Created by 约克 on 2021/4/29.
//

#import "HTTPManager.h"

@implementation HTTPManager
+ (AFHTTPSessionManager *)sessionManager {
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    sessionManager.requestSerializer.timeoutInterval = 10;
    return sessionManager;
}

//+ (void)getClassReplayWithRoomid:(NSString *)roomUuid  success:(OnSchduleClassSuccessBlock)successBlock failure:(OnHttpFailureBlock)failureBlock {
//    AFHTTPSessionManager *sessionManager = [HTTPManager sessionManager];
//    NSString *url = [NSString stringWithFormat:@"%@/edus/apps/%@/v2/rooms/%@/records", BASE_URL, APPID, roomUuid];
//    
//    NSDictionary *headers = @{
//        @"Content-Type": @"application/json",
//        @"x-agora-token": RTMTOKEN,
//        @"x-agora-uid": @"yk2"
//    };
//}
@end
