-- SQL Script untuk membuat tabel siswa di Supabase
-- Jalankan script ini di SQL Editor di Supabase Dashboard

CREATE TABLE students (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    nisn VARCHAR(20) UNIQUE NOT NULL,
    nama_lengkap VARCHAR(255) NOT NULL,
    jenis_kelamin VARCHAR(10) NOT NULL CHECK (jenis_kelamin IN ('Laki-laki', 'Perempuan')),
    agama VARCHAR(50) NOT NULL,
    tempat_lahir VARCHAR(100) NOT NULL,
    tanggal_lahir DATE NOT NULL,
    nomor_tlp VARCHAR(15) NOT NULL,
    nik VARCHAR(16) UNIQUE NOT NULL,
    
    -- Alamat
    jalan TEXT NOT NULL,
    rt_rw VARCHAR(20) NOT NULL,
    dusun VARCHAR(100) NOT NULL,
    desa VARCHAR(100) NOT NULL,
    kecamatan VARCHAR(100) NOT NULL,
    kabupaten VARCHAR(100) NOT NULL,
    provinsi VARCHAR(100) NOT NULL,
    kode_pos VARCHAR(10) NOT NULL,
    
    -- Orang Tua/Wali
    nama_ayah VARCHAR(255) NOT NULL,
    nama_ibu VARCHAR(255) NOT NULL,
    nama_wali VARCHAR(255),
    alamat_orang_tua TEXT NOT NULL,
    
    -- Timestamps
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Membuat index untuk pencarian yang lebih cepat
CREATE INDEX idx_students_nisn ON students(nisn);
CREATE INDEX idx_students_nama ON students(nama_lengkap);
CREATE INDEX idx_students_nik ON students(nik);

-- Membuat trigger untuk update timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_students_updated_at 
    BEFORE UPDATE ON students 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- Insert data sample (opsional)
INSERT INTO students (
    nisn, nama_lengkap, jenis_kelamin, agama, tempat_lahir, tanggal_lahir,
    nomor_tlp, nik, jalan, rt_rw, dusun, desa, kecamatan, kabupaten, 
    provinsi, kode_pos, nama_ayah, nama_ibu, alamat_orang_tua
) VALUES (
    '1234567890', 'Ahmad Rizki Pratama', 'Laki-laki', 'Islam', 'Jakarta', '2005-03-15',
    '081234567890', '1234567890123456', 'Jl. Merdeka No. 123', '001/002', 'Dusun A',
    'Desa Sukamaju', 'Kecamatan Sukajadi', 'Kabupaten Bandung', 'Jawa Barat', '40123',
    'Budi Pratama', 'Siti Aminah', 'Jl. Merdeka No. 123, RT 001/002, Dusun A, Desa Sukamaju'
);





-- Mengisi tabel locations dengan data lengkap dari 4 kecamatan
-- (Dibersihkan dan diformat untuk menghindari duplikat atau error)
INSERT INTO locations (dusun, desa, kecamatan, kabupaten, kode_pos) VALUES
-- KECAMATAN KALIPARE (Kabupaten Malang, Kode Pos 65171)
('Babatan', 'Arjosari', 'Kalipare', 'Kabupaten Malang', '65171'),
('Gabos', 'Arjosari', 'Kalipare', 'Kabupaten Malang', '65171'),
('Kedungwaru I', 'Arjosari', 'Kalipare', 'Kabupaten Malang', '65171'),
('Kedungwaru II', 'Arjosari', 'Kalipare', 'Kabupaten Malang', '65171'),
('Mentaraman', 'Arjosari', 'Kalipare', 'Kabupaten Malang', '65171'),
('Sumbertimo', 'Arjosari', 'Kalipare', 'Kabupaten Malang', '65171'),
('Tumpakmiri', 'Arjosari', 'Kalipare', 'Kabupaten Malang', '65171'),
('Barisan', 'Arjowilangun', 'Kalipare', 'Kabupaten Malang', '65171'),
('Bengkok', 'Arjowilangun', 'Kalipare', 'Kabupaten Malang', '65171'),
('Bonsari', 'Arjowilangun', 'Kalipare', 'Kabupaten Malang', '65171'),
('Dung Gampar', 'Arjowilangun', 'Kalipare', 'Kabupaten Malang', '65171'),
('Duren', 'Arjowilangun', 'Kalipare', 'Kabupaten Malang', '65171'),
('Lodalem', 'Arjowilangun', 'Kalipare', 'Kabupaten Malang', '65171'),
('Lotekol', 'Arjowilangun', 'Kalipare', 'Kabupaten Malang', '65171'),
('Panggang Lele', 'Arjowilangun', 'Kalipare', 'Kabupaten Malang', '65171'),
('Kaliombo', 'Kaliasri', 'Kalipare', 'Kabupaten Malang', '65171'),
('Kalitelo', 'Kaliasri', 'Kalipare', 'Kabupaten Malang', '65171'),
('Umbuldawe', 'Kaliasri', 'Kalipare', 'Kabupaten Malang', '65171'),
('Umbulsari', 'Kaliasri', 'Kalipare', 'Kabupaten Malang', '65171'),
('Kaliasem', 'Kalipare', 'Kalipare', 'Kabupaten Malang', '65171'),
('Kampung Ledok', 'Kalipare', 'Kalipare', 'Kabupaten Malang', '65171'),
('Kauman', 'Kalipare', 'Kalipare', 'Kabupaten Malang', '65171'),
('Krajan', 'Kalipare', 'Kalipare', 'Kabupaten Malang', '65171'),
('Ngembul', 'Kalipare', 'Kalipare', 'Kabupaten Malang', '65171'),
('Pitrang', 'Kalipare', 'Kalipare', 'Kabupaten Malang', '65171'),
('Pohjejer', 'Kalipare', 'Kalipare', 'Kabupaten Malang', '65171'),
('Sumber Klampok', 'Kalipare', 'Kalipare', 'Kabupaten Malang', '65171'),
('Sumber Kombang', 'Kalipare', 'Kalipare', 'Kabupaten Malang', '65171'),
('Sumber Maron', 'Kalipare', 'Kalipare', 'Kabupaten Malang', '65171'),
('Darungan', 'Kalirejo', 'Kalipare', 'Kabupaten Malang', '65171'),
('Kidul Gunung', 'Kalirejo', 'Kalipare', 'Kabupaten Malang', '65171'),
('Singkil', 'Kalirejo', 'Kalipare', 'Kabupaten Malang', '65171'),
('Alas Tledek', 'Putukrejo', 'Kalipare', 'Kabupaten Malang', '65171'),
('Krajan 1', 'Putukrejo', 'Kalipare', 'Kabupaten Malang', '65171'),
('Krajan 2', 'Putukrejo', 'Kalipare', 'Kabupaten Malang', '65171'),
('Krajan 3', 'Putukrejo', 'Kalipare', 'Kabupaten Malang', '65171'),
('Cungkal', 'Sumberpetung', 'Kalipare', 'Kabupaten Malang', '65171'),
('Pondokkobong', 'Sumberpetung', 'Kalipare', 'Kabupaten Malang', '65171'),
('Banduarjo', 'Sumberpetung', 'Kalipare', 'Kabupaten Malang', '65171'),
('Kampung Baru', 'Sukowilangun', 'Kalipare', 'Kabupaten Malang', '65171'),
('Kopral', 'Sukowilangun', 'Kalipare', 'Kabupaten Malang', '65171'),
('Sukorejo (Rekesan)', 'Sukowilangun', 'Kalipare', 'Kabupaten Malang', '65171'),
('Tawang', 'Sukowilangun', 'Kalipare', 'Kabupaten Malang', '65171'),
('Bulurejo', 'Tumpakrejo', 'Kalipare', 'Kabupaten Malang', '65171'),
('Krajan 1', 'Tumpakrejo', 'Kalipare', 'Kabupaten Malang', '65171'),
('Krajan 2', 'Tumpakrejo', 'Kalipare', 'Kabupaten Malang', '65171'),
('Sumbersari', 'Tumpakrejo', 'Kalipare', 'Kabupaten Malang', '65171'),

-- KECAMATAN SELOREJO (Kabupaten Blitar, Kode Pos 66192)
('Dusun Selorejo', 'Selorejo', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Brumbung', 'Selorejo', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Darungan', 'Selorejo', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Sidomulyo', 'Sidomulyo', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Kebonroto', 'Sidomulyo', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Gunungsari', 'Sidomulyo', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Ngepal', 'Sidomulyo', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Siderejo', 'Sidomulyo', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Pohgajih', 'Pohgajih', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Etan Kali', 'Pohgajih', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Lor Kandang', 'Pohgajih', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Mbalokan', 'Pohgajih', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Puthuk', 'Pohgajih', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Recoulo', 'Pohgajih', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Soponyono', 'Pohgajih', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Sumbernongko', 'Pohgajih', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Tambangan', 'Pohgajih', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Templek', 'Pohgajih', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Watulumbung', 'Pohgajih', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Watupecah', 'Pohgajih', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Winong', 'Pohgajih', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Boro', 'Boro', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Jarangan', 'Boro', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Buneng', 'Boro', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusum Cobaan', 'Boro', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Jeding', 'Boro', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Mintorangan', 'Boro', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Ngreco', 'Ngreco', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Baru', 'Ngreco', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Ngaglik', 'Ngreco', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Olak Alen', 'Olak Alen', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Dawung', 'Olak Alen', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Sumberjo', 'Olak Alen', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Sumberkotes', 'Olak Alen', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Sumberagung', 'Sumberagung', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Kepel', 'Sumberagung', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Sumberwader', 'Sumberagung', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Ampelgading', 'Ampelgading', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Babadan', 'Ampelgading', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Kali Leso', 'Ampelgading', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Kali Telu', 'Ampelgading', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Suberarum', 'Ampelgading', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Sumbertekek', 'Ampelgading', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Tegalrejo', 'Ampelgading', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Ngrendeng', 'Ngrendeng', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Sigaran', 'Ngrendeng', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Sumberjo', 'Ngrendeng', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Watu', 'Ngrendeng', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Gandul', 'Ngrendeng', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Kalilegi', 'Banjarsari', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Lungur Buntung', 'Banjarsari', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusun Lungur Kulon', 'Banjarsari', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Dusum Ngebrukan', 'Banjarsari', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Pakel', 'Banjarsari', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Pakel Sigaran', 'Banjarsari', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Sumberingin', 'Banjarsari', 'Selorejo', 'Kabupaten Blitar', '66192'),
('Tempursari', 'Banjarsari', 'Selorejo', 'Kabupaten Blitar', '66192'),
-- KECAMATAN KROMENGAN (Kabupaten Malang, Kode Pos 65164)
('Dusun Krajan', 'Jambuwer', 'Kromengan', 'Kabupaten Malang', '65164'),
('Dusun Glagaharum', 'Jambuwer', 'Kromengan', 'Kabupaten Malang', '65164'),
('Dusun Bulupogog', 'Jambuwer', 'Kromengan', 'Kabupaten Malang', '65164'),
('Dusun Cakru’an', 'Jambuwer', 'Kromengan', 'Kabupaten Malang', '65164'),
('Dusun Rekesan', 'Jambuwer', 'Kromengan', 'Kabupaten Malang', '65164'),
('Dusun Cupak', 'Jatikerto', 'Kromengan', 'Kabupaten Malang', '65164'),
('Dusun Bedali', 'Jatikerto', 'Kromengan', 'Kabupaten Malang', '65164'),
('Dusun Karanganyar', 'Karangrejo', 'Kromengan', 'Kabupaten Malang', '65164'),
('Dusun Bendorejo', 'Karangrejo', 'Kromengan', 'Kabupaten Malang', '65164'),
('Dusun Krantil', 'Karangrejo', 'Kromengan', 'Kabupaten Malang', '65164'),
('Dusun Krajan', 'Kromengan', 'Kromengan', 'Kabupaten Malang', '65164'),
('Dusun Ringinanom', 'Kromengan', 'Kromengan', 'Kabupaten Malang', '65164'),
('Dusun Balokan', 'Kromengan', 'Kromengan', 'Kabupaten Malang', '65164'),
('Dusun Ringin Pitu', 'Peniwen', 'Kromengan', 'Kabupaten Malang', '65164'),
('Dusun Kampung Tengah', 'Peniwen', 'Kromengan', 'Kabupaten Malang', '65164'),
('Dusun Kalongan', 'Peniwen', 'Kromengan', 'Kabupaten Malang', '65164'),
('Dusun Sidokerto', 'Peniwen', 'Kromengan', 'Kabupaten Malang', '65164'),
('Dusun Krajan', 'Peniwen', 'Kromengan', 'Kabupaten Malang', '65164'),
('Dusun Sumbersari', 'Peniwen', 'Kromengan', 'Kabupaten Malang', '65164'),
('Dusun Glidag', 'Slorok', 'Kromengan', 'Kabupaten Malang', '65164'),
('Desa Katen', 'Slorok', 'Kromengan', 'Kabupaten Malang', '65164'),
('Dusun Sloroko', 'Slorok', 'Kromengan', 'Kabupaten Malang', '65164'),
('Dusun Tumpak', 'Slorok', 'Kromengan', 'Kabupaten Malang', '65164'),
('Dusun Krajan', 'Ngadirejo', 'Kromengan', 'Kabupaten Malang', '65164'),
('Dusun Cendol', 'Ngadirejo', 'Kromengan', 'Kabupaten Malang', '65164'),
('Dusun Karangtengah', 'Ngadirejo', 'Kromengan', 'Kabupaten Malang', '65164'),

-- KECAMATAN SUMBERPUCUNG (Kabupaten Malang, Kode Pos 65165)
('Dusun Sumberpucung', 'Sumberpucung', 'Sumberpucung', 'Kabupaten Malang', '65165'),
('Dusun Jatimulyo', 'Jatiguwi', 'Sumberpucung', 'Kabupaten Malang', '65165'),
('Dusun Mentaraman', 'Jatiguwi', 'Sumberpucung', 'Kabupaten Malang', '65165'),
('Dusun Krajan', 'Jatiguwi', 'Sumberpucung', 'Kabupaten Malang', '65165'),
('Dusun Sidorejo', 'Sambigede', 'Sumberpucung', 'Kabupaten Malang', '65165'),
('Dusun Rejoagung', 'Sambigede', 'Sumberpucung', 'Kabupaten Malang', '65165'),
('Dusun Srigading', 'Sambigede', 'Sumberpucung', 'Kabupaten Malang', '65165'),
('dusun Pagersari', 'Sambigede', 'Sumberpucung', 'Kabupaten Malang', '65165'),
('Dusun Grogol', 'Sambigede', 'Sumberpucung', 'Kabupaten Malang', '65165'),
('Dusun Sidosari', 'Sambigede', 'Sumberpucung', 'Kabupaten Malang', '65165'),
('Dusun Mbodo', 'Ngebruk', 'Sumberpucung', 'Kabupaten Malang', '65165'),
('Dusun Senggreng krajan', 'Senggreng', 'Sumberpucung', 'Kabupaten Malang', '65165'),
('Dusun Ngrancah', 'Senggreng', 'Sumberpucung', 'Kabupaten Malang', '65165'),
('Dusun Kecepokan', 'Senggreng', 'Sumberpucung', 'Kabupaten Malang', '65165'),
('Dusun Turus', 'Ternyang', 'Sumberpucung', 'Kabupaten Malang', '65165'),
('Dusun Krajan', 'Ternyang', 'Sumberpucung', 'Kabupaten Malang', '65165'),
('Dusun Karangkates', 'Karangkates', 'Sumberpucung', 'Kabupaten Malang', '65165');

-- Verifikasi jumlah data (opsional)
SELECT COUNT(*) FROM locations;
-- Atau lihat sample: SELECT * FROM locations LIMIT 10;
