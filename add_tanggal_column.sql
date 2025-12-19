-- Script untuk menambahkan kolom TANGGAL ke tabel penjadwalan
-- Jalankan script ini di phpMyAdmin jika kolom TANGGAL belum ada

ALTER TABLE `penjadwalan` 
ADD COLUMN `TANGGAL` DATE NULL AFTER `HARI`;

-- Update data lama (opsional): Set tanggal berdasarkan hari minggu ini
-- UPDATE penjadwalan SET TANGGAL = DATE_ADD(CURDATE(), INTERVAL (DAYOFWEEK(CURDATE()) - 
--   CASE HARI 
--     WHEN 'Senin' THEN 2
--     WHEN 'Selasa' THEN 3
--     WHEN 'Rabu' THEN 4
--     WHEN 'Kamis' THEN 5
--     WHEN 'Jumat' THEN 6
--     WHEN 'Sabtu' THEN 7
--     WHEN 'Minggu' THEN 1
--   END) DAY) WHERE TANGGAL IS NULL;

