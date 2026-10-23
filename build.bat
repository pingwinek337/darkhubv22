@echo off
chcp 65001 >nul
title DarkHUD - budowanie moda
cd /d "%~dp0"

where java >nul 2>nul
if errorlevel 1 goto nojava

set JV=
for /f "tokens=3" %%v in ('java -version 2^>^&1 ^| findstr /i "version"') do set JV=%%~v
for /f "delims=." %%m in ("%JV%") do set JMAJOR=%%m
if "%JMAJOR%"=="" goto nojava
if %JMAJOR% LSS 25 goto oldjava

echo Java %JV% - OK
echo Buduje DarkHUD... ^(za pierwszym razem pobiera sie kilkaset MB, to normalne^)
call gradlew.bat build
if errorlevel 1 (
  echo.
  echo [BLAD] Budowanie nie powiodlo sie. Zrob screena komunikatow powyzej i wyslij.
  echo.
  pause
  exit /b 1
)

echo.
echo ============================================================
echo  GOTOWE!  Plik moda: build\libs\darkhud-1.2.0.jar
echo  Wrzuc go do %%appdata%%\.minecraft\mods
echo  ^(NIE ten z koncowka -sources^)
echo ============================================================
start "" "%~dp0build\libs"
pause
exit /b 0

:nojava
echo.
echo [BLAD] Nie znaleziono Javy.
echo Zainstaluj Temurin JDK 25: https://adoptium.net
echo W instalatorze zaznacz "Add to PATH" i "Set JAVA_HOME", potem uruchom ten plik ponownie.
echo.
pause
exit /b 1

:oldjava
echo.
echo [BLAD] Masz Jave %JV%, a do budowania potrzeba 25 lub nowszej.
echo Zainstaluj Temurin JDK 25: https://adoptium.net
echo W instalatorze zaznacz "Add to PATH" i "Set JAVA_HOME", zamknij to okno i uruchom ponownie.
echo.
pause
exit /b 1
