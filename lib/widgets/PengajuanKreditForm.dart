import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../core/colors.dart';
import '../core/text_styles.dart';
import '../core/spacing.dart';
import '../core/padding.dart';
import '../core/api_config.dart';

class PengajuanKreditForm extends StatefulWidget {
  final String idAnggota;

  PengajuanKreditForm({required this.idAnggota});

  @override
  _PengajuanKreditFormState createState() => _PengajuanKreditFormState();
}

class _PengajuanKreditFormState extends State<PengajuanKreditForm> {
  final TextEditingController _nominalController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nominalController.dispose();
    super.dispose();
  }

  Future<void> submitData() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse(ApiConfig.postResikoKreditEndpoint);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'id_anggota': widget.idAnggota,
        'nilai_pinjaman': _nominalController.text,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'])),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'])),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengirim data. Coba lagi nanti.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengajuan Kredit', style: AppTextStyles.heading),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: AppPadding.paddingVerticalMedium,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Masukkan Nominal Pengajuan",
                style: AppTextStyles.label,
              ),
            ),
            AppSpacing.heightMedium,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _nominalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Contoh: 5000000",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: AppTextStyles.label,
              ),
            ),
            AppSpacing.heightHigh,
            Center(
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (_nominalController.text.isNotEmpty) {
                            submitData();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text("Nominal tidak boleh kosong.")),
                            );
                          }
                        },
                        child: Text(
                          "Kirim",
                          style: AppTextStyles.button,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
