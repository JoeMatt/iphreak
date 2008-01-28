INFOPLIST_FILE=Info.plist
DEFAULT_BACKGROUND=Default.png
APP_ICON=icon.png
SOURCES=\
	main.m \
	iPhreakApp.m \
	KeyPad.m \
	Key.m \
	TonePlayer.h \
	TonePlayer.m
	
#IPHONE_IP=192.168.1.80

WozBoxResources=\
	0.png \
	1.png \
	2.png \
	3.png \
	4.png \
	5.png \
	6.png \
	7.png \
	8.png \
	9.png \
	*.png \
	_.png \
	clear.png \
	blank.png
WozBoxResources_ABS := $(addprefix $(SRCROOT)/GUI/WozBox/,$(WozBoxResources))
WozBoxDir_ABS := $(SRCROOT)/GUI/WozBox/

CC=/usr/local/bin/arm-apple-darwin-gcc
CFLAGS=-g -O2 -Wall -I/usr/local/arm-apple-darwin/arm-apple-darwin/include/includes -I/usr/local/arm-apple-darwin/arm-apple-darwin/include/includes/UIKit/ -fsigned-char
LD=$(CC)
LDFLAGS=-I/usr/local/arm-apple-darwin/include -lobjc -ObjC -framework CoreFoundation -framework Foundation -framework CoreGraphics -framework GraphicsServices -framework UIKit -framework LayerKit -framework Celestial -framework CoreAudio -framework AudioToolbox
#LDFLAGS=-Wl -I/usr/local/arm-apple-darwin/include -lobjc -ObjC -framework CoreFoundation -framework Foundation -framework UIKit -framework CoreGraphics -framework GraphicsServices -framework Celestial -framework CoreAudio -framework AudioToolbox

WRAPPER_NAME=$(PRODUCT_NAME).app
EXECUTABLE_NAME=$(PRODUCT_NAME)
SOURCES_ABS=$(addprefix $(SRCROOT)/,$(SOURCES))
INFOPLIST_ABS=$(addprefix $(SRCROOT)/,$(INFOPLIST_FILE))
DEFAULT_BACKGROUND_ABS=$(addprefix $(SRCROOT)/,$(DEFAULT_BACKGROUND))
APP_ICON_ABS=$(addprefix $(SRCROOT)/,$(APP_ICON))
OBJECTS=\
	$(patsubst %.c,%.o,$(filter %.c,$(SOURCES))) \
	$(patsubst %.cc,%.o,$(filter %.cc,$(SOURCES))) \
	$(patsubst %.cpp,%.o,$(filter %.cpp,$(SOURCES))) \
	$(patsubst %.m,%.o,$(filter %.m,$(SOURCES))) \
	$(patsubst %.mm,%.o,$(filter %.mm,$(SOURCES)))
OBJECTS_ABS=$(addprefix $(CONFIGURATION_TEMP_DIR)/,$(OBJECTS))
APP_ABS=$(BUILT_PRODUCTS_DIR)/$(WRAPPER_NAME)
PRODUCT_ABS=$(APP_ABS)/$(EXECUTABLE_NAME)

all: $(PRODUCT_ABS)

$(PRODUCT_ABS): $(APP_ABS) $(OBJECTS_ABS)
	$(LD) $(LDFLAGS) -o $(PRODUCT_ABS) $(OBJECTS_ABS)
	scp -r $(APP_ABS) root@$(IPHONE_IP):/Applications
	ssh root@$(IPHONE_IP) '/var/root/bin/restart'

$(APP_ABS): $(INFOPLIST_ABS)
	mkdir -p $(APP_ABS)
	cp $(INFOPLIST_ABS) $(APP_ABS)/
	cp $(DEFAULT_BACKGROUND_ABS) $(APP_ABS)/
	cp $(APP_ICON_ABS) $(APP_ABS)/
	#$(foreach RES,$(WozBoxResources_ABS),  $(RES) $(APP_ABS)/)
	mkdir -p $(APP_ABS)/WozBox/
	cp -R $(WozBoxDir_ABS)*.png $(APP_ABS)/WozBox/
	cp $(SRCROOT)/Boxes.plist $(APP_ABS)
	
$(CONFIGURATION_TEMP_DIR)/%.o: $(SRCROOT)/%.m
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

clean:
	rm -f $(OBJECTS_ABS)
	rm -rf $(APP_ABS)
