-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 02, 2020 at 10:24 AM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bank`
--

-- --------------------------------------------------------

--
-- Table structure for table `cabang_bank`
--

CREATE TABLE `cabang_bank` (
  `ID_CABANG` varchar(20) NOT NULL,
  `NAMA_CABANG` text DEFAULT NULL,
  `ALAMAT_CABANG` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cabang_bank`
--

INSERT INTO `cabang_bank` (`ID_CABANG`, `NAMA_CABANG`, `ALAMAT_CABANG`) VALUES
('BLT_01', 'BANK MANDIRI CABANG BLITAR', 'Blitar'),
('KDR_04', 'BANK MANDIRI CABANG KEDIRI', 'KEDIRI'),
('MLG_01', 'BANK MANDIRI CABANG MALANG', 'Malang'),
('SBY_01', 'BANK MANDIRI CABANG SURABAYA', 'Surabaya');

-- --------------------------------------------------------

--
-- Table structure for table `karyawan`
--

CREATE TABLE `karyawan` (
  `ID_KARYAWAN` bigint(25) NOT NULL,
  `ID_CABANG` varchar(20) DEFAULT NULL,
  `NAMA_KARYAWAN` text DEFAULT NULL,
  `ALAMAT_KARYAWAN` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `karyawan`
--

INSERT INTO `karyawan` (`ID_KARYAWAN`, `ID_CABANG`, `NAMA_KARYAWAN`, `ALAMAT_KARYAWAN`) VALUES
(50000001, 'SBY_01', 'Faris', 'Surabaya'),
(50000002, 'BLT_01', 'Afif', 'Blitar'),
(50000003, 'BLT_01', 'Adistya', 'Blitar'),
(50000005, 'BLT_01', 'Varisa', 'Kediri'),
(50000007, 'MLG_01', 'Dony', 'Malang'),
(50000008, 'SBY_01', 'Reza', 'Surabaya');

-- --------------------------------------------------------

--
-- Table structure for table `nasabah`
--

CREATE TABLE `nasabah` (
  `ID_NASABAH` bigint(16) NOT NULL,
  `NOMOR_REKENING` bigint(20) DEFAULT NULL,
  `NAMA_NASABAH` text DEFAULT NULL,
  `ALAMAT_NASABAH` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `nasabah`
--

INSERT INTO `nasabah` (`ID_NASABAH`, `NOMOR_REKENING`, `NAMA_NASABAH`, `ALAMAT_NASABAH`) VALUES
(1, 18104410001, 'Sugeng', 'Blitar'),
(2, 18104410002, 'Toni', 'Kediri'),
(3, 18104410003, 'Yusuf', 'Malang'),
(4, 18104410004, 'Rizaldi', 'Malang'),
(5, 18104410005, 'Kurniawan', 'Kediri'),
(10, 18104410017, 'Anu', 'Surabaya');

-- --------------------------------------------------------

--
-- Table structure for table `rekening`
--

CREATE TABLE `rekening` (
  `NOMOR_REKENING` bigint(20) NOT NULL,
  `SALDO_REKENING` decimal(60,0) DEFAULT NULL,
  `PIN` decimal(4,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rekening`
--

INSERT INTO `rekening` (`NOMOR_REKENING`, `SALDO_REKENING`, `PIN`) VALUES
(18104410001, '8100000', '1234'),
(18104410002, '2000000', '4321'),
(18104410003, '6000000', '1321'),
(18104410004, '5000000', '2341'),
(18104410005, '7000000', '3124'),
(18104410017, '100000', '1234');

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `NOMOR_TRANSAKSI` bigint(60) NOT NULL,
  `NOMOR_REKENING` bigint(20) DEFAULT NULL,
  `ID_KARYAWAN` bigint(25) DEFAULT NULL,
  `JENIS_TRANSAKSI` text DEFAULT NULL,
  `TANGGAL_TRANSAKSI` datetime DEFAULT current_timestamp(),
  `JUMLAH_TRANSAKSI` bigint(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`NOMOR_TRANSAKSI`, `NOMOR_REKENING`, `ID_KARYAWAN`, `JENIS_TRANSAKSI`, `TANGGAL_TRANSAKSI`, `JUMLAH_TRANSAKSI`) VALUES
(12450011, 18104410001, 50000002, 'Menabung', '2019-11-01 07:00:00', 1000000),
(12450012, 18104410001, 50000002, 'Menabung', '2019-11-02 09:00:00', 1000000),
(12450013, 18104410002, 50000005, 'Mengambil', '2019-11-03 16:00:00', 1000000),
(12450014, 18104410003, 50000007, 'Mengambil', '2019-11-04 08:00:00', 1000000),
(12450015, 18104410004, 50000007, 'Menabung', '2019-11-05 12:00:00', 1000000),
(12450017, 18104410001, 50000003, 'Menabung', '2020-01-30 17:31:16', 1),
(12450018, 18104410017, 50000001, 'Menabung', '2020-01-30 18:01:40', 100),
(12450019, 18104410017, 50000001, 'Mengambil', '2020-01-30 18:01:58', 100),
(12450020, 18104410001, 50000007, 'Menabung', '2020-02-02 15:15:19', 100000),
(12450021, 18104410017, 50000001, 'Menabung', '2020-02-02 15:25:13', 100000);

--
-- Triggers `transaksi`
--
DELIMITER $$
CREATE TRIGGER `TransaksiSaldo` BEFORE INSERT ON `transaksi` FOR EACH ROW BEGIN
IF(NEW.JENIS_TRANSAKSI = "Menabung") THEN
    UPDATE rekening SET rekening.SALDO_REKENING = rekening.SALDO_REKENING +
    NEW.JUMLAH_TRANSAKSI WHERE rekening.NOMOR_REKENING = NEW.NOMOR_REKENING;
ELSE
    UPDATE rekening SET rekening.SALDO_REKENING = rekening.SALDO_REKENING - NEW.JUMLAH_TRANSAKSI WHERE rekening.NOMOR_REKENING = NEW.NOMOR_REKENING;
END IF;

END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cabang_bank`
--
ALTER TABLE `cabang_bank`
  ADD PRIMARY KEY (`ID_CABANG`);

--
-- Indexes for table `karyawan`
--
ALTER TABLE `karyawan`
  ADD PRIMARY KEY (`ID_KARYAWAN`),
  ADD KEY `ID_Cabang` (`ID_CABANG`);

--
-- Indexes for table `nasabah`
--
ALTER TABLE `nasabah`
  ADD PRIMARY KEY (`ID_NASABAH`),
  ADD KEY `Mempunyai` (`NOMOR_REKENING`);

--
-- Indexes for table `rekening`
--
ALTER TABLE `rekening`
  ADD PRIMARY KEY (`NOMOR_REKENING`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`NOMOR_TRANSAKSI`),
  ADD KEY `NOMOR_REKENING_MELIBATKAN` (`NOMOR_REKENING`),
  ADD KEY `ID_KARYAWAN_DIBANTU` (`ID_KARYAWAN`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `karyawan`
--
ALTER TABLE `karyawan`
  MODIFY `ID_KARYAWAN` bigint(25) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50000009;

--
-- AUTO_INCREMENT for table `nasabah`
--
ALTER TABLE `nasabah`
  MODIFY `ID_NASABAH` bigint(16) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `rekening`
--
ALTER TABLE `rekening`
  MODIFY `NOMOR_REKENING` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18104410018;

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `NOMOR_TRANSAKSI` bigint(60) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12450022;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `karyawan`
--
ALTER TABLE `karyawan`
  ADD CONSTRAINT `ID_Cabang` FOREIGN KEY (`ID_CABANG`) REFERENCES `cabang_bank` (`ID_CABANG`);

--
-- Constraints for table `nasabah`
--
ALTER TABLE `nasabah`
  ADD CONSTRAINT `Mempunyai` FOREIGN KEY (`NOMOR_REKENING`) REFERENCES `rekening` (`NOMOR_REKENING`);

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `ID_KARYAWAN_DIBANTU` FOREIGN KEY (`ID_KARYAWAN`) REFERENCES `karyawan` (`ID_KARYAWAN`),
  ADD CONSTRAINT `NOMOR_REKENING_MELIBATKAN` FOREIGN KEY (`NOMOR_REKENING`) REFERENCES `rekening` (`NOMOR_REKENING`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
