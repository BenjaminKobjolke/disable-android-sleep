@echo off
SET APP=%1

IF "%APP%"=="" (
    echo Usage: disable_sleep.bat com.example.app
    exit /b
)

echo Disabling Doze Mode for %APP%...
adb shell dumpsys deviceidle disable

echo Setting app as active...
adb shell am set-inactive %APP% false

echo Allowing app to run in background...
adb shell cmd appops set %APP% RUN_ANY_IN_BACKGROUND allow
adb shell cmd appops set %APP% WAKE_LOCK allow
adb shell settings put global app_standby_enabled 0

echo Checking battery optimization status...
adb shell dumpsys deviceidle
adb shell dumpsys battery

echo Disabling battery optimization via intent...
adb shell am broadcast -a android.intent.action.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS -d package:%APP%

echo Forcing the app to stay active...
adb shell am set-inactive %APP% false

echo Checking inactive state...
adb shell am get-inactive %APP%

echo Setting standby bucket to 'active'...
adb shell cmd appops set %APP% RUN_ANY_IN_BACKGROUND allow
adb shell cmd activity set-standby-bucket %APP% active

echo Checking standby bucket status...
adb shell cmd activity get-standby-bucket %APP%

echo Preventing background freezing...
adb shell dumpsys deviceidle whitelist +%APP%
adb shell settings put global adaptive_battery_management_enabled 0
adb shell settings put global adaptive_sleep 1

echo Process completed for %APP%.
