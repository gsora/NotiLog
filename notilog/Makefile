include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = notilog
notilog_FILES = GSRRootListController.m
notilog_INSTALL_PATH = /Library/PreferenceBundles
notilog_FRAMEWORKS = UIKit
notilog_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/notilog.plist$(ECHO_END)
