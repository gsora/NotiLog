TARGET := iphone:9.2:8.4
ARCHS := armv7 arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NotiLog
NotiLog_FILES = Tweak.xm
NotiLog_PRIVATEFRAMEWORKS = BulletinBoard

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += notilog_prefs
include $(THEOS_MAKE_PATH)/aggregate.mk
