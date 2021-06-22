//
//  ClassReplayModel.h
//  WebClassMaster-Student
//
//  Created by 约克 on 2021/4/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClassReplayModel : NSObject
@property (nonatomic, strong)NSString *recordId;            //一次录制的的唯一标识符

@property (nonatomic, strong)NSString *roomUuid;            //课堂 uuid

@property (nonatomic, assign)int startTime;

@property (nonatomic, assign)int endTime;

@property (nonatomic, strong)NSString *resourceId;

@property (nonatomic, strong)NSString *sid;

@property (nonatomic, strong)NSString *recordUid;

@property (nonatomic, strong)NSString *boardAppId;

@property (nonatomic, strong)NSString *boardToken;

@property (nonatomic, strong)NSString *boardId;

@property (nonatomic, strong)NSString *url;

@property (nonatomic, assign)int type;

@property (nonatomic, assign)int status;
@end

NS_ASSUME_NONNULL_END
