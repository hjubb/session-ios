//
//  Copyright (c) 2019 Open Whisper Systems. All rights reserved.
//

#import <SessionMessagingKit/OWSStorage.h>
#import <YapDatabase/YapDatabaseViewTransaction.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const TSInboxGroup;
extern NSString *const TSMessageRequestGroup;
extern NSString *const TSArchiveGroup;
extern NSString *const TSShareExtensionGroup;
extern NSString *const TSUnreadIncomingMessagesGroup;
extern NSString *const TSSecondaryDevicesGroup;

extern NSString *const TSThreadDatabaseViewExtensionName;
extern NSString *const TSThreadShareExtensionDatabaseViewExtensionName;

extern NSString *const TSMessageDatabaseViewExtensionName;
extern NSString *const TSMessageDatabaseViewExtensionName_Legacy;

extern NSString *const TSUnreadDatabaseViewExtensionName;
extern NSString *const TSUnseenDatabaseViewExtensionName;
extern NSString *const TSUnreadMentionDatabaseViewExtensionName;
extern NSString *const TSThreadOutgoingMessageDatabaseViewExtensionName;
extern NSString *const TSThreadSpecialMessagesDatabaseViewExtensionName;

extern NSString *const TSSecondaryDevicesDatabaseViewExtensionName;

extern NSString *const TSLazyRestoreAttachmentsGroup;
extern NSString *const TSLazyRestoreAttachmentsDatabaseViewExtensionName;

@interface TSDatabaseView : NSObject

- (instancetype)init NS_UNAVAILABLE;

#pragma mark - Views

// Returns the "unseen" database view if it is ready;
// otherwise it returns the "unread" database view.
+ (id)unseenDatabaseViewExtension:(YapDatabaseReadTransaction *)transaction;

+ (id)threadOutgoingMessageDatabaseView:(YapDatabaseReadTransaction *)transaction;

+ (id)threadSpecialMessagesDatabaseView:(YapDatabaseReadTransaction *)transaction;

#pragma mark - Registration

+ (void)registerCrossProcessNotifier:(OWSStorage *)storage;

// This method must be called _AFTER_ asyncRegisterThreadInteractionsDatabaseView.
+ (void)asyncRegisterThreadDatabaseView:(OWSStorage *)storage;

+ (void)asyncRegisterThreadInteractionsDatabaseView:(OWSStorage *)storage;
+ (void)asyncRegisterLegacyThreadInteractionsDatabaseView:(OWSStorage *)storage;

+ (void)asyncRegisterThreadOutgoingMessagesDatabaseView:(OWSStorage *)storage;

// Instances of OWSReadTracking for wasRead is NO and shouldAffectUnreadCounts is YES.
//
// Should be used for "unread message counts".
+ (void)asyncRegisterUnreadDatabaseView:(OWSStorage *)storage;

// Should be used for "unread indicator".
//
// Instances of OWSReadTracking for wasRead is NO.
+ (void)asyncRegisterUnseenDatabaseView:(OWSStorage *)storage;

// Should be used for "mention indicator".
//
// Instances of OWSReadTracking for wasRead is NO and isUserMentioned is YES.
+ (void)asyncRegisterUnreadMentionDatabaseView:(OWSStorage *)storage;

+ (void)asyncRegisterLazyRestoreAttachmentsDatabaseView:(OWSStorage *)storage;

@end

NS_ASSUME_NONNULL_END
