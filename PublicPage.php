<?php
$koneksi = mysqli_connect("localhost", "root", "", "penjadwalan");
date_default_timezone_set("Asia/Jakarta");
$jam_sekarang = date("H:i:s");
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jadwal Kuliah - Universitas</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #8aaee0 0%, #628ecb 100%);
            min-height: 100vh;
        }

        .header {
            background: white;
            padding: 15px 40px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo-section {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logo {
            width: 60px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            border-radius: 8px;
        }

        .logo img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        .university-info h1 {
            font-size: 24px;
            color: #333;
            margin-bottom: 5px;
        }

        .university-info p {
            color: #666;
            font-size: 14px;
        }

        .clock-section {
            text-align: right;
        }

        .digital-clock {
            font-size: 48px;
            font-weight: bold;
            color: #c2e6fe;
            font-family: 'Courier New', monospace;
        }

        .date-display {
            font-size: 16px;
            color: #666;
            margin-top: 5px;
        }

        .container {
            max-width: 1400px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .filter-section {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            display: flex;
            gap: 20px;
            align-items: center;
        }

        .filter-group {
            flex: 1;
        }

        .filter-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333333;
        }

        .searchable-select {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s;
        }

        .searchable-select:focus {
            outline: none;
            border-color: #81c9ef;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.578);
        }

        .schedule-board {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .board-header {
            background: linear-gradient(135deg, #b1c9ef 0%, #8aaee0 100%);
            color: white;
            padding: 20px 30px;
            font-size: 24px;
            font-weight: bold;
        }

        .schedule-table {
            width: 100%;
            border-collapse: collapse;
        }

        .schedule-table thead {
            background: #f8f9fa;
        }

        .schedule-table th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #333;
            border-bottom: 2px solid #e0e0e0;
        }

        .schedule-table td {
            padding: 15px;
            border-bottom: 1px solid #f0f0f0;
            color: #555;
        }

        .schedule-table tbody tr:hover {
            background: #f8f9fa;
            transition: background 0.3s;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-berlangsung {
            background: #d4edda;
            color: #155724;
        }

        .status-akan-datang {
            background: #fff3cd;
            color: #856404;
        }

        .status-selesai {
            background: #d1ecf1;
            color: #0c5460;
        }

        .status-dibatalkan {
            background: #f8d7da;
            color: #721c24;
        }

        .no-data {
            text-align: center;
            padding: 40px;
            color: #999;
            font-style: italic;
        }
    </style>
</head>
<body>
    
    <div class="header">
        <div class="logo-section">
            <div class="logo">
                <img src="logo unesa.png" alt="Logo UNESA">
            </div>
            <div class="university-info">
                <h1>Universitas Negeri Surabaya</h1>
                <p>Teknik Informatika - Sistem Informasi Jadwal Kuliah</p>
            </div>
        </div>
        <div class="clock-section">
            <div class="digital-clock" id="clock">00:00:00</div>
            <div class="date-display" id="date">Minggu, 1 Januari 2024</div>
        </div>
    </div>

    <div class="container">
        <div class="filter-section">
            <div class="filter-group">
                <label for="filterType">Lihat Berdasarkan:</label>
                <select class="searchable-select" id="filterType">
                    <option value="semua">Semua Jadwal</option>
                    <option value="ruangan">Lihat Ruangan</option>
                    <option value="dosen">Lihat Dosen</option>
                </select>
            </div>
            <div class="filter-group">
                <label for="filterValue">Pilih:</label>
                <input type="text" class="searchable-select" id="filterValue" placeholder="Ketik untuk mencari...">
            </div>
        </div>

        <div class="schedule-board">
            <div class="board-header">
                JADWAL KULIAH HARI INI
            </div>
            <table class="schedule-table">
                <thead>
                    <tr>
                        <th>Hari</th>
                        <th>Jam</th>
                        <th>Kode Matkul</th>
                        <th>Mata Kuliah</th>
                        <th>Dosen</th>
                        <th>Ruangan</th>
                        <th>Kelas</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody id="scheduleBody">
                    <!-- Data dari PHP akan diisi di sini -->
                     <?php
                    // Query JOIN untuk mengambil Nama Kelas asli
                    $sql = "SELECT p.*, k.NAMA_KELAS, mk.NAMA_MATKUL, d.NAMA_DOSEN, r.NAMA_RUANGAN 
                            FROM penjadwalan p
                            JOIN kelas k ON p.ID_KELAS = k.ID_KELAS
                            JOIN mata_kuliah mk ON p.KODE_MATKUL = mk.KODE_MATKUL
                            JOIN dosen d ON p.NIDN = d.NIDN
                            JOIN ruangan r ON p.ID_RUANGAN = r.ID_RUANGAN";

                    $query = mysqli_query($koneksi, $sql);

                    while($data = mysqli_fetch_array($query)) {
                        // Hitung Status secara otomatis berdasarkan tanggal dan waktu saat ini
                        $tanggal_sekarang = date('Y-m-d');
                        $tanggal_jadwal = isset($data['TANGGAL']) && $data['TANGGAL'] ? $data['TANGGAL'] : null;
                        
                        if ($tanggal_jadwal) {
                            // Jika ada kolom TANGGAL, gunakan untuk perhitungan status
                            if ($tanggal_jadwal < $tanggal_sekarang) {
                                // Tanggal jadwal sudah lewat
                                $status = "Selesai";
                                $warna = "background-color: #dc3545; color: white;"; // Merah
                            } elseif ($tanggal_jadwal > $tanggal_sekarang) {
                                // Tanggal jadwal masih akan datang
                                $status = "Akan Datang";
                                $warna = "background-color: #fff3cd; color: #856404;"; // Kuning
                            } else {
                                // Tanggal sama, bandingkan jam
                                if ($jam_sekarang < $data['JAM_MULAI']) {
                                    $status = "Akan Datang";
                                    $warna = "background-color: #fff3cd; color: #856404;"; // Kuning
                                } elseif ($jam_sekarang >= $data['JAM_MULAI'] && $jam_sekarang <= $data['JAM_SELESAI']) {
                                    $status = "Sedang Berlangsung";
                                    $warna = "background-color: #28a745; color: white;"; // Hijau
                                } else {
                                    $status = "Selesai";
                                    $warna = "background-color: #dc3545; color: white;"; // Merah
                                }
                            }
                        } else {
                            // Fallback: Jika tidak ada TANGGAL, gunakan logika HARI (untuk data lama)
                            $hari_sekarang = date('N'); // 1=Senin, 2=Selasa, ..., 7=Minggu
                            $hari_jadwal = $data['HARI'];
                            
                            $hari_map = [
                                'Senin' => 1, 'Selasa' => 2, 'Rabu' => 3, 'Kamis' => 4,
                                'Jumat' => 5, 'Sabtu' => 6, 'Minggu' => 7
                            ];
                            
                            $hari_jadwal_num = isset($hari_map[$hari_jadwal]) ? $hari_map[$hari_jadwal] : 0;
                            
                            if ($hari_jadwal_num < $hari_sekarang) {
                                $status = "Selesai";
                                $warna = "background-color: #dc3545; color: white;";
                            } elseif ($hari_jadwal_num > $hari_sekarang) {
                                $status = "Akan Datang";
                                $warna = "background-color: #fff3cd; color: #856404;";
                            } else {
                                if ($jam_sekarang < $data['JAM_MULAI']) {
                                    $status = "Akan Datang";
                                    $warna = "background-color: #fff3cd; color: #856404;";
                                } elseif ($jam_sekarang >= $data['JAM_MULAI'] && $jam_sekarang <= $data['JAM_SELESAI']) {
                                    $status = "Sedang Berlangsung";
                                    $warna = "background-color: #28a745; color: white;";
                                } else {
                                    $status = "Selesai";
                                    $warna = "background-color: #dc3545; color: white;";
                                }
                            }
                        }
                    ?>
                        <tr>
                            <td><?php echo $data['HARI']; ?></td>
                            <td><?php echo $data['JAM_MULAI'] . " - " . $data['JAM_SELESAI']; ?></td>
                            <td><?php echo $data['KODE_MATKUL']; ?></td>
                            <td><?php echo $data['NAMA_MATKUL']; ?></td>
                            <td><?php echo $data['NAMA_DOSEN']; ?></td>
                            <td><?php echo $data['NAMA_RUANGAN']; ?></td>
                            <td><?php echo $data['NAMA_KELAS']; ?></td> <td>
                                <span style="color: white; padding: 4px 8px; border-radius: 4px; font-size: 11px; <?php echo $warna; ?>">
                                    <?php echo $status; ?>
                                </span>
                            </td>
                        </tr>
                    <?php } ?>
                    <tr>
                        <td>08:00 - 10:00</td>
                        <td>Basis Data</td>
                        <td>Dr. Ahmad Suryadi, M.Kom</td>
                        <td>A10-301</td>
                        <td>IF-3A</td>
                        <td><span class="status-badge status-selesai">Selesai</span></td>
                    </tr>
                    <tr>
                        <td>10:00 - 12:00</td>
                        <td>Pemrograman Web</td>
                        <td>Siti Nurhaliza, S.Kom, M.T</td>
                        <td>A10-302</td>
                        <td>IF-3B</td>
                        <td><span class="status-badge status-berlangsung">Sedang Berlangsung</span></td>
                    </tr>
                    <tr>
                        <td>13:00 - 15:00</td>
                        <td>Sistem Operasi</td>
                        <td>Budi Santoso, M.Kom</td>
                        <td>A10-303</td>
                        <td>IF-3A</td>
                        <td><span class="status-badge status-akan-datang">Akan Datang</span></td>
                    </tr>
                    <tr>
                        <td>15:00 - 17:00</td>
                        <td>Jaringan Komputer</td>
                        <td>Dr. Rina Wijaya, M.T</td>
                        <td>A10-304</td>
                        <td>IF-3C</td>
                        <td><span class="status-badge status-dibatalkan">Dibatalkan</span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        // Fungsi untuk update jam digital
        function updateClock() {
            const now = new Date();
            const hours = String(now.getHours()).padStart(2, '0');
            const minutes = String(now.getMinutes()).padStart(2, '0');
            const seconds = String(now.getSeconds()).padStart(2, '0');
            
            document.getElementById('clock').textContent = `${hours}:${minutes}:${seconds}`;
            
            // Update tanggal
            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            const dateStr = now.toLocaleDateString('id-ID', options);
            document.getElementById('date').textContent = dateStr;
        }

        // Update jam setiap detik
        setInterval(updateClock, 1000);
        updateClock();

        // Filter functionality (akan diintegrasikan dengan PHP/AJAX)
        document.getElementById('filterType').addEventListener('change', function() {
            const filterValue = document.getElementById('filterValue');
            if (this.value === 'semua') {
                filterValue.disabled = true;
                filterValue.value = '';
            } else {
                filterValue.disabled = false;
                filterValue.placeholder = `Ketik nama ${this.value}...`;
            }
        });

        // Searchable filter (implementasi sederhana)
        document.getElementById('filterValue').addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            const rows = document.querySelectorAll('#scheduleBody tr');
            
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                if (text.includes(searchTerm)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });
        document.addEventListener('DOMContentLoaded', () => {
        // Fungsi untuk mengambil data jadwal dari API
        fetch('http://localhost:3000/api/jadwal')
            .then(response => response.json())
            .then(data => {
                const scheduleBody = document.getElementById('scheduleBody');
                scheduleBody.innerHTML = ''; // Kosongkan tabel dulu

                data.forEach(item => {
                    scheduleBody.innerHTML += `
                        <tr>
                            <td>${item.HARI}</td>
                            <td>${item.JAM_MULAI} - ${item.JAM_SELESAI}</td>
                            <td>${item.KODE_MATKUL}</td>
                            <td>${item.NAMA_MATKUL}</td>
                            <td>${item.NAMA_DOSEN}</td>
                            <td>${item.NAMA_RUANGAN}</td>
                            <td>${item.ID_KELAS}</td>
                        </tr>
                    `;
                });
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Gagal memuat jadwal. Pastikan server sudah jalan!');
            });
        });
        async function loadJadwal() {
        const response = await fetch('ambil_data.php');
        const data = await response.json();
        
        const tbody = document.querySelector('tbody');
        tbody.innerHTML = ''; // Kosongkan tabel lama

        const sekarang = new Date();
        const jamSekarang = sekarang.getHours().toString().padStart(2, '0') + ":" + 
                            sekarang.getMinutes().toString().padStart(2, '0') + ":00";

        data.forEach(row => {
            // Logika Status berdasarkan tanggal dan jam
            let statusTeks = "";
            let warnaKelas = "";
            
            const tanggalSekarang = sekarang.toISOString().split('T')[0]; // Format: YYYY-MM-DD
            const tanggalJadwal = row.TANGGAL || null;
            
            if (tanggalJadwal) {
                // Jika ada kolom TANGGAL, gunakan untuk perhitungan status
                if (tanggalJadwal < tanggalSekarang) {
                    // Tanggal jadwal sudah lewat
                    statusTeks = "Selesai";
                    warnaKelas = "status-selesai";
                } else if (tanggalJadwal > tanggalSekarang) {
                    // Tanggal jadwal masih akan datang
                    statusTeks = "Akan Datang";
                    warnaKelas = "status-akan-datang";
                } else {
                    // Tanggal sama, bandingkan jam
                    if (jamSekarang < row.JAM_MULAI) {
                        statusTeks = "Akan Datang";
                        warnaKelas = "status-akan-datang";
                    } else if (jamSekarang >= row.JAM_MULAI && jamSekarang <= row.JAM_SELESAI) {
                        statusTeks = "Sedang Berlangsung";
                        warnaKelas = "status-berlangsung";
                    } else {
                        statusTeks = "Selesai";
                        warnaKelas = "status-selesai";
                    }
                }
            } else {
                // Fallback: Jika tidak ada TANGGAL, gunakan logika HARI (untuk data lama)
                const hariMap = {
                    'Senin': 1, 'Selasa': 2, 'Rabu': 3, 'Kamis': 4,
                    'Jumat': 5, 'Sabtu': 6, 'Minggu': 7
                };
                
                const hariSekarang = sekarang.getDay(); // 0=Minggu, 1=Senin, ..., 6=Sabtu
                const hariSekarangNum = hariSekarang === 0 ? 7 : hariSekarang;
                const hariJadwalNum = hariMap[row.HARI] || 0;
                
                if (hariJadwalNum < hariSekarangNum) {
                    statusTeks = "Selesai";
                    warnaKelas = "status-selesai";
                } else if (hariJadwalNum > hariSekarangNum) {
                    statusTeks = "Akan Datang";
                    warnaKelas = "status-akan-datang";
                } else {
                    if (jamSekarang < row.JAM_MULAI) {
                        statusTeks = "Akan Datang";
                        warnaKelas = "status-akan-datang";
                    } else if (jamSekarang >= row.JAM_MULAI && jamSekarang <= row.JAM_SELESAI) {
                        statusTeks = "Sedang Berlangsung";
                        warnaKelas = "status-berlangsung";
                    } else {
                        statusTeks = "Selesai";
                        warnaKelas = "status-selesai";
                    }
                }
            }

            // Masukkan ke Tabel
            tbody.innerHTML += `
                <tr>
                    <td>${row.HARI}</td>
                    <td>${row.JAM_MULAI} - ${row.JAM_SELESAI}</td>
                    <td>${row.KODE_MATKUL}</td>
                    <td>${row.NAMA_MATKUL}</td>
                    <td>${row.NAMA_DOSEN}</td>
                    <td>${row.NAMA_RUANGAN}</td>
                    <td>${row.NAMA_KELAS}</td> <td><span class="status-badge ${warnaKelas}">${statusTeks}</span></td> </tr>
            `;
        });
    }

    // Jalankan fungsi saat halaman dibuka
    loadJadwal();
    </script>
</body>
</html>