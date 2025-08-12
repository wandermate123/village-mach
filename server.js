import express from 'express';
import path from 'path';
import fs from 'fs';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
const PORT = process.env.PORT || 3000;

// Add logging middleware
app.use((req, res, next) => {
    console.log(`${new Date().toISOString()} - ${req.method} ${req.url}`);
    next();
});

// Serve static files from the root directory
app.use(express.static(__dirname));

// Serve static files from the public directory
app.use('/public', express.static(path.join(__dirname, 'public')));

// Special handling for video files to fix 416 errors
app.get('/public/*.mp4', (req, res) => {
    const videoPath = path.join(__dirname, req.path);
    console.log('Video request:', req.path, 'Full path:', videoPath);
    
    // Check if file exists
    if (!fs.existsSync(videoPath)) {
        console.log('Video file not found:', videoPath);
        return res.status(404).send('Video not found');
    }
    
    const stat = fs.statSync(videoPath);
    const fileSize = stat.size;
    const range = req.headers.range;
    
    if (range) {
        const parts = range.replace(/bytes=/, "").split("-");
        const start = parseInt(parts[0], 10);
        const end = parts[1] ? parseInt(parts[1], 10) : fileSize - 1;
        const chunksize = (end - start) + 1;
        const file = fs.createReadStream(videoPath, { start, end });
        
        const head = {
            'Content-Range': `bytes ${start}-${end}/${fileSize}`,
            'Accept-Ranges': 'bytes',
            'Content-Length': chunksize,
            'Content-Type': 'video/mp4',
        };
        
        res.writeHead(206, head);
        file.pipe(res);
    } else {
        const head = {
            'Content-Length': fileSize,
            'Content-Type': 'video/mp4',
            'Accept-Ranges': 'bytes',
        };
        
        res.writeHead(200, head);
        fs.createReadStream(videoPath).pipe(res);
    }
});

// Handle 404 errors for static files
app.use((req, res, next) => {
    if (req.path.startsWith('/public/')) {
        const filePath = path.join(__dirname, req.path);
        if (!fs.existsSync(filePath)) {
            console.log('404 - File not found:', req.path, 'Full path:', filePath);
            return res.status(404).send(`File not found: ${req.path}`);
        }
    }
    next();
});

// Serve all other routes with index.html (for SPA routing)
app.get('*', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
    console.log('Video streaming optimized for background videos');
    console.log('Static files served from:', __dirname);
    console.log('Public files served from:', path.join(__dirname, 'public'));
});
