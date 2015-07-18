#!/bin/bash
APP_NAME="Clipboard Paste.app"
INFO_PLIST="$APP_NAME/Contents/Info.plist"
MAJOR_MAC_VERSION=$(sw_vers -productVersion | awk -F '.' '{print $1}')
MINOR_MAC_VERSION=$(sw_vers -productVersion | awk -F '.' '{print $2}')

if [ -f "$APP_NAME" ]; then
    rm -rf "$APP_NAME"
fi

osacompile -o "$APP_NAME" -x "main.scpt"

# If Mac Version is greater or equal then 10.8, set LSUIElement, else set NSUIElement
[ $MAJOR_MAC_VERSION -gt "9" -a $MINOR_MAC_VERSION -gt "7" ] && /usr/libexec/PlistBuddy -c "Add LSUIElement String 1" "$INFO_PLIST" || /usr/libexec/PlistBuddy -c "Add NSUIElement String 1" "$INFO_PLIST"
/usr/libexec/PlistBuddy -c "Set CFBundleIconFile icon" "$INFO_PLIST"
/usr/libexec/PlistBuddy -c "Add CFBundleVersion String 1" "$INFO_PLIST"
/usr/libexec/PlistBuddy -c "Add CFBundleShortVersionString String 0.1" "$INFO_PLIST"
/usr/libexec/PlistBuddy -c "Add NSHumanReadableCopyright String '© 2015 Philipp Weber'" "$INFO_PLIST"

rm -f "$APP_NAME/Contents/Resources/applet.icns"
cp "icon.icns" "$APP_NAME/Contents/Resources/"

if [ -f "Clipboard_Paste.zip" ]; then
    rm -r "Clipboard_Paste.zip"
fi

#zip -r "Clipboard_Paste.zip" "Clipboard Paste.app"
