# Android App Sleep Prevention Tools

## Purpose

This collection of scripts was initially created to address aggressive app sleeping behavior observed on the **TCL 50 PRO NXTPAPER**. However, the tools might also be beneficial for other Android devices experiencing similar issues where background apps are closed too quickly.

## Prerequisites

Before using these scripts, ensure the following:

1.  **Developer Mode Activated:** Enable Developer Options on your Android device. This process varies slightly by manufacturer, but usually involves tapping the "Build number" in `Settings > About phone` multiple times.
2.  **USB Debugging Enabled:** Inside Developer Options, enable the "USB debugging" setting.
3.  **ADB Installed:** You need the Android Debug Bridge (ADB) installed on your computer. You can download it as part of the [Android SDK Platform Tools](https://developer.android.com/tools/releases/platform-tools).
4.  **Device Connection Verified:** Connect your phone to your computer via USB. Open a terminal or command prompt and run `adb devices`. Your device should be listed, possibly after authorizing the connection on your phone screen.

## Usage Instructions

1.  **List Installed Apps:**
    *   Run the `list_installed_apps.bat` script.
    *   This will generate a file named `installed_apps.txt` containing the package IDs of all installed applications (e.g., `com.example.app`).

2.  **Configure Apps to Keep Awake:**
    *   Open the `disable_sleep_for_my_apps.bat` file in a text editor.
    *   Identify the package IDs of the apps you want to prevent from sleeping in the `installed_apps.txt` list.
    *   For each app you want to add, insert a new line in the format: `call inc\inc_disable_sleep.bat <package_id>` (replace `<package_id>` with the actual ID from `installed_apps.txt`).
    *   You can also remove lines for apps you no longer want to exempt.

3.  **Apply App-Specific Settings:**
    *   Run the `disable_sleep_for_my_apps.bat` script. This will execute ADB commands to exempt the specified apps from battery optimization.

4.  **Apply General Settings:**
    *   Run the `general_android_settings_to_prevent_sleep.bat` script. This applies broader system settings that can help reduce aggressive app closing.

5.  **List Accessibility Services:**
    *   Run the `get_accessibility_services_apps.bat` script.
    *   This will generate a file named `accessibility_services_apps.txt` containing all currently enabled accessibility services on your device.

6.  **Add Accessibility Service:**
    *   To enable an accessibility service for a specific app, run: `add_accessibility_service.bat <package/service_class:com>`
    *   Example: `add_accessibility_service.bat com.example.myapp/com.example.myapp.MyAccessibilityService:com`
    *   The script will check if the service is already enabled and add it to the enabled services list if not.

---

*Disclaimer: Use these scripts at your own risk. Modifying system settings can have unintended consequences.*
