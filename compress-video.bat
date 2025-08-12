@echo off
echo Compressing video for web use...
echo.

REM Check if FFmpeg is installed
ffmpeg -version >nul 2>&1
if %errorlevel% neq 0 (
    echo FFmpeg not found! Please install FFmpeg first.
    echo Download from: https://ffmpeg.org/download.html
    pause
    exit /b 1
)

REM Compress video to web-optimized format
echo Creating compressed version...
ffmpeg -i "public/background-video.mp4" ^
    -c:v libx264 ^
    -crf 28 ^
    -preset medium ^
    -c:a aac ^
    -b:a 128k ^
    -movflags +faststart ^
    -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2" ^
    "public/background-video-compressed.mp4"

echo.
echo Video compression complete!
echo Original: background-video.mp4 (125MB)
echo Compressed: background-video-compressed.mp4 (should be ~5-15MB)
echo.
pause
