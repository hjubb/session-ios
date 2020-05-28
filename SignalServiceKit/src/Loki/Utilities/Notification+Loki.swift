
public extension Notification.Name {

    // State changes
    public static let contactOnlineStatusChanged = Notification.Name("contactOnlineStatusChanged")
    public static let userFriendRequestStatusChanged = Notification.Name("userFriendRequestStatusChanged")
    public static let groupThreadUpdated = Notification.Name("groupThreadUpdated")
    public static let messageFriendRequestStatusChanged = Notification.Name("messageFriendRequestStatusChanged")
    public static let threadDeleted = Notification.Name("threadDeleted")
    public static let threadSessionRestoreDevicesChanged = Notification.Name("threadSessionRestoreDevicesChanged")
    // Message status changes
    public static let calculatingPoW = Notification.Name("calculatingPoW")
    public static let routing = Notification.Name("routing")
    public static let messageSending = Notification.Name("messageSending")
    public static let messageSent = Notification.Name("messageSent")
    public static let messageFailed = Notification.Name("messageFailed")
    // Onboarding
    public static let seedViewed = Notification.Name("seedViewed")
    // Interaction
    public static let dataNukeRequested = Notification.Name("dataNukeRequested")
    // Device linking
    public static let unexpectedDeviceLinkRequestReceived = Notification.Name("unexpectedDeviceLinkRequestReceived")
    // Onion requests
    public static let buildingPaths = Notification.Name("buildingPaths")
    public static let pathsBuilt = Notification.Name("pathsBuilt")
}

@objc public extension NSNotification {

    // State changes
    @objc public static let contactOnlineStatusChanged = Notification.Name.contactOnlineStatusChanged.rawValue as NSString
    @objc public static let userFriendRequestStatusChanged = Notification.Name.userFriendRequestStatusChanged.rawValue as NSString
    @objc public static let groupThreadUpdated = Notification.Name.groupThreadUpdated.rawValue as NSString
    @objc public static let messageFriendRequestStatusChanged = Notification.Name.messageFriendRequestStatusChanged.rawValue as NSString
    @objc public static let threadDeleted = Notification.Name.threadDeleted.rawValue as NSString
    @objc public static let threadSessionRestoreDevicesChanged = Notification.Name.threadSessionRestoreDevicesChanged.rawValue as NSString
    // Message statuses
    @objc public static let calculatingPoW = Notification.Name.calculatingPoW.rawValue as NSString
    @objc public static let routing = Notification.Name.routing.rawValue as NSString
    @objc public static let messageSending = Notification.Name.messageSending.rawValue as NSString
    @objc public static let messageSent = Notification.Name.messageSent.rawValue as NSString
    @objc public static let messageFailed = Notification.Name.messageFailed.rawValue as NSString
    // Onboarding
    @objc public static let seedViewed = Notification.Name.seedViewed.rawValue as NSString
    // Interaction
    @objc public static let dataNukeRequested = Notification.Name.dataNukeRequested.rawValue as NSString
    // Device linking
    @objc public static let unexpectedDeviceLinkRequestReceived = Notification.Name.unexpectedDeviceLinkRequestReceived.rawValue as NSString
    // Onion requests
    @objc public static let buildingPaths = Notification.Name.buildingPaths.rawValue as NSString
    @objc public static let pathsBuilt = Notification.Name.pathsBuilt.rawValue as NSString
}
