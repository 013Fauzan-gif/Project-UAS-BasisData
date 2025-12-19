const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const bodyParser = require('body-parser');

const app = express();
app.use(cors());
app.use(bodyParser.json());

// ==========================================
// 1. KONEKSI DATABASE
// ==========================================
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',      // Default user XAMPP
    password: '',      // Default password XAMPP (kosong)
    database: 'penjadwalan' // Pastikan nama ini sesuai di phpMyAdmin
});

db.connect(err => {
    if (err) {
        console.error('❌ Gagal koneksi ke Database:', err);
    } else {
        console.log('✅ Terhubung ke Database Penjadwalan!');
    }
});

// ==========================================
// 2. API ENDPOINTS (Login)
// ==========================================

// Login Admin
app.post('/api/login', (req, res) => {
    console.log('🔐 Request login diterima');
    console.log('📧 Email:', req.body.email);
    
    const { email, password } = req.body;
    
    if (!email || !password) {
        console.log('❌ Validasi gagal: Email atau password kosong');
        return res.status(400).json({ 
            status: 'fail', 
            message: 'Email dan Password wajib diisi.' 
        });
    }
    
    const sql = "SELECT * FROM users WHERE email = ? AND password = ?";
    
    db.query(sql, [email, password], (err, result) => {
        if (err) {
            console.error('❌ Error saat query login:', err);
            return res.status(500).json({ 
                status: 'fail', 
                message: 'Error saat memproses login.' 
            });
        }
        
        if (result.length > 0) {
            console.log('✅ Login berhasil untuk:', email);
            res.json({ status: 'success', user: result[0] });
        } else {
            console.log('⚠️ Login gagal: Email atau password salah untuk:', email);
            res.json({ status: 'fail', message: 'Email atau Password salah' });
        }
    });
});

// Register User
app.post('/api/register', (req, res) => {
    console.log('📥 Request registrasi diterima');
    console.log('📋 Data:', req.body);
    
    const { email, password, nama } = req.body;
    
    // Validasi input
    if (!email || !password || !nama) {
        console.log('❌ Validasi gagal: Data tidak lengkap');
        return res.status(400).json({ 
            status: 'fail', 
            message: 'Email, Password, dan Nama wajib diisi.' 
        });
    }
    
    // Cek apakah email sudah terdaftar
    const checkEmailSql = "SELECT * FROM users WHERE email = ?";
    db.query(checkEmailSql, [email], (err, result) => {
        if (err) {
            console.error('❌ Error saat memeriksa email:', err);
            return res.status(500).json({ status: 'fail', message: 'Error saat memeriksa email.' });
        }
        
        if (result.length > 0) {
            console.log('⚠️ Email sudah terdaftar:', email);
            return res.status(400).json({ 
                status: 'fail', 
                message: 'Email sudah terdaftar. Silakan gunakan email lain.' 
            });
        }
        
        // Insert user baru dengan role 'user' (bukan admin)
        const insertSql = "INSERT INTO users (email, password, nama, role) VALUES (?, ?, ?, 'user')";
        db.query(insertSql, [email, password, nama], (err, result) => {
            if (err) {
                console.error('❌ Error saat insert user:', err);
                return res.status(500).json({ 
                    status: 'fail', 
                    message: 'Gagal mendaftarkan user. Silakan coba lagi.' 
                });
            }
            
            console.log('✅ User berhasil didaftarkan:', email);
            res.json({ 
                status: 'success', 
                message: 'Registrasi berhasil! Anda dapat login sekarang.' 
            });
        });
    });
});

// ==========================================
// 3. API ENDPOINTS (Ambil Data / GET)
// ==========================================

// Ambil Data Dosen
app.get('/api/dosen', (req, res) => {
    db.query("SELECT * FROM dosen", (err, result) => {
        if (err) return res.status(500).json(err);
        res.json(result);
    });
});

// Ambil Data Ruangan
app.get('/api/ruangan', (req, res) => {
    db.query("SELECT * FROM ruangan", (err, result) => {
        if (err) return res.status(500).json(err);
        res.json(result);
    });
});

// Ambil Data Mata Kuliah
app.get('/api/matkul', (req, res) => {
    db.query("SELECT * FROM mata_kuliah", (err, result) => {
        if (err) return res.status(500).json(err);
        res.json(result);
    });
});

// Ambil Data Kelas
app.get('/api/kelas', (req, res) => {
    console.log('📚 Request GET /api/kelas diterima');
    const sql = `
        SELECT k.*, p.NAMA_PRODI 
        FROM kelas k 
        JOIN program_studi p ON k.ID_PRODI = p.ID_PRODI
        ORDER BY k.ID_KELAS
    `;
    db.query(sql, (err, result) => {
        if (err) {
            console.error('❌ Error saat query kelas:', err);
            return res.status(500).json(err);
        }
        console.log(`✅ Berhasil mengambil ${result.length} data kelas`);
        res.json(result);
    });
});

// Ambil Data Program Studi
app.get('/api/prodi', (req, res) => {
    db.query("SELECT * FROM program_studi ORDER BY ID_PRODI", (err, result) => {
        if (err) return res.status(500).json(err);
        res.json(result);
    });
});

// Tambah Kelas
app.post('/api/kelas', (req, res) => {
    const { id_kelas, id_prodi, nama_kelas, tahun_angkatan } = req.body;

    if (!id_kelas || !id_prodi || !nama_kelas || !tahun_angkatan) {
        return res.status(400).json({ message: 'ID Kelas, Program Studi, Nama Kelas, dan Tahun Angkatan wajib diisi.' });
    }

    const sql = "INSERT INTO kelas (ID_KELAS, ID_PRODI, NAMA_KELAS, TAHUN_ANGKATAN) VALUES (?, ?, ?, ?)";
    db.query(sql, [id_kelas, id_prodi, nama_kelas, tahun_angkatan], (err, result) => {
        if (err) {
            if (err.code === 'ER_DUP_ENTRY') {
                return res.status(400).json({ message: 'ID Kelas sudah terdaftar.' });
            }
            return res.status(500).json(err);
        }
        res.json({ message: 'Kelas berhasil ditambahkan.' });
    });
});

// Edit Kelas
app.put('/api/kelas/:id', (req, res) => {
    const id = req.params.id;
    const { id_kelas, id_prodi, nama_kelas, tahun_angkatan } = req.body;

    if (!id_kelas || !id_prodi || !nama_kelas || !tahun_angkatan) {
        return res.status(400).json({ message: 'ID Kelas, Program Studi, Nama Kelas, dan Tahun Angkatan wajib diisi.' });
    }

    const sql = "UPDATE kelas SET ID_KELAS = ?, ID_PRODI = ?, NAMA_KELAS = ?, TAHUN_ANGKATAN = ? WHERE ID_KELAS = ?";
    db.query(sql, [id_kelas, id_prodi, nama_kelas, tahun_angkatan, id], (err, result) => {
        if (err) {
            return res.status(500).json(err);
        }
        res.json({ message: 'Kelas berhasil diperbarui.' });
    });
});

// Hapus Kelas
app.delete('/api/kelas/:id', (req, res) => {
    const id = req.params.id;
    const sql = "DELETE FROM kelas WHERE ID_KELAS = ?";
    db.query(sql, [id], (err, result) => handleDelete(res, err, result));
});

// ==========================================
// 4. API ENDPOINTS Dosen (Tambah & Edit)
// ==========================================

// Tambah Dosen
app.post('/api/dosen', (req, res) => {
    const { nidn, nama_dosen, email_dosen } = req.body;

    if (!nidn || !nama_dosen || !email_dosen) {
        return res.status(400).json({ message: 'NIDN, Nama Dosen, dan Email wajib diisi.' });
    }

    const sql = "INSERT INTO dosen (NIDN, NAMA_DOSEN, EMAIL_DOSEN) VALUES (?, ?, ?)";
    db.query(sql, [nidn, nama_dosen, email_dosen], (err, result) => {
        if (err) {
            // Jika NIDN sudah ada (duplicate key)
            if (err.code === 'ER_DUP_ENTRY') {
                return res.status(400).json({ message: 'NIDN sudah terdaftar.' });
            }
            return res.status(500).json(err);
        }
        res.json({ message: 'Dosen berhasil ditambahkan.' });
    });
});

// Edit Dosen (berdasarkan NIDN lama di URL)
app.put('/api/dosen/:id', (req, res) => {
    const id = req.params.id; // NIDN lama
    const { nidn, nama_dosen, email_dosen } = req.body;

    if (!nidn || !nama_dosen || !email_dosen) {
        return res.status(400).json({ message: 'NIDN, Nama Dosen, dan Email wajib diisi.' });
    }

    const sql = "UPDATE dosen SET NIDN = ?, NAMA_DOSEN = ?, EMAIL_DOSEN = ? WHERE NIDN = ?";
    db.query(sql, [nidn, nama_dosen, email_dosen, id], (err, result) => {
        if (err) {
            return res.status(500).json(err);
        }
        res.json({ message: 'Dosen berhasil diperbarui.' });
    });
});

// ==========================================
// 5. API ENDPOINTS Ruangan (Tambah & Edit)
// ==========================================

// Tambah Ruangan
app.post('/api/ruangan', (req, res) => {
    const { id_ruangan, nama_ruangan, kapasitas } = req.body;

    if (!id_ruangan || !nama_ruangan || !kapasitas) {
        return res.status(400).json({ message: 'Kode, Nama, dan Kapasitas Ruangan wajib diisi.' });
    }

    const sql = "INSERT INTO ruangan (ID_RUANGAN, NAMA_RUANGAN, KAPASITAS) VALUES (?, ?, ?)";
    db.query(sql, [id_ruangan, nama_ruangan, kapasitas], (err, result) => {
        if (err) {
            if (err.code === 'ER_DUP_ENTRY') {
                return res.status(400).json({ message: 'Kode ruangan sudah terdaftar.' });
            }
            return res.status(500).json(err);
        }
        res.json({ message: 'Ruangan berhasil ditambahkan.' });
    });
});

// Edit Ruangan (berdasarkan ID_RUANGAN lama di URL)
app.put('/api/ruangan/:id', (req, res) => {
    const id = req.params.id;
    const { id_ruangan, nama_ruangan, kapasitas } = req.body;

    if (!id_ruangan || !nama_ruangan || !kapasitas) {
        return res.status(400).json({ message: 'Kode, Nama, dan Kapasitas Ruangan wajib diisi.' });
    }

    const sql = "UPDATE ruangan SET ID_RUANGAN = ?, NAMA_RUANGAN = ?, KAPASITAS = ? WHERE ID_RUANGAN = ?";
    db.query(sql, [id_ruangan, nama_ruangan, kapasitas, id], (err, result) => {
        if (err) {
            return res.status(500).json(err);
        }
        res.json({ message: 'Ruangan berhasil diperbarui.' });
    });
});

// ==========================================
// 6. API ENDPOINTS Mata Kuliah (Tambah & Edit)
// ==========================================

// Tambah Mata Kuliah
app.post('/api/matkul', (req, res) => {
    const { kode_matkul, nama_matkul, sks } = req.body;

    if (!kode_matkul || !nama_matkul || !sks) {
        return res.status(400).json({ message: 'Kode, Nama Mata Kuliah, dan SKS wajib diisi.' });
    }

    const sql = "INSERT INTO mata_kuliah (KODE_MATKUL, NAMA_MATKUL, SKS) VALUES (?, ?, ?)";
    db.query(sql, [kode_matkul, nama_matkul, sks], (err, result) => {
        if (err) {
            if (err.code === 'ER_DUP_ENTRY') {
                return res.status(400).json({ message: 'Kode mata kuliah sudah terdaftar.' });
            }
            return res.status(500).json(err);
        }
        res.json({ message: 'Mata kuliah berhasil ditambahkan.' });
    });
});

// Edit Mata Kuliah (berdasarkan KODE_MATKUL lama di URL)
app.put('/api/matkul/:id', (req, res) => {
    const id = req.params.id;
    const { kode_matkul, nama_matkul, sks } = req.body;

    if (!kode_matkul || !nama_matkul || !sks) {
        return res.status(400).json({ message: 'Kode, Nama Mata Kuliah, dan SKS wajib diisi.' });
    }

    const sql = "UPDATE mata_kuliah SET KODE_MATKUL = ?, NAMA_MATKUL = ?, SKS = ? WHERE KODE_MATKUL = ?";
    db.query(sql, [kode_matkul, nama_matkul, sks, id], (err, result) => {
        if (err) {
            return res.status(500).json(err);
        }
        res.json({ message: 'Mata kuliah berhasil diperbarui.' });
    });
});

// ==========================================
// 7. API ENDPOINTS (Hapus Data / DELETE)
// ==========================================

// Fungsi Bantuan: Menangani error jika data sedang dipakai (Foreign Key)
const handleDelete = (res, err, result) => {
    if (err) {
        // Error 1451: Cannot delete or update a parent row (Foreign Key Constraint)
        if (err.errno === 1451) {
            return res.status(400).json({ 
                message: "Gagal: Data tidak bisa dihapus karena sedang dipakai di tabel Jadwal/Kelas." 
            });
        }
        return res.status(500).json(err);
    }
    res.json({ message: "Berhasil dihapus" });
};

// Hapus Dosen (Berdasarkan NIDN)
app.delete('/api/dosen/:id', (req, res) => {
    const id = req.params.id;
    const sql = "DELETE FROM dosen WHERE NIDN = ?";
    db.query(sql, [id], (err, result) => handleDelete(res, err, result));
});

// Hapus Ruangan (Berdasarkan ID_RUANGAN)
app.delete('/api/ruangan/:id', (req, res) => {
    const id = req.params.id;
    const sql = "DELETE FROM ruangan WHERE ID_RUANGAN = ?";
    db.query(sql, [id], (err, result) => handleDelete(res, err, result));
});

// Hapus Mata Kuliah (Berdasarkan KODE_MATKUL)
app.delete('/api/matkul/:id', (req, res) => {
    const id = req.params.id;
    const sql = "DELETE FROM mata_kuliah WHERE KODE_MATKUL = ?"; 
    db.query(sql, [id], (err, result) => handleDelete(res, err, result));
});

// ==========================================
// 8. API ENDPOINTS (Lainnya)
// ==========================================

// API untuk Mahasiswa/Publik (Melihat semua jadwal)
app.get('/api/jadwal', (req, res) => {
    const sql = `
        SELECT p.*, d.NAMA_DOSEN, m.NAMA_MATKUL, r.NAMA_RUANGAN 
        FROM penjadwalan p
        JOIN dosen d ON p.NIDN = d.NIDN
        JOIN mata_kuliah m ON p.KODE_MATKUL = m.KODE_MATKUL
        JOIN ruangan r ON p.ID_RUANGAN = r.ID_RUANGAN
        ORDER BY FIELD(p.HARI, 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'), p.JAM_MULAI
    `;
    
    db.query(sql, (err, result) => {
        if (err) return res.status(500).json(err);
        res.json(result);
    });
});

// Tambah Jadwal
app.post('/api/jadwal', (req, res) => {
    console.log('📅 Request POST /api/jadwal diterima');
    console.log('📋 Data:', req.body);
    
    const { hari, tanggal, jam_mulai, jam_selesai, nidn, kode_matkul, id_ruangan, id_kelas } = req.body;

    if (!hari || !tanggal || !jam_mulai || !jam_selesai || !nidn || !kode_matkul || !id_ruangan || !id_kelas) {
        return res.status(400).json({ 
            message: 'Hari, Tanggal, Jam Mulai, Jam Selesai, Dosen, Mata Kuliah, Ruangan, dan Kelas wajib diisi.' 
        });
    }

    // Cek apakah kolom TANGGAL sudah ada, jika belum tambahkan
    db.query("SHOW COLUMNS FROM penjadwalan LIKE 'TANGGAL'", (err, result) => {
        if (err) {
            console.error('❌ Error saat cek kolom TANGGAL:', err);
        }
        
        // Jika kolom TANGGAL belum ada, tambahkan
        if (result.length === 0) {
            db.query("ALTER TABLE penjadwalan ADD COLUMN TANGGAL DATE AFTER HARI", (alterErr) => {
                if (alterErr) {
                    console.error('❌ Error saat menambahkan kolom TANGGAL:', alterErr);
                } else {
                    console.log('✅ Kolom TANGGAL berhasil ditambahkan');
                }
            });
        }
    });

    const sql = "INSERT INTO penjadwalan (HARI, TANGGAL, JAM_MULAI, JAM_SELESAI, NIDN, KODE_MATKUL, ID_RUANGAN, ID_KELAS) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    db.query(sql, [hari, tanggal, jam_mulai, jam_selesai, nidn, kode_matkul, id_ruangan, id_kelas], (err, result) => {
        if (err) {
            console.error('❌ Error saat insert jadwal:', err);
            // Jika error karena kolom TANGGAL belum ada, coba lagi tanpa TANGGAL
            if (err.code === 'ER_BAD_FIELD_ERROR' && err.sqlMessage.includes('TANGGAL')) {
                const sqlWithoutDate = "INSERT INTO penjadwalan (HARI, JAM_MULAI, JAM_SELESAI, NIDN, KODE_MATKUL, ID_RUANGAN, ID_KELAS) VALUES (?, ?, ?, ?, ?, ?, ?)";
                db.query(sqlWithoutDate, [hari, jam_mulai, jam_selesai, nidn, kode_matkul, id_ruangan, id_kelas], (err2, result2) => {
                    if (err2) {
                        return res.status(500).json({ 
                            message: 'Gagal menyimpan jadwal. Silakan coba lagi.' 
                        });
                    }
                    return res.json({ message: 'Jadwal berhasil ditambahkan (tanpa tanggal).' });
                });
            } else {
                return res.status(500).json({ 
                    message: 'Gagal menyimpan jadwal. Silakan coba lagi.' 
                });
            }
        } else {
            console.log('✅ Jadwal berhasil disimpan, ID:', result.insertId);
            res.json({ message: 'Jadwal berhasil ditambahkan.' });
        }
    });
});

// ==========================================
// 9. JALANKAN SERVER
// ==========================================
app.listen(3000, () => {
    console.log('🚀 Server berjalan di http://localhost:3000');
});