import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart'; // Import konfigurasi API

// Halaman `TambahAnggotaView` untuk menambahkan anggota baru
class TambahAnggotaView extends StatelessWidget {
  // final TextEditingController _idAnggotaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tanggunganController = TextEditingController();
  final TextEditingController _propertiController = TextEditingController();
  final TextEditingController _gajiController = TextEditingController();

  // Variabel untuk nilai default dropdown
  String _jenisKelamin = 'Laki-laki';
  String _status = 'Belum kawin';
  String _pendidikan = 'Sekolah menengah';
  String _statusKaryawan = 'ASN';
  String _role = 'anggota';

  // Fungsi untuk mengirim data ke server
  Future<void> _submitAnggota(BuildContext context) async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final nama = _namaController.text;
    final tanggungan = _tanggunganController.text;
    final properti = _propertiController.text;
    final gaji = _gajiController.text;

    // Validasi input (tidak boleh kosong)
    if (email.isEmpty || password.isEmpty || nama.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Semua field wajib diisi!')),
      );
      return;
    }

    // Kirim data ke server menggunakan API
    final url = Uri.parse(ApiConfig.addMemberEndpoint);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'nama': nama,
        'jenis_kelamin': _jenisKelamin,
        'status': _status,
        'tanggungan': int.parse(tanggungan),
        'pendidikan': _pendidikan,
        'status_karyawan': _statusKaryawan,
        'properti': properti,
        'gaji': int.parse(gaji),
        'role': _role
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Anggota berhasil ditambahkan. ID: ${responseData['id_anggota']}')),
      );

      // Reset form setelah berhasil submit
      _emailController.clear();
      _passwordController.clear();
      _namaController.clear();
      _tanggunganController.clear();
      _propertiController.clear();
      _gajiController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menambah anggota.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Anggota')), // AppBar dengan judul

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(_emailController, 'Email'),
              _buildTextField(_passwordController, 'Password', obscureText: true),
              _buildTextField(_namaController, 'Nama'),
              _buildDropdown('Jenis Kelamin', ['Laki-laki', 'Perempuan'], _jenisKelamin, (value) {
                _jenisKelamin = value!;
              }),
              _buildDropdown('Status', ['Belum kawin', 'Kawin'], _status, (value) {
                _status = value!;
              }),
              _buildTextField(_tanggunganController, 'Tanggungan', keyboardType: TextInputType.number),
              _buildDropdown('Pendidikan', ['Sekolah menengah', 'Perguruan tinggi'], _pendidikan, (value) {
                _pendidikan = value!;
              }),
              _buildDropdown('Status Karyawan', ['ASN', 'Honorer'], _statusKaryawan, (value) {
                _statusKaryawan = value!;
              }),
              _buildTextField(_gajiController, 'Gaji', keyboardType: TextInputType.number),
              _buildTextField(_propertiController, 'Properti'),
              _buildDropdown('Role', ['admin', 'anggota'], _role, (value) {
                _role = value!;
              }),

              SizedBox(height: 16.0),

              // Tombol Submit
              GestureDetector(
                onTap: () => _submitAnggota(context),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk membuat TextField (input teks)
  Widget _buildTextField(TextEditingController controller, String label, {bool obscureText = false, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        obscureText: obscureText,
        keyboardType: keyboardType,
      ),
    );
  }

  // Widget untuk membuat Dropdown
  Widget _buildDropdown(String label, List<String> items, String value, void Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField(
        value: value,
        decoration: InputDecoration(labelText: label),
        items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
