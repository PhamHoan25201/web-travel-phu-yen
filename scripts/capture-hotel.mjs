import { chromium } from 'playwright';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const indexPath = path.resolve(__dirname, '../index.html');

const browser = await chromium.launch({ headless: true });
const page = await browser.newPage({ viewport: { width: 1440, height: 900 } });
await page.goto(`file://${indexPath}#khach-san`);
await page.waitForTimeout(1000);

const card = await page.$('#khach-san .basecamp-section-card');
if (card) {
  await card.screenshot({ path: path.resolve(__dirname, '../test-hotel-card.png') });
  console.log('Saved test-hotel-card.png successfully!');
} else {
  console.log('Hotel card not found!');
}

await browser.close();

