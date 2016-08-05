include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = notilog_viewer
notilog_viewer_FILES = main.m GSAppDelegate.m GSRootViewController.m
notilog_viewer_FRAMEWORKS = UIKit CoreGraphics

include $(THEOS_MAKE_PATH)/application.mk

after-install::
	install.exec "killall \"notilog_viewer\"" || true
