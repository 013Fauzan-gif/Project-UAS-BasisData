<?php
header('Content-Type: application/json');
$koneksi = mysqli_connect("localhost", "root", "", "penjadwalan");

// Query JOIN untuk mengambil Nama Kelas (termasuk TANGGAL jika ada)
$sql = "SELECT p.*, k.NAMA_KELAS, mk.NAMA_MATKUL, d.NAMA_DOSEN, r.NAMA_RUANGAN 
        FROM penjadwalan p
        JOIN kelas k ON p.ID_KELAS = k.ID_KELAS
        JOIN mata_kuliah mk ON p.KODE_MATKUL = mk.KODE_MATKUL
        JOIN dosen d ON p.NIDN = d.NIDN
        JOIN ruangan r ON p.ID_RUANGAN = r.ID_RUANGAN
        ORDER BY COALESCE(p.TANGGAL, '1900-01-01'), p.JAM_MULAI";

$query = mysqli_query($koneksi, $sql);
$data = [];

while($row = mysqli_fetch_assoc($query)) {
    $data[] = $row;
}

echo json_encode($data);
?>