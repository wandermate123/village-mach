# PowerShell script to compress video for web use
# This script provides instructions for manual compression

Write-Host "Video Compression Guide for Web Use" -ForegroundColor Green
Write-Host "=====================================" -ForegroundColor Green
Write-Host ""

Write-Host "Your video file is 125MB, which is too large for web use." -ForegroundColor Yellow
Write-Host "Recommended size: 2-10MB for optimal loading" -ForegroundColor Yellow
Write-Host ""

Write-Host "Compression Options:" -ForegroundColor Cyan
Write-Host "1. Use FFmpeg (Recommended)" -ForegroundColor White
Write-Host "   - Download from: https://ffmpeg.org/download.html" -ForegroundColor Gray
Write-Host "   - Run: compress-video.bat" -ForegroundColor Gray
Write-Host ""

Write-Host "2. Use Online Tools:" -ForegroundColor White
Write-Host "   - https://www.onlinevideoconverter.com/" -ForegroundColor Gray
Write-Host "   - https://convertio.co/video-converter/" -ForegroundColor Gray
Write-Host "   - https://www.youcompress.com/" -ForegroundColor Gray
Write-Host ""

Write-Host "3. Use Windows Movie Maker or similar software" -ForegroundColor White
Write-Host ""

Write-Host "Recommended Settings:" -ForegroundColor Cyan
Write-Host "- Resolution: 1920x1080 or 1280x720" -ForegroundColor Gray
Write-Host "- Format: MP4 (H.264)" -ForegroundColor Gray
Write-Host "- Bitrate: 1-2 Mbps" -ForegroundColor Gray
Write-Host "- Duration: 10-30 seconds (will loop)" -ForegroundColor Gray
Write-Host ""

Write-Host "After compression, rename the file to:" -ForegroundColor Yellow
Write-Host "public/background-video-compressed.mp4" -ForegroundColor White
Write-Host ""

Read-Host "Press Enter to continue..."
