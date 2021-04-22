//
//  ClassroomModel.h
//  网课通教师版
//
//  Created by 约克 on 2021/3/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RoomInfo :NSObject
//房间名称，用于显示
@property (nonatomic , copy) NSString               * roomName;
//房间 uuid，这是房间的唯一标识符，也是加入 RTC 和 RTM 的频道名
@property (nonatomic , copy) NSString               * roomUuid;

@end


@interface MuteChat :NSObject
//是否禁止观众进行文字聊天
@property (nonatomic , assign) NSInteger              audience;
//是否禁止主播进行文字聊天
@property (nonatomic , assign) NSInteger              host;

@end


@interface MuteAudio :NSObject
//是否禁止观众发送语音
@property (nonatomic , assign) NSInteger              audience;
//是否禁止主播发送语音
@property (nonatomic , assign) NSInteger              host;

@end


@interface MuteVideo :NSObject
//是否禁止主播发送视频
@property (nonatomic , assign) NSInteger              host;

@end


@interface RoomState :NSObject
//房间当前状态: 0: 未开始 1: 进行中 2: 已结束，新用户无法进入
@property (nonatomic , assign) NSInteger              state;
//房间开始时间，UTC 时间戳（毫秒）。房间开始后此字段有值
@property (nonatomic , assign) NSInteger              startTime;
//是否禁止文字聊天
@property (nonatomic , strong) MuteChat             * muteChat;
//是否禁止语音
@property (nonatomic , strong) MuteAudio            * muteAudio;
//是否禁止发送视频
@property (nonatomic , strong) MuteVideo            * muteVideo;

@end


@interface RoomProperties :NSObject

@end


@interface Room :NSObject
//房间信息
@property (nonatomic , strong) RoomInfo             * roomInfo;
//房间状态
@property (nonatomic , strong) RoomState            * roomState;
//房间扩展属性，字典表结构
@property (nonatomic , strong) RoomProperties       * roomProperties;

@end


@interface UserProperties :NSObject

@end


@interface StreamsItem :NSObject
//流 uuid
@property (nonatomic , copy) NSString               * streamUuid;
//流名称，用于显示
@property (nonatomic , copy) NSString               * streamName;
//视频来源:0: 无 1: 摄像头 2: 屏幕
@property (nonatomic , assign) NSInteger              videoSourceType;
//音频来源:0: 无 1: 麦克风
@property (nonatomic , assign) NSInteger              audioSourceType;
//视频状态:0: 关闭 1: 开启
@property (nonatomic , assign) NSInteger              videoState;
//音频状态:0: 关闭 1: 开启。
@property (nonatomic , assign) NSInteger              audioState;
//流状态更新时间，UTC 时间戳（毫秒）
@property (nonatomic , assign) NSInteger              updateTime;
//流是否有效:0: 无效 1: 有效
@property (nonatomic , assign) NSInteger              state;

@end


@interface User :NSObject
//用户 uuid，用户的唯一标识符
@property (nonatomic , copy) NSString               * userUuid;
//用户名，用于显示
@property (nonatomic , copy) NSString               * userName;
//用户在房间内的角色
@property (nonatomic , copy) NSString               * role;
//用户主流 uuid
@property (nonatomic , copy) NSString               * streamUuid;
//用户 token，用于后续房间内请求
@property (nonatomic , copy) NSString               * userToken;
//用于 RTM 服务的 token
@property (nonatomic , copy) NSString               * rtmToken;
//用于 RTC 服务的 token
@property (nonatomic , copy) NSString               * rtcToken;
//此用户是否禁止文字聊天: - 0: 不禁止。 - 1: 禁止
@property (nonatomic , copy) NSString               * muteChat;
//用户扩展属性，字典表结构
@property (nonatomic , strong) UserProperties       * userProperties;
//用户的流列表
@property (nonatomic , strong) NSArray <StreamsItem *>          * streams;

@end


@interface ClassroomModel :NSObject
//房间配置
@property (nonatomic , strong) Room                 * room;
//本地用户配置
@property (nonatomic , strong) User                 * user;

@end
NS_ASSUME_NONNULL_END
