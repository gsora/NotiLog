TARGET := iphone:clang:9.2

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NotiLog
NotiLog_FILES = Tweak.xm Notification.m Db.m
NotiLog_PRIVATEFRAMEWORKS = BulletinBoard
NotiLog_LDFLAGS=-lsqlite3

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += notilog
SUBPROJECTS += notilog_viewer
include $(THEOS_MAKE_PATH)/aggregate.mk
