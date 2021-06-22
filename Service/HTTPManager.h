//
//  HttpManager.h
//  WebClassMaster-Student
//
//  Created by 约克 on 2021/4/29.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "ClassReplayModel.h"

#define BASE_URL @"https://api.agora.io"
#define APPID @"7299681c2f0241299b87edbb6ed63750"
#define KEY @"c8a6969c773a4c7bbe6af53b51f64090"
#define SECRET @"7ef1a3ed53574005a72d8df4bbd32342"
#define RTMTOKEN @"0067299681c2f0241299b87edbb6ed63750IADYhow5JuiXnq30TFFuaYa6PcM9Ga+6pEZFaHzRECzYBCFpv+oAAAAAEABtZO8cd83QYAEA6AN3zdBg"

NS_ASSUME_NONNULL_BEGIN

//请求失败的回调
typedef void(^OnHttpFailureBlock)(NSError * _Nonnull error, NSInteger statusCode);
//创建房间的回调
//typedef void(^OnSchduleClassSuccessBlock)(ClassReplayModel * _Nonnull classReplayModel);

@interface HTTPManager : NSObject
//+ (void)getClassReplayWithRoomid:(NSString *)roomUuid  success:(OnSchduleClassSuccessBlock)successBlock failure:(OnHttpFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
