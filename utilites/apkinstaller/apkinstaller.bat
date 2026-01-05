@echo off
chcp 65001 >nul
cls

echo ==========================================
echo         Quest APK Installer
echo ==========================================
echo.
echo ==========================================
echo     Проверка подключённого шлема
echo ==========================================

set "script_dir=%~dp0"
set "root_dir=%script_dir%..\..\"
set "adb_path=%root_dir%driver\adb.exe"

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

setlocal EnableDelayedExpansion
set "apk_dir=%script_dir%"

dir "%apk_dir%*.apk" /b /a-d > "%temp%\apk_list.tmp" 2>nul

set count=0
for /f "delims=" %%F in (%temp%\apk_list.tmp) do (
    set /a count+=1
    set "apk[!count!]=%%F"
)

if %count%==0 (
    echo В текущей папке не найдено ни одного .apk файла.
    echo Поместите APK-файлы в эту же папку и запустите скрипт снова.
    del "%temp%\apk_list.tmp" 2>nul
    echo.
    pause
    exit /b
)

echo Найдено APK-файлов: %count%
echo.
echo Выберите файл для установки:
echo.

for /l %%i in (1,1,%count%) do (
    echo   %%i - !apk[%%i]!
)

echo.
set /p choice=Введите номер (1-%count%): 

if "%choice%"=="" (
    echo Ошибка: ничего не введено.
    goto end
)
echo %choice%| findstr /r "^[1-9][0-9]*$" >nul || (
    echo Ошибка: введите только число от 1 до %count%.
    goto end
)
if %choice% GTR %count% (
    echo Ошибка: число слишком большое. Максимум — %count%.
    goto end
)
if %choice% LSS 1 (
    echo Ошибка: число должно быть не меньше 1.
    goto end
)

set "selected_apk=!apk[%choice%]!"

echo.
echo Выбран файл: %selected_apk%
echo.
echo Установка APK...
"%adb_path%" install -r "%apk_dir%%selected_apk%"

if %errorlevel%==0 (
    echo.
    echo Готово! Установка прошла успешно (Success).
) else (
    echo.
    echo Ошибка при установке. Проверьте подключение и статус устройства.
)

:end
del "%temp%\apk_list.tmp" 2>nul
echo.
pause
endlocal