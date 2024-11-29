# 1. انتخاب یک تصویر مناسب Node.js
FROM node:18-alpine AS builder

# 2. تنظیم دایرکتوری کاری در داخل کانتینر
WORKDIR /app

# 3. کپی کردن فایل‌های package.json و package-lock.json برای نصب وابستگی‌ها
COPY package.json package-lock.json ./

# 4. نصب وابستگی‌ها
RUN npm install

# 5. کپی تمام فایل‌های پروژه به داخل کانتینر
COPY . .

# 6. ساخت نسخه تولید (Production)
RUN npm run build

# 7. فقط فایل‌های لازم برای تولید را نگه می‌داریم
FROM node:18-alpine AS runner

# 8. تنظیم متغیرهای محیطی
ENV NODE_ENV=production

# 9. دایرکتوری کاری را تنظیم می‌کنیم
WORKDIR /app

# 10. کپی فایل‌های ضروری از مرحله ساخت
COPY --from=builder /app/package.json ./
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules ./node_modules

# 11. پورت پیش‌فرض Next.js
EXPOSE 3000

# 12. اجرای برنامه
CMD ["npm", "start"]
