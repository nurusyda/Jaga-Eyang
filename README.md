# ❤️ Jaga Eyang

> **Lini pertahanan penipuan digital pertama yang dirancang inklusif untuk lansia Indonesia.**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Powered by Amazon Nova](https://img.shields.io/badge/Powered%20by-Amazon%20Nova%202%20Lite-orange?logo=amazonaws)](https://aws.amazon.com/nova/)
[![PWA Ready](https://img.shields.io/badge/PWA-Tanpa%20Instalasi-success)](https://developer.mozilla.org/en-US/docs/Web/Progressive_web_apps)
[![UU PDP Compliant](https://img.shields.io/badge/UU%20PDP%202022-Compliant-blue)](https://peraturan.bpk.go.id/Details/229798/uu-no-27-tahun-2022)

<p align="center">
  <a href="http://jagaeyang-env-1.eba-nqxpqa2h.us-east-1.elasticbeanstalk.com/">
    <img src="https://img.shields.io/badge/Coba%20Jaga%20Eyang%20%E2%9D%A4%EF%B8%8F-orange?style=for-the-badge&logo=rocket&logoColor=white" alt="Launch App">
  </a>
</p>

**Coba langsung →** Ketuk tombol oranye di atas — bisa langsung dari ponsel, tanpa instalasi, tanpa login.
Cukup **4 ketukan** untuk mengecek screenshot pesan mencurigakan.

Setiap hari, lansia Indonesia menerima undangan pernikahan palsu, peringatan rekening diblokir, permintaan verifikasi OTP, hingga berita hoaks yang memancing kepanikan — seringkali disertai file .apk berbahaya. Satu ketukan salah bisa menguras tabungan seumur hidup.

**Jaga Eyang** memungkinkan lansia menganalisis screenshot pesan mencurigakan, mendapat hasil analisis berkode warna, dan meneruskan peringatan ke anak/cucu via WhatsApp — semua dalam 4 ketukan, tanpa login, tanpa iklan, tanpa penjualan data.

---

## 🧭 Mengapa Ini Dibuat

Lansia di sekitar saya sering menerima pesan manipulatif berkedok instansi resmi — berita yang dipotong untuk memancing kepanikan, atau file .apk yang menguras rekening dalam hitungan menit. Solusi yang ada terlalu rumit untuk mereka gunakan saat panik.

Indonesia menduduki peringkat **111 dari 112 negara** paling rentan penipuan digital (Sumsub, 2025), dengan kerugian **Rp9,1 triliun** dari 432.637 aduan (OJK/IASC, 2026). Kelompok usia 51-79 tahun memiliki indeks literasi keuangan digital hanya **52,51%** — terendah kedua nasional (SNLIK OJK, 2024).

Jaga Eyang hadir untuk memberdayakan mereka — bukan menghakimi, tapi mendampingi.

---

## ✨ Fitur Utama

- **4 Ketukan** — Buka app → Ketuk unggah → Pilih screenshot → Terima hasil dalam 10-45 detik
- **Kode Warna Sederhana** dengan emoji besar:
  - ✅ **Aman** (hijau) — Konten asli dan tidak berbahaya
  - ❌ **Bahaya / Scam** (merah) — Penipuan aktif, jangan diklik
  - 🤖 **Gambar AI** (abu) — Foto buatan komputer, bukan foto asli
  - 👨‍👩‍👧‍👦 **Konten Sensitif** (ungu) — Tanya anak/cucu dulu
  - 📰 **Viral / Clickbait** (kuning) — Berita rantai, kemungkinan tidak akurat
- **Pesan Empatik** — Output 2 kalimat dalam bahasa hangat layaknya saran cucu, bukan peringatan teknis
- **Privasi Terlindungi** — OCR lokal + redaksi otomatis menyensor nomor HP/rekening **sebelum** data menyentuh AI (patuh UU PDP 2022)
- **Kirim ke Anak/Cucu** — Integrasi WhatsApp untuk mengaktifkan jaring pengaman keluarga
- **Riwayat Pengecekan** — 3 hasil terakhir tersimpan lokal di perangkat, mudah dihapus
- **Dark Mode** — Mendukung preferensi visual berbeda
- **PWA Tanpa Instalasi** — Berjalan di browser, tanpa app store, tanpa akun

---

## 📱 Screenshot

| Beranda (Mode Terang) | Beranda (Mode Gelap) | Loading |
|---|---|---|
| ![Beranda Terang](Screenshots/Homepage_Light_Mode.png) | ![Beranda Gelap](Screenshots/Homepage_Dark_Mode.png) | ![Loading](Screenshots/Loading.png) |

| ❌ Bahaya (Scam) | ✅ Aman | 📰 Viral (Clickbait) |
|---|---|---|
| ![Scam](Screenshots/Red_Scam.png) | ![Aman](Screenshots/Green_Safe.png) | ![Viral](Screenshots/Yellow_Viral.png) |

| 👨‍👩‍👧‍👦 Sensitif | 🤖 Gambar AI | 📜 Riwayat & WhatsApp |
|---|---|---|
| ![Sensitif](Screenshots/Purple_Sensitive.png) | ![AI Image](Screenshots/Grey_AI_Image.png) | ![Riwayat](Screenshots/History_WhatsApp.png) |

---

## 🏗️ Arsitektur Sistem

```
[Lansia / PWA]
      |
      | HTTPS (Base64 Image)
      ↓
[FastAPI Backend — AWS Elastic Beanstalk]
      |
      ├── Tesseract OCR → Ekstraksi Teks Spasial
      ├── Regex PII Scrubber → Sensor HP / Rekening / Email
      |
      ├── Amazon Nova Call 1 — Detective
      |     └── Analisis visual + semantik → JSON klasifikasi risiko
      |
      └── Amazon Nova Call 2 — Grandchild
            └── Transformasi temuan → Pesan empatik 2 kalimat
      |
      ↓
[JSON Response → PWA]
      └── Kartu Warna + Tombol WhatsApp
```

### Kategori Hasil

| Kategori | Warna | Deskripsi |
|---|---|---|
| `scam` | 🔴 Merah | Penipuan aktif, phishing, permintaan uang/data |
| `safe` | 🟢 Hijau | Konten aman dan asli |
| `viral` | 🟡 Kuning | Clickbait atau berita rantai, kemungkinan tidak akurat |
| `sensitive` | 🟣 Ungu | Konten politik atau provokatif |
| `ai_image` | ⚫ Abu | Gambar buatan komputer (AI-generated) |

---

## 🛡️ Keamanan & Privasi

Jaga Eyang dirancang **privacy-first** dari baris kode pertama:

| Lapisan | Implementasi |
|---|---|
| **Redaksi PII Otomatis** | Tesseract OCR + Regex menyensor HP/rekening/email sebelum diproses AI |
| **Stateless Processing** | Data dihapus otomatis pasca-analisis, tanpa penyimpanan permanen |
| **Prompt Injection Prevention** | OCR dibatasi 4.000 karakter, semua input diperlakukan sebagai untrusted |
| **Rate Limiting** | 15 request/menit per IP mencegah penyalahgunaan |
| **Audit Logging** | AWS CloudTrail mencatat setiap pemrosesan secara transparan |
| **Least-Privilege IAM** | Custom policy AWS membatasi akses hanya pada resource yang diperlukan |
| **UU PDP 2022** | Seluruh arsitektur patuh regulasi pelindungan data pribadi Indonesia |

---

## 🧰 Tech Stack

```
Frontend       : HTML/CSS/JS — PWA (Web Manifest + Service Worker)
Backend        : Python 3.12 + FastAPI + Uvicorn
OCR Engine     : Tesseract OCR (LSTM-based) + pytesseract
AI Model       : Amazon Nova 2 Lite (Multimodal — Vision + Text)
Infrastructure : AWS Elastic Beanstalk + AWS CloudTrail
Image Process  : Pillow (PIL)
HTTP Client    : httpx (async dengan retry logic)
Rate Limiting  : cachetools TTLCache
Container      : Docker + tini
```

---

## ⚙️ Pipeline Detail

### Step 1 — Sanitasi & Redaksi PII
```python
# Tesseract ekstrak teks spasial dari gambar
data = pytesseract.image_to_data(image, output_type=Output.DICT)

# Regex mendeteksi dan menyensor PII secara otomatis
pii_pattern = re.compile(
    r'(?P<email>[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})|'
    r'(?P<credit_card>\b\d{4}[-.\s]?\d{4}[-.\s]?\d{4}[-.\s]?\d{4}\b)|'
    r'(?P<phone>\+?\d{1,3}[-.\s()]*\d{1,4}[-.\s()]*\d{3,4}[-.\s()]*\d{4,})'
)
# PII → piksel hitam pada gambar + [REDACTED] pada teks OCR
```

### Step 2 — Detective Analysis (Nova Call 1)
```
Input  : Gambar tersanitasi + teks OCR (maks. 4.000 karakter)
Output : { category, is_ai, ai_score, scam_probability,
           dominant_language, technical_findings }
Temp   : 0.0 (deterministik, konsisten)
```

### Step 3 — Empathy Translation (Nova Call 2)
```
Input  : Temuan teknis dari Step 2
Output : { title, grandma_reply }
Tone   : Hangat, tanpa jargon, dalam bahasa dominan pesan
Temp   : 0.0
```

---

## 🚀 Instalasi & Menjalankan Lokal

### Prasyarat
- Python 3.12+
- [Tesseract OCR](https://github.com/tesseract-ocr/tesseract) terinstal di sistem
- Amazon Nova API Key

### Setup

```bash
# Clone repository
git clone https://github.com/nurusyda/jaga-eyang.git
cd jaga-eyang

# Install dependencies
pip install -r requirements.txt

# Konfigurasi environment
cp .env.example .env
# Edit .env dan isi NOVA_API_KEY

# Jalankan server
uvicorn main:app --host 0.0.0.0 --port 8000 --reload
```

### Docker

```bash
docker build -t jaga-eyang .
docker run -p 8000:8000 --env-file .env jaga-eyang
```

### Environment Variables

| Variable | Deskripsi | Wajib |
|---|---|---|
| `NOVA_API_KEY` | API key untuk Amazon Nova | ✅ |
| `TESSERACT_CMD` | Path Tesseract (Windows only) | Windows only |
| `USE_IDEMPOTENCY` | Aktifkan idempotency key (default: true) | ❌ |
| `PORT` | Port server (default: 8000) | ❌ |

---

## 📁 Struktur Proyek

```
jaga-eyang/
├── main.py              # FastAPI app, routes, pipeline utama
├── prompts.py           # STEP1_ANALYSIS_PROMPT + STEP2_EMPATHY_PROMPT
├── requirements.txt     # Python dependencies
├── Dockerfile           # Container config dengan tini
├── .env.example         # Template environment variables
├── templates/
│   └── index.html       # PWA frontend (single file)
├── static/
│   ├── logo-192.png
│   ├── logo-512.png
│   └── apple-touch-icon.png
└── Screenshots/         # Screenshot untuk README
```

---

## 🔌 API Reference

### `POST /analyze`

**Request:**
```json
{
  "base64": "<base64-encoded-image>",
  "mime": "jpeg"
}
```

**Response:**
```json
{
  "category": "scam",
  "is_ai": false,
  "dominant_language": "id",
  "title": "🚨 WASPADA PENIPUAN!",
  "grandma_reply": "🚨 Eyang, ini penipuan! Jangan klik apapun atau transfer uang. Hubungi anak/cucu segera. ❤️"
}
```

**Rate Limit:** 15 request/menit per IP

---

### `GET /health`

```json
{ "status": "healthy", "timestamp": 1234567890.0 }
```

---

## 📊 Perbandingan dengan Solusi Lain

| Fitur | Jaga Eyang | Kredibel | Truecaller | SATSPAM+ | tanya.fadli.id | CekRekening.id |
|---|---|---|---|---|---|---|
| Analisis screenshot | ✅ | ❌ | ❌ | ❌ | ✅ | ❌ |
| Redaksi PII otomatis | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Antarmuka khusus lansia | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Tanpa instalasi/login | ✅ | ❌ | ❌ | ❌ | ✅ | ✅ |
| Deteksi gambar AI | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Gratis untuk pengguna | ✅ | ✅ | ❌ | ❌ | ✅ | ✅ |
| Operator-agnostic | ✅ | ✅ | ✅ | ❌ | ✅ | ✅ |

> **Catatan:** CekRekening.id (Kominfo) adalah alat pelaporan reaktif yang memerlukan input nomor rekening/telepon secara manual. Jaga Eyang bersifat proaktif dan komplementer — menganalisis konten pesan secara otomatis sebelum pengguna mengetahui adanya nomor mencurigakan.

---

## 📚 Referensi

1. BPS. (2023). [Proyeksi Penduduk Indonesia 2020-2050](https://www.bps.go.id/id/publication/2023/05/16/fad83131cd3bb9be3bb2a657/proyeksi-penduduk-indonesia-2020-2050-hasil-sensus-penduduk-2020.html)
2. OJK/IASC. (2026). [Siaran Pers SP 15/GKPB/OJK/I/2026](https://ojk.go.id/id/berita-dan-kegiatan/siaran-pers/Pages/IASC-Berhasil-Kembalikan-Rp161-Miliar-Dana-Masyarakat-Korban-Scam.aspx)
3. OJK. (2024). [SNLIK 2024 — Literasi & Inklusi Keuangan](https://ojk.go.id/id/berita-dan-kegiatan/publikasi/Pages/Survei-Nasional-Literasi-dan-Inklusi-Keuangan-(SNLIK)-2024.aspx)
4. OJK. (2024). [POJK No. 12 Tahun 2024 — Strategi Anti Fraud LJK](https://ojk.go.id/id/regulasi/Pages/Penerapan-Strategi-Anti-Fraud-Bagi-Lembaga-Jasa-Keuangan.aspx)
5. Sumsub. (2025). [2nd Global Fraud Index](https://www.prnewswire.com/apac/news-releases/asia-pacific-falls-behind-in-fraud-protection-according-to-sumsubs-2nd-global-fraud-index-302579271.html)
6. [UU No. 27 Tahun 2022 tentang Pelindungan Data Pribadi](https://peraturan.bpk.go.id/Details/229798/uu-no-27-tahun-2022)

---

## 🤝 Kontribusi

Pull request dan issue sangat disambut. Untuk perubahan besar, buka issue terlebih dahulu.

Kontribusi yang berguna:
- Bug report atau saran fitur baru
- Contoh pesan scam yang tidak terdeteksi
- Peningkatan aksesibilitas untuk lansia
- Terjemahan atau penyesuaian bahasa daerah

---

## 📄 Lisensi

MIT License — lihat file [LICENSE](LICENSE) untuk detail.

---

<div align="center">

**Dibangun dengan ❤️ untuk melindungi Eyang dari penipuan digital**

*"Mengubah lansia dari mata rantai terlemah menjadi subjek digital yang berdaya."*

</div>
