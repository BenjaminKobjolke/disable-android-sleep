@echo off
SET APP=%1

IF "%APP%"=="" (
    echo Usage: disable_sleep.bat com.example.app
    exit /b
)

echo Disabling Doze Mode for %APP%...
adb shell dumpsys deviceidle disable

echo Forcing full idle...
adb shell dumpsys deviceidle force-idle

echo Stepping through idle phases...
adb shell dumpsys deviceidle step

echo Unforcing idle...
adb shell dumpsys deviceidle unforce

echo Resetting battery status...
adb shell dumpsys battery reset

echo Setting app as active...
adb shell am set-inactive %APP% false

echo Forcing app into standby...
adb shell am set-inactive %APP% true

echo Reactivating app...
adb shell am set-inactive %APP% false

echo Checking inactive state...
adb shell am get-inactive %APP%

echo Allowing app to run in background...
adb shell cmd appops set %APP% RUN_IN_BACKGROUND allow
adb shell cmd appops set %APP% RUN_ANY_IN_BACKGROUND allow
adb shell cmd appops set %APP% WAKE_LOCK allow :contentReference[oaicite:0]{index=0}

echo Disabling battery optimization via intent...
adb shell am broadcast -a android.intent.action.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS -d package:%APP% :contentReference[oaicite:1]{index=1}

echo Whitelisting app in Doze...
adb shell dumpsys deviceidle whitelist +%APP% 

echo Disabling system Doze settings...
adb shell settings put secure doze_enabled 0
adb shell device_config put device_idle doze_enabled false :contentReference[oaicite:3]{index=3}

echo Disabling low power mode...
adb shell settings put global low_power 0
adb shell settings put global low_power_trigger_level 0 :contentReference[oaicite:4]{index=4}

echo Preventing background freezing...
adb shell settings put global app_standby_enabled 0
adb shell settings put global adaptive_battery_management_enabled 0
adb shell settings put global adaptive_sleep 1

echo Setting standby bucket to 'active'...
adb shell cmd activity set-standby-bucket %APP% active

echo Checking standby bucket status...
adb shell cmd activity get-standby-bucket %APP%

echo Process completed for %APP%.
