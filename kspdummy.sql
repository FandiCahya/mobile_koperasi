-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 03 Jul 2025 pada 19.40
-- Versi server: 8.0.30
-- Versi PHP: 8.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kspdummy`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `anggota`
--

CREATE TABLE `anggota` (
  `id_anggota` varchar(8) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `nama` varchar(45) COLLATE utf8mb4_general_ci NOT NULL,
  `jenis_kelamin` enum('Laki-laki','Perempuan') COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('Belum kawin','Kawin') COLLATE utf8mb4_general_ci NOT NULL,
  `tanggungan` int NOT NULL,
  `pendidikan` enum('Sekolah menengah','Perguruan tinggi') COLLATE utf8mb4_general_ci NOT NULL,
  `status_karyawan` enum('ASN','Honorer') COLLATE utf8mb4_general_ci NOT NULL,
  `gaji` int NOT NULL,
  `properti` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `role` enum('admin','anggota') COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `anggota`
--

INSERT INTO `anggota` (`id_anggota`, `email`, `password`, `nama`, `jenis_kelamin`, `status`, `tanggungan`, `pendidikan`, `status_karyawan`, `gaji`, `properti`, `role`) VALUES
('LP001003', 'admin@gmail.com', 'admin123', 'Julian Tohari', 'Laki-laki', 'Kawin', 1, 'Perguruan tinggi', 'Honorer', 4583, 'Rural', 'admin'),
('LP001005', 'anggota@gmail.com', 'anggota123', 'Yuswono', 'Laki-laki', 'Kawin', 0, 'Perguruan tinggi', 'Honorer', 3000, 'Urban', 'anggota'),
('LP001036', 'anggota1@gmail.com', 'anggota123', 'Siti Zulaikah', 'Perempuan', 'Belum kawin', 0, 'Perguruan tinggi', 'Honorer', 3510, 'Urban', 'anggota'),
('LP001037', 'user@example.com', 'password123', 'Nama User', 'Laki-laki', 'Belum kawin', 2, 'Sekolah menengah', 'ASN', 5000000, 'Mobil', 'anggota'),
('LP001038', 'user1@example.com', 'password123', 'Panjol', 'Laki-laki', 'Kawin', 1, 'Perguruan tinggi', 'ASN', 5000000, 'apartement', 'anggota');

-- --------------------------------------------------------

--
-- Struktur dari tabel `distribusi_kredit`
--

CREATE TABLE `distribusi_kredit` (
  `id_distribusi` int NOT NULL,
  `id_anggota` varchar(8) COLLATE utf8mb4_general_ci NOT NULL,
  `nilai_pinjaman` int DEFAULT NULL,
  `id_penawaran` int NOT NULL,
  `status_pinjaman` enum('Sesuai','Tidak sesuai') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'Sesuai'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `distribusi_kredit`
--

INSERT INTO `distribusi_kredit` (`id_distribusi`, `id_anggota`, `nilai_pinjaman`, `id_penawaran`, `status_pinjaman`) VALUES
(1, 'LP001003', 1000000, 1, 'Tidak sesuai'),
(2, 'LP001005', 1000000, 2, 'Sesuai'),
(3, 'LP001036', 1000000, 3, 'Tidak sesuai'),
(5, 'LP001003', 10000000, 1, 'Sesuai'),
(6, 'LP001005', 15000000, 3, 'Sesuai'),
(7, 'LP001003', 1200000, 1, 'Sesuai'),
(8, 'LP001005', 1200000, 1, 'Sesuai'),
(9, 'LP001005', 4100000, 3, 'Sesuai'),
(10, 'LP001003', 1000000, 1, 'Sesuai'),
(11, 'LP001003', 1600000, 7, 'Tidak sesuai'),
(12, 'LP001005', 1600000, 7, 'Tidak sesuai'),
(13, 'LP001036', 1600000, 7, 'Tidak sesuai'),
(14, 'LP001037', 1600000, 7, 'Tidak sesuai'),
(15, 'LP001038', 1600000, 7, 'Tidak sesuai');

-- --------------------------------------------------------

--
-- Struktur dari tabel `penawaran_pinjaman`
--

CREATE TABLE `penawaran_pinjaman` (
  `id_penawaran` int NOT NULL,
  `penawaran` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `penawaran_pinjaman`
--

INSERT INTO `penawaran_pinjaman` (`id_penawaran`, `penawaran`) VALUES
(1, 1500000),
(2, 2000000),
(3, 4100000),
(4, 3000000),
(5, 1500000),
(6, 6000000),
(7, 1600000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengajuan_kredit`
--

CREATE TABLE `pengajuan_kredit` (
  `id_pengajuan` int NOT NULL,
  `id_anggota` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_distribusi` int DEFAULT NULL,
  `id_resiko` int DEFAULT NULL,
  `id_penawaran` int DEFAULT NULL,
  `nilai_pinjaman` int NOT NULL,
  `status_pengajuan` enum('Pending','Diterima','Ditolak') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `pengajuan_kredit`
--

INSERT INTO `pengajuan_kredit` (`id_pengajuan`, `id_anggota`, `id_distribusi`, `id_resiko`, `id_penawaran`, `nilai_pinjaman`, `status_pengajuan`) VALUES
(1, 'LP001003', 1, NULL, 1, 1000000, 'Diterima'),
(2, 'LP001005', 2, NULL, 2, 1000000, 'Ditolak'),
(3, 'LP001005', 12, NULL, 7, 1600000, 'Ditolak'),
(4, 'LP001003', 1, NULL, 1, 1000000, 'Pending'),
(5, 'LP001005', 6, NULL, 3, 15000000, 'Pending'),
(6, 'LP001005', NULL, 7, NULL, 1000000, 'Pending');

-- --------------------------------------------------------

--
-- Struktur dari tabel `resiko_kredit`
--

CREATE TABLE `resiko_kredit` (
  `id_resiko` int NOT NULL,
  `id_anggota` varchar(8) COLLATE utf8mb4_general_ci NOT NULL,
  `nilai_pinjaman` int NOT NULL,
  `waktu_pinjaman` int NOT NULL,
  `histori_pinjaman` int NOT NULL,
  `status_pinjaman` enum('Bagus','Buruk') COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `resiko_kredit`
--

INSERT INTO `resiko_kredit` (`id_resiko`, `id_anggota`, `nilai_pinjaman`, `waktu_pinjaman`, `histori_pinjaman`, `status_pinjaman`) VALUES
(1, 'LP001036', 76000, 360, 0, 'Buruk'),
(2, 'LP001003', 128000, 360, 1, 'Buruk'),
(3, 'LP001005', 66000, 360, 1, 'Bagus'),
(4, 'LP001003', 10000000, 360, 0, 'Bagus'),
(5, 'LP001005', 1000000, 360, 0, 'Bagus'),
(6, 'LP001005', 1000000, 360, 0, 'Bagus'),
(7, 'LP001005', 1000000, 360, 0, 'Bagus');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `anggota`
--
ALTER TABLE `anggota`
  ADD PRIMARY KEY (`id_anggota`);

--
-- Indeks untuk tabel `distribusi_kredit`
--
ALTER TABLE `distribusi_kredit`
  ADD PRIMARY KEY (`id_distribusi`),
  ADD KEY `id_anggota` (`id_anggota`),
  ADD KEY `id_penawaran` (`id_penawaran`);

--
-- Indeks untuk tabel `penawaran_pinjaman`
--
ALTER TABLE `penawaran_pinjaman`
  ADD PRIMARY KEY (`id_penawaran`);

--
-- Indeks untuk tabel `pengajuan_kredit`
--
ALTER TABLE `pengajuan_kredit`
  ADD PRIMARY KEY (`id_pengajuan`),
  ADD KEY `pengajuan_distribusi_ibfk_1` (`id_distribusi`),
  ADD KEY `pengajuan_distribusi_ibfk_3` (`id_penawaran`),
  ADD KEY `id_anggota` (`id_anggota`),
  ADD KEY `id_resiko` (`id_resiko`);

--
-- Indeks untuk tabel `resiko_kredit`
--
ALTER TABLE `resiko_kredit`
  ADD PRIMARY KEY (`id_resiko`),
  ADD KEY `id_anggota` (`id_anggota`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `distribusi_kredit`
--
ALTER TABLE `distribusi_kredit`
  MODIFY `id_distribusi` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT untuk tabel `penawaran_pinjaman`
--
ALTER TABLE `penawaran_pinjaman`
  MODIFY `id_penawaran` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `pengajuan_kredit`
--
ALTER TABLE `pengajuan_kredit`
  MODIFY `id_pengajuan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `resiko_kredit`
--
ALTER TABLE `resiko_kredit`
  MODIFY `id_resiko` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `distribusi_kredit`
--
ALTER TABLE `distribusi_kredit`
  ADD CONSTRAINT `distribusi_kredit_ibfk_1` FOREIGN KEY (`id_anggota`) REFERENCES `anggota` (`id_anggota`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `distribusi_kredit_ibfk_2` FOREIGN KEY (`id_penawaran`) REFERENCES `penawaran_pinjaman` (`id_penawaran`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `pengajuan_kredit`
--
ALTER TABLE `pengajuan_kredit`
  ADD CONSTRAINT `pengajuan_kredit_ibfk_1` FOREIGN KEY (`id_distribusi`) REFERENCES `distribusi_kredit` (`id_distribusi`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pengajuan_kredit_ibfk_3` FOREIGN KEY (`id_penawaran`) REFERENCES `penawaran_pinjaman` (`id_penawaran`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pengajuan_kredit_ibfk_4` FOREIGN KEY (`id_anggota`) REFERENCES `anggota` (`id_anggota`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pengajuan_kredit_ibfk_5` FOREIGN KEY (`id_resiko`) REFERENCES `resiko_kredit` (`id_resiko`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `resiko_kredit`
--
ALTER TABLE `resiko_kredit`
  ADD CONSTRAINT `resiko_kredit_ibfk_1` FOREIGN KEY (`id_anggota`) REFERENCES `anggota` (`id_anggota`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
