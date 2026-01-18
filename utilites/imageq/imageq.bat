@echo off
chcp 65001 >nul
cls

echo ==========================================
echo                imageq
echo ==========================================

set "script_dir=%~dp0"
set "root_dir=%script_dir%..\..\"
set "adb_path=%root_dir%driver\adb.exe"
set "scrcpy_path=%root_dir%driver\scrcpy.exe"

if not exist "%scrcpy_path%" (
    echo ОШИБКА: Не найден scrcpy.exe по пути:
    echo %scrcpy_path%
    echo Убедитесь, что файл scrcpy.exe находится в папке driver в корне Quest Tools.
    echo.
    pause
    exit /b 1
)

if not exist "%adb_path%" (
    echo ОШИБКА: Не найден adb.exe по пути:
    echo %adb_path%
    echo Убедитесь, что файл adb.exe находится в папке driver в корне Quest Tools.
    echo.
    pause
    exit /b 1
)  

"%adb_path%" devices -l
echo.
echo Если устройство отображается как "device" и модель Meta Quest — всё ок.
echo.
echo ==========================================
echo       Поиск APK-файлов в папке
echo ==========================================

"%scrcpy_path%"

pause
