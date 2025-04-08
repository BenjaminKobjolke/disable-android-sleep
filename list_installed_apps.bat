@echo off
REM Delete the existing file if it exists
if exist installed_apps.txt (
    echo Deleting existing installed_apps.txt...
    del installed_apps.txt
)

REM Get the list of packages and process each line
echo Generating list of installed apps...
for /f "tokens=2 delims=:" %%a in ('adb shell cmd package list packages') do (
    echo %%a >> installed_apps.txt
)

echo List saved to installed_apps.txt
