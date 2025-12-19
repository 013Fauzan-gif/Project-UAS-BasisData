-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 18 Des 2025 pada 12.16
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `penjadwalan`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `dosen`
--

CREATE TABLE `dosen` (
  `NIDN` int(11) NOT NULL,
  `NAMA_DOSEN` varchar(50) DEFAULT NULL,
  `EMAIL_DOSEN` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `dosen`
--

INSERT INTO `dosen` (`NIDN`, `NAMA_DOSEN`, `EMAIL_DOSEN`) VALUES
(1122, 'Widi AriBowo', 'widi@gmail.com'),
(1123, 'Farhana Mar\'i', 'farhana@gmail.com'),
(1234, 'Ardhini Warith Utami', 'utami@gmail.com'),
(1237, 'Wiyli Yustanti', 'wiyli@gmail.com'),
(1335, 'Erik Rahman', 'rahman@gmail.com'),
(1822, 'Nurus Saadah', 'nurus@gmail.com'),
(2148, 'Aries Dwi Indriyanti', 'aries@gmail.com'),
(2213, 'Aditya Prapanca', 'adit@gmail.com'),
(2222, 'Rifqi Abdillah', 'rifqi@gmail.com'),
(2341, 'Bambang Sujatmiko', 'sujatmiko@gmail.com'),
(2553, 'Martini Dwi Endah Susanti', 'dwi@gmail.com'),
(3312, 'I Made Suartana', 'made@gmail.com'),
(3322, 'Nia Wahyu Damayanti', 'nia@gmail.com'),
(4312, 'Ricky Eka Putra', 'ricky@gmail.com'),
(4321, 'Ronggo Alit', 'alit@gmail.com'),
(4413, 'Yuni Yamasari', 'yuni@gmail.com'),
(4644, 'Ersha Aisyah Elfaiz', 'aisyah@gmail.com'),
(5678, 'Muhammad Sonhaji Akbar', 'akbar@gmail.com'),
(6364, 'Riza Akhsani Setyo Prayoga', 'riza@gmail.com'),
(6644, 'I Kadek Dwi Nuryana', 'kadek@gmail.com'),
(6677, 'Yeni Anistyasari', 'yeni@gmail.com'),
(6983, 'Elvira Warda', 'elvira@gmail.com'),
(7433, 'Ghea Sekar Palupi', 'ghea@gmail.com'),
(7568, 'Cendra Devayana Putra', 'putra@gmail.com'),
(7734, 'Ervin Yohannes', 'ervin@gmail.com');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kelas`
--

CREATE TABLE `kelas` (
  `ID_KELAS` int(11) NOT NULL,
  `ID_PRODI` int(11) NOT NULL,
  `NAMA_KELAS` varchar(20) DEFAULT NULL,
  `TAHUN_ANGKATAN` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `kelas`
--

INSERT INTO `kelas` (`ID_KELAS`, `ID_PRODI`, `NAMA_KELAS`, `TAHUN_ANGKATAN`) VALUES
(1, 1, 'TI-2023-A', 2023),
(2, 1, 'TI-2023-B', 2023),
(3, 1, 'TI-2024-A', 2024),
(4, 1, 'TI-2024-B', 2024),
(5, 1, 'TI-2025-A', 2025),
(6, 2, 'PTI-2023-A', 2023),
(7, 2, 'PTI-2023-B', 2023),
(8, 2, 'PTI-2024-A', 2024),
(9, 2, 'PTI-2024-B', 2024),
(10, 2, 'PTI-2025-A', 2025),
(11, 3, 'SI-2023-A', 2023),
(12, 3, 'SI-2023-B', 2023),
(13, 3, 'SI-2024-A', 2024),
(14, 3, 'SI-2024-B', 2024),
(15, 3, 'SI-2025-A', 2025);

-- --------------------------------------------------------

--
-- Struktur dari tabel `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `NIM` int(11) NOT NULL,
  `ID_KELAS` int(11) NOT NULL,
  `NAMA_MAHASISWA` varchar(50) DEFAULT NULL,
  `ALAMAT` varchar(50) DEFAULT NULL,
  `JENIS_KELAMIN` varchar(10) DEFAULT NULL,
  `TEMPAT_LAHIR` varchar(20) DEFAULT NULL,
  `TANGGAL_LAHIR` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `mahasiswa`
--

INSERT INTO `mahasiswa` (`NIM`, `ID_KELAS`, `NAMA_MAHASISWA`, `ALAMAT`, `JENIS_KELAMIN`, `TEMPAT_LAHIR`, `TANGGAL_LAHIR`) VALUES
(2301001, 1, 'Ahmad Fauzi', 'Jl. Mawar No. 12, Surabaya', 'L', 'Surabaya', '2005-05-14'),
(2301002, 1, 'Siti Aminah', 'Jl. Melati No. 5, Sidoarjo', 'P', 'Sidoarjo', '2005-08-22'),
(2301003, 2, 'Budi Santoso', 'Jl. Dahlia No. 3, Gresik', 'L', 'Gresik', '2004-12-01'),
(2301004, 2, 'Larasati Putri', 'Jl. Anggrek No. 8, Malang', 'P', 'Malang', '2005-02-10'),
(2401001, 3, 'Rizky Pratama', 'Jl. Kenanga No. 21, Surabaya', 'L', 'Surabaya', '2006-07-30'),
(2401002, 3, 'Dewi Lestari', 'Jl. Kamboja No. 4, Mojokerto', 'P', 'Mojokerto', '2006-03-15'),
(2401003, 4, 'Fajar Ramadhan', 'Jl. Tulip No. 17, Pasuruan', 'L', 'Pasuruan', '2005-11-25'),
(2401004, 4, 'Putri Indah', 'Jl. Teratai No. 9, Lamongan', 'P', 'Lamongan', '2006-01-05'),
(2501001, 5, 'Dimas Saputra', 'Jl. Matahari No. 11, Jombang', 'L', 'Jombang', '2007-09-12'),
(2501002, 5, 'Anisa Rahma', 'Jl. Sakura No. 6, Tuban', 'P', 'Tuban', '2007-06-20');

-- --------------------------------------------------------

--
-- Struktur dari tabel `mata_kuliah`
--

CREATE TABLE `mata_kuliah` (
  `KODE_MATKUL` int(11) NOT NULL,
  `NAMA_MATKUL` varchar(20) DEFAULT NULL,
  `SKS` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `mata_kuliah`
--

INSERT INTO `mata_kuliah` (`KODE_MATKUL`, `NAMA_MATKUL`, `SKS`) VALUES
(101, 'Basis Data', 3),
(102, 'Pemrograman Mobile', 3),
(103, 'Pemrograman Dasar', 4),
(104, 'Interaksi Manusia da', 2),
(105, 'Internet of Things', 3),
(106, 'Etika Profesi', 2),
(107, 'Statistika', 3),
(108, 'Data Mining', 3),
(109, 'Keamanan Jaringan', 3),
(110, 'Matematika Diskrit', 3),
(111, 'Teknologi Keuangan', 2),
(112, 'Sistem Temu Kembali ', 3),
(113, 'Manajemen Sumber Day', 2),
(114, 'Pemrograman Berbasis', 4),
(115, 'Evaluasi Belajar dan', 3),
(116, 'Manajemen Proses Bis', 2),
(117, 'Arsitektur dan Organ', 3),
(118, 'Transformasi Digital', 2),
(119, 'Grafika Komputer', 3),
(120, 'Struktur Data', 3),
(121, 'Matematika I', 3),
(122, 'Metodologi Penelitia', 2),
(123, 'Capstone Project', 6);

-- --------------------------------------------------------

--
-- Struktur dari tabel `penjadwalan`
--

CREATE TABLE `penjadwalan` (
  `ID_JADWAL` int(11) NOT NULL,
  `NIDN` int(11) NOT NULL,
  `ID_KELAS` int(11) NOT NULL,
  `KODE_MATKUL` int(11) DEFAULT NULL,
  `ID_RUANGAN` int(11) NOT NULL,
  `HARI` varchar(10) DEFAULT NULL,
  `JAM_MULAI` time DEFAULT NULL,
  `JAM_SELESAI` time DEFAULT NULL,
  `DURASI` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `penjadwalan`
--

INSERT INTO `penjadwalan` (`ID_JADWAL`, `NIDN`, `ID_KELAS`, `KODE_MATKUL`, `ID_RUANGAN`, `HARI`, `JAM_MULAI`, `JAM_SELESAI`, `DURASI`) VALUES
(1, 1122, 1, 101, 5, 'Senin', '07:30:00', '10:00:00', NULL),
(2, 1123, 2, 102, 6, 'Senin', '10:15:00', '12:45:00', NULL),
(3, 1234, 3, 103, 5, 'Selasa', '07:30:00', '10:50:00', NULL),
(4, 1237, 4, 104, 1, 'Selasa', '13:00:00', '14:40:00', NULL),
(5, 1335, 5, 105, 7, 'Rabu', '08:00:00', '10:30:00', NULL),
(6, 1822, 6, 106, 2, 'Rabu', '11:00:00', '12:40:00', NULL),
(7, 2148, 7, 107, 3, 'Kamis', '07:30:00', '10:00:00', NULL),
(8, 2213, 8, 108, 8, 'Kamis', '10:15:00', '12:45:00', NULL),
(9, 2222, 9, 109, 7, 'Jumat', '07:30:00', '10:00:00', NULL),
(10, 2341, 10, 110, 4, 'Jumat', '13:30:00', '16:00:00', NULL),
(11, 2553, 11, 111, 1, 'Senin', '13:00:00', '14:40:00', NULL),
(12, 3312, 12, 112, 3, 'Selasa', '10:00:00', '12:30:00', NULL),
(13, 3322, 13, 113, 4, 'Rabu', '13:00:00', '14:40:00', NULL),
(14, 4312, 14, 114, 6, 'Kamis', '13:00:00', '16:20:00', NULL),
(15, 4321, 15, 115, 2, 'Jumat', '08:00:00', '10:30:00', NULL),
(16, 4413, 1, 116, 3, 'Senin', '10:15:00', '11:55:00', NULL),
(17, 4644, 2, 117, 8, 'Selasa', '13:00:00', '15:30:00', NULL),
(18, 5678, 3, 118, 4, 'Rabu', '07:30:00', '09:10:00', NULL),
(19, 6364, 4, 119, 5, 'Kamis', '07:30:00', '10:00:00', NULL),
(20, 6644, 5, 120, 6, 'Jumat', '13:30:00', '16:00:00', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `program_studi`
--

CREATE TABLE `program_studi` (
  `ID_PRODI` int(11) NOT NULL,
  `NAMA_PRODI` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `program_studi`
--

INSERT INTO `program_studi` (`ID_PRODI`, `NAMA_PRODI`) VALUES
(1, 'Teknik Informatika'),
(2, 'Pendidikan Teknologi'),
(3, 'Sistem Informasi');

-- --------------------------------------------------------

--
-- Struktur dari tabel `ruangan`
--

CREATE TABLE `ruangan` (
  `ID_RUANGAN` int(11) NOT NULL,
  `NAMA_RUANGAN` varchar(20) DEFAULT NULL,
  `KAPASITAS` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `ruangan`
--

INSERT INTO `ruangan` (`ID_RUANGAN`, `NAMA_RUANGAN`, `KAPASITAS`) VALUES
(1, 'Ruang Teori A.01', 40),
(2, 'Ruang Teori A.02', 40),
(3, 'Ruang Teori B.01', 35),
(4, 'Ruang Teori B.02', 35),
(5, 'Lab Komputer Dasar', 30),
(6, 'Lab Rekayasa Perangk', 25),
(7, 'Lab Jaringan Kompute', 25),
(8, 'Lab Multimedia', 30),
(9, 'Aula Gedung Utama', 100),
(10, 'Ruang Seminar', 50);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `role` varchar(50) DEFAULT 'admin',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `nama`, `role`, `created_at`) VALUES
(1, 'admin@example.com', 'admin123', 'Admin Sistem', 'admin', '2025-12-18 10:13:56');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `dosen`
--
ALTER TABLE `dosen`
  ADD PRIMARY KEY (`NIDN`);

--
-- Indeks untuk tabel `kelas`
--
ALTER TABLE `kelas`
  ADD PRIMARY KEY (`ID_KELAS`),
  ADD KEY `FK_KELAS_MEMILIKI_PROGRAM_` (`ID_PRODI`);

--
-- Indeks untuk tabel `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`NIM`),
  ADD KEY `FK_MAHASISW_TERDAFTAR_KELAS` (`ID_KELAS`);

--
-- Indeks untuk tabel `mata_kuliah`
--
ALTER TABLE `mata_kuliah`
  ADD PRIMARY KEY (`KODE_MATKUL`);

--
-- Indeks untuk tabel `penjadwalan`
--
ALTER TABLE `penjadwalan`
  ADD PRIMARY KEY (`ID_JADWAL`),
  ADD KEY `FK_PENJADWA_DIIKUTI_O_KELAS` (`ID_KELAS`),
  ADD KEY `FK_PENJADWA_DIJADWALK_MATA_KUL` (`KODE_MATKUL`),
  ADD KEY `FK_PENJADWA_MENGAMPUH_DOSEN` (`NIDN`),
  ADD KEY `FK_PENJADWA_MENGGUNAK_RUANGAN` (`ID_RUANGAN`);

--
-- Indeks untuk tabel `program_studi`
--
ALTER TABLE `program_studi`
  ADD PRIMARY KEY (`ID_PRODI`);

--
-- Indeks untuk tabel `ruangan`
--
ALTER TABLE `ruangan`
  ADD PRIMARY KEY (`ID_RUANGAN`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `penjadwalan`
--
ALTER TABLE `penjadwalan`
  MODIFY `ID_JADWAL` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `kelas`
--
ALTER TABLE `kelas`
  ADD CONSTRAINT `FK_KELAS_MEMILIKI_PROGRAM_` FOREIGN KEY (`ID_PRODI`) REFERENCES `program_studi` (`ID_PRODI`);

--
-- Ketidakleluasaan untuk tabel `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD CONSTRAINT `FK_MAHASISW_TERDAFTAR_KELAS` FOREIGN KEY (`ID_KELAS`) REFERENCES `kelas` (`ID_KELAS`);

--
-- Ketidakleluasaan untuk tabel `penjadwalan`
--
ALTER TABLE `penjadwalan`
  ADD CONSTRAINT `FK_PENJADWA_DIIKUTI_O_KELAS` FOREIGN KEY (`ID_KELAS`) REFERENCES `kelas` (`ID_KELAS`),
  ADD CONSTRAINT `FK_PENJADWA_DIJADWALK_MATA_KUL` FOREIGN KEY (`KODE_MATKUL`) REFERENCES `mata_kuliah` (`KODE_MATKUL`),
  ADD CONSTRAINT `FK_PENJADWA_MENGAMPUH_DOSEN` FOREIGN KEY (`NIDN`) REFERENCES `dosen` (`NIDN`),
  ADD CONSTRAINT `FK_PENJADWA_MENGGUNAK_RUANGAN` FOREIGN KEY (`ID_RUANGAN`) REFERENCES `ruangan` (`ID_RUANGAN`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
