@echo off
echo Converting video to WebM format for better web compression...
echo.

REM Check if FFmpeg is installed
ffmpeg -version >nul 2>&1
if %errorlevel% neq 0 (
    echo FFmpeg not found! Please install FFmpeg first.
    echo Download from: https://ffmpeg.org/download.html
    pause
    exit /b 1
)

REM Convert to WebM with VP9 codec (better compression)
echo Creating WebM version...
ffmpeg -i "public/background-video.mp4" ^
    -c:v libvpx-vp9 ^
    -crf 30 ^
    -b:v 0 ^
    -c:a libopus ^
    -b:a 128k ^
    -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2" ^
    "public/background-video.webm"

echo.
echo WebM conversion complete!
echo Original: background-video.mp4 (125MB)
echo WebM: background-video.webm (should be ~3-8MB)
echo.
pause
