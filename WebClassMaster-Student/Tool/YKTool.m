//
//  YKTool.m
//  网课通教师版
//
//  Created by 约克 on 2021/3/16.
//

#import "YKTool.h"

@implementation YKTool
+ (NSString *)base64EncodedString:(NSString *)str{
    NSData *data = [str dataUsingEncoding: NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
+ (NSString*)dictionaryToJson:(NSDictionary *)dict
{
    NSError *error;

        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];

        NSString *jsonString;

        if (!jsonData) {

            NSLog(@"%@",error);

        }else{

            jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];

        }

        NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];

        NSRange range = {0,jsonString.length};

        //去掉字符串中的空格

        [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];

        NSRange range2 = {0,mutStr.length};

        //去掉字符串中的换行符

        [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];

        return mutStr;
}
@end
