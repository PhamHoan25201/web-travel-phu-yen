import { chromium } from 'playwright';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const indexPath = path.resolve(__dirname, '../index.html');

console.log('=====================================================');
console.log('🚀 ĐANG MỞ PLAYWRIGHT CHROMIUM TRÊN MÀN HÌNH CỦA BẠN');
console.log(`📄 Tệp: ${indexPath}`);
console.log('💡 Cửa sổ trình duyệt sẽ giữ nguyên để bạn quan sát.');
console.log('   (Để thoát, chỉ cần tắt cửa sổ trình duyệt hoặc nhấn Ctrl + C)');
console.log('=====================================================\n');

const browser = await chromium.launch({
  headless: false,
  args: ['--start-maximized']
});

const context = await browser.newContext({
  viewport: null // Phóng to theo đúng kích thước cửa sổ màn hình
});

const page = await context.newPage();
await page.goto(`file://${indexPath}`);

page.on('close', async () => {
  console.log('\n[Đã đóng] Cửa sổ trình duyệt đã được đóng.');
  await browser.close();
  process.exit(0);
});

// Giữ tiến trình không tự ngắt để người dùng thoải mái thao tác
await new Promise(() => {});

