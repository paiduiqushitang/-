#import <UIKit/UIKit.h>

/** UITabBar的高度 */
CGFloat const XMGTabBarH = 49;

/** 导航栏的最大Y值 */
CGFloat const XMGNavMaxY = 64;

/** 标题栏的高度 */
CGFloat const XMGTitlesViewH = 35;

/** 全局统一的间距 */
CGFloat const XMGMarin = 10;

/** 统一的一个请求路径 */
NSString  * const XMGCommonURL = @"http://api.budejie.com/api/api_open.php";

/** TabBarButton被重复点击的通知 */
NSString  * const XMGTabBarButtonDidRepeatClickNotification = @"XMGTabBarButtonDidRepeatClickNotification";

/** TitleButton被重复点击的通知 */
NSString  * const XMGTitleButtonDidRepeatClickNotification = @"XMGTitleButtonDidRepeatClickNotification";