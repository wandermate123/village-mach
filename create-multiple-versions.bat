@echo off
echo Creating multiple video versions for different devices...
echo.

REM Check if FFmpeg is installed
ffmpeg -version >nul 2>&1
if %errorlevel% neq 0 (
    echo FFmpeg not found! Please install FFmpeg first.
    echo Download from: https://ffmpeg.org/download.html
    pause
    exit /b 1
)

REM High quality version (desktop)
echo Creating high quality version...
ffmpeg -i "public/background-video.mp4" ^
    -c:v libx264 ^
    -crf 23 ^
    -preset medium ^
    -c:a aac ^
    -b:a 128k ^
    -movflags +faststart ^
    -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2" ^
    "public/background-video-hq.mp4"

REM Medium quality version (tablet)
echo Creating medium quality version...
ffmpeg -i "public/background-video.mp4" ^
    -c:v libx264 ^
    -crf 28 ^
    -preset medium ^
    -c:a aac ^
    -b:a 96k ^
    -movflags +faststart ^
    -vf "scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2" ^
    "public/background-video-mq.mp4"

REM Low quality version (mobile)
echo Creating low quality version...
ffmpeg -i "public/background-video.mp4" ^
    -c:v libx264 ^
    -crf 32 ^
    -preset medium ^
    -c:a aac ^
    -b:a 64k ^
    -movflags +faststart ^
    -vf "scale=854:480:force_original_aspect_ratio=decrease,pad=854:480:(ow-iw)/2:(oh-ih)/2" ^
    "public/background-video-lq.mp4"

echo.
echo Multiple versions created!
echo High Quality: background-video-hq.mp4 (~10-20MB)
echo Medium Quality: background-video-mq.mp4 (~5-10MB)
echo Low Quality: background-video-lq.mp4 (~2-5MB)
echo.
pause
