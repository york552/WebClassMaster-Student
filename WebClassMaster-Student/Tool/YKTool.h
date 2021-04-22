//
//  YKTool.h
//  网课通教师版
//
//  Created by 约克 on 2021/3/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YKTool : NSObject
+ (NSString *)base64EncodedString:(NSString *)str;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
