import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

console.log('🔍 Checking deployment setup...');

// Check if all required files exist
const requiredFiles = [
    'index.html',
    'styles.css',
    'server.js',
    'package.json'
];

const requiredAssets = [
    'public/background-video.mp4',
    'public/sample-video.mp4',
    'public/machaan-logo.png',
    'public/bg image.png',
    'public/bg sky.png',
    'public/bg gate.png',
    'public/tree right.png',
    'public/tree left.png',
    'public/white gradient top.png',
    'public/white gradient bottom.png',
    'public/top palm.png',
    'public/top black gradient.png',
    'public/left leaves.png'
];

console.log('\n📁 Checking required files:');
let allFilesExist = true;

requiredFiles.forEach(file => {
    const filePath = path.join(__dirname, file);
    if (fs.existsSync(filePath)) {
        console.log(`✅ ${file}`);
    } else {
        console.log(`❌ ${file} - MISSING`);
        allFilesExist = false;
    }
});

console.log('\n🖼️ Checking required assets:');
requiredAssets.forEach(asset => {
    const assetPath = path.join(__dirname, asset);
    if (fs.existsSync(assetPath)) {
        const stats = fs.statSync(assetPath);
        console.log(`✅ ${asset} (${(stats.size / 1024 / 1024).toFixed(2)} MB)`);
    } else {
        console.log(`❌ ${asset} - MISSING`);
        allFilesExist = false;
    }
});

if (allFilesExist) {
    console.log('\n🎉 All files are present! Your deployment should work correctly.');
    console.log('\n📋 Next steps:');
    console.log('1. Run: npm install');
    console.log('2. Run: npm run server');
    console.log('3. Open: http://localhost:3000');
} else {
    console.log('\n⚠️ Some files are missing. Please check the file structure.');
    process.exit(1);
}

// Check package.json for correct configuration
try {
    const packageJson = JSON.parse(fs.readFileSync('package.json', 'utf8'));
    if (packageJson.type !== 'module') {
        console.log('\n⚠️ Warning: package.json should have "type": "module" for ES modules');
    }
    console.log('\n📦 Package.json configuration looks good!');
} catch (error) {
    console.log('\n❌ Error reading package.json:', error.message);
}
