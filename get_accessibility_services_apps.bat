@echo off
REM Delete the existing file if it exists
if exist accessibility_services_apps.txt (
    echo Deleting existing accessibility_services_apps.txt...
    del accessibility_services_apps.txt
)

REM Get the list of enabled accessibility services
echo Generating list of apps with accessibility services enabled...
adb shell settings get secure enabled_accessibility_services > accessibility_services_apps.txt

echo List saved to accessibility_services_apps.txt
