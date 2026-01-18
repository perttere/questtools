@echo off
chcp 65001 >nul
cls

:menu
echo.
echo ==========================================
echo              Quest Tools (beta)             
echo github.com/perttere/questtools
echo ==========================================
echo.
echo Выберите утилиту:
echo.
echo 1) APK Installer
echo 2) Imageq (Вывод экрана Quest)
echo.
set /p choice=Введите номер и нажмите Enter: 

if "%choice%"=="1" goto apkinstaller
if "%choice%"=="2" goto imageq
echo Неверный выбор. Попробуйте снова.
echo.
pause
goto menu

:apkinstaller
if exist "utilites\apkinstaller\apkinstaller.bat" (
    call "utilites\apkinstaller\apkinstaller.bat"
) else (
    echo Ошибка: Файл utilites\apkinstaller\apkinstaller.bat не найден!
    pause
)
goto menu

:imageq
if exist "utilites\imageq\imageq.bat" (
    call "utilites\imageq\imageq.bat"
) else (
    echo Ошибка: Файл utilites\apkinstaller\imageq.bat не найден!
    pause
)

goto menu
