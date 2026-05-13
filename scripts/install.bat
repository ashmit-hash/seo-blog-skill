@echo off
echo.
echo ========================================
echo   SEO Blog Skill Installer (Windows)
echo ========================================
echo.

REM Find the Claude skills directory
set SKILLS_DIR=%APPDATA%\Claude\local-agent-mode-sessions\skills-plugin

REM Check if the skills-plugin folder exists
if not exist "%SKILLS_DIR%" (
    echo ERROR: Could not find Claude skills directory.
    echo.
    echo Make sure Claude Code is installed and has been opened at least once.
    echo Expected path: %SKILLS_DIR%
    echo.
    pause
    exit /b 1
)

REM Find the first subfolder inside skills-plugin (the session ID)
for /d %%i in ("%SKILLS_DIR%\*") do (
    set SESSION_DIR=%%i
    goto :found_session
)

:found_session
REM Find the skills folder inside the session
for /d %%i in ("%SESSION_DIR%\*") do (
    if exist "%%i\skills" (
        set TARGET=%%i\skills\generate-blog
        goto :install
    )
)

echo ERROR: Could not find skills folder inside Claude session directory.
pause
exit /b 1

:install
echo Installing to: %TARGET%
echo.

REM Create target directories
mkdir "%TARGET%" 2>nul
mkdir "%TARGET%\references" 2>nul

REM Copy files
copy "%~dp0..\SKILL.md" "%TARGET%\" >nul
copy "%~dp0..\references\blog-prompt.md" "%TARGET%\references\" >nul
copy "%~dp0..\references\system-prompt.md" "%TARGET%\references\" >nul

echo Skill installed successfully!
echo.
echo ----------------------------------------
echo Next steps:
echo 1. Restart Claude Code
echo 2. In a new chat, type:
echo    generate a blog for https://yourstore.com
echo ----------------------------------------
echo.
pause
