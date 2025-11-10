@echo off
setlocal enabledelayedexpansion

SET SERVICE=%1

REM Validate input
IF "%SERVICE%"=="" (
    echo Usage: add_accessibility_service.bat package/service_class:com
    echo Example: add_accessibility_service.bat com.example.myapp/com.example.myapp.MyAccessibilityService:com
    exit /b 1
)

REM Get current list
echo Getting current accessibility services...
for /f "delims=" %%a in ('adb shell settings get secure enabled_accessibility_services') do set CURRENT_LIST=%%a

REM Check if service already exists
echo !CURRENT_LIST! | find "%SERVICE%" >nul
if %errorlevel% equ 0 (
    echo Service is already enabled.
    exit /b 0
)

REM Append service to list (with colon separator if list is not empty)
if "!CURRENT_LIST!"=="" (
    set NEW_LIST=%SERVICE%
) else (
    set NEW_LIST=!CURRENT_LIST!:%SERVICE%
)

REM Apply the setting
echo Adding accessibility service: %SERVICE%
adb shell settings put secure enabled_accessibility_services "!NEW_LIST!"

echo Service added successfully.
