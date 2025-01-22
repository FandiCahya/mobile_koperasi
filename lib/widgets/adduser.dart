import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';

class TambahAnggotaView extends StatelessWidget {
  final TextEditingController _idAnggotaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tanggunganController = TextEditingController();
  final TextEditingController _propertiController = TextEditingController();
  final TextEditingController _gajiController = TextEditingController();

  String _jenisKelamin = 'Laki-laki';
  String _status = 'Belum kawin';
  String _pendidikan = 'Sekolah menengah';
  String _statusKaryawan = 'ASN';
  String _role = 'anggota';

  Future<void> _submitAnggota(BuildContext context) async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final nama = _namaController.text;
    final tanggungan = _tanggunganController.text;
    final properti = _propertiController.text;
    final gaji = _gajiController.text;

    if (email.isEmpty || password.isEmpty || nama.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Semua field wajib diisi!')),
      );
      return;
    }

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
      _emailController.clear();
      _passwordController.clear();
      _namaController.clear();
      _tanggunganController.clear();

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
      appBar: AppBar(
        title: Text('Tambah Anggota'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama'),
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField(
                value: _jenisKelamin,
                decoration: InputDecoration(labelText: 'Jenis Kelamin'),
                items: ['Laki-laki', 'Perempuan']
                    .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (value) {
                  _jenisKelamin = value!;
                },
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField(
                value: _status,
                decoration: InputDecoration(labelText: 'Status'),
                items: ['Belum kawin', 'Kawin']
                    .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (value) {
                  _status = value!;
                },
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _tanggunganController,
                decoration: InputDecoration(labelText: 'Tanggungan'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField(
                value: _pendidikan,
                decoration: InputDecoration(labelText: 'Pendidikan'),
                items: ['Sekolah menengah', 'Perguruan tinggi']
                    .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (value) {
                  _pendidikan = value!;
                },
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField(
                value: _statusKaryawan,
                decoration: InputDecoration(labelText: 'Status Karyawan'),
                items: ['ASN', 'Honorer']
                    .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (value) {
                  _statusKaryawan = value!;
                },
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _gajiController,
                decoration: InputDecoration(labelText: 'Gaji'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _propertiController,
                decoration: InputDecoration(labelText: 'Properti'),
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField(
                value: _role,
                decoration: InputDecoration(labelText: 'Role'),
                items: ['admin', 'anggota']
                    .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (value) {
                  _role = value!;
                },
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: () => _submitAnggota(context),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
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
}
