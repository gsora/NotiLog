TARGET := iphone:clang:9.2

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NotiLog
NotiLog_FILES = Tweak.xm
NotiLog_PRIVATEFRAMEWORKS = BulletinBoard

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += notilog
include $(THEOS_MAKE_PATH)/aggregate.mk
