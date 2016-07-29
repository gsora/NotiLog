include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = notilog_prefs
notilog_prefs_FILES = gsrRootListController.m
notilog_prefs_INSTALL_PATH = /Library/PreferenceBundles
notilog_prefs_FRAMEWORKS = UIKit
notilog_prefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/notilog_prefs.plist$(ECHO_END)
