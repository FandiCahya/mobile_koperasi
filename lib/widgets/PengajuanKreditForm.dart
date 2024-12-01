import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/text_styles.dart';
import '../core/spacing.dart';
import '../core/padding.dart';

class PengajuanKreditForm extends StatefulWidget {
  @override
  _PengajuanKreditFormState createState() => _PengajuanKreditFormState();
}

class _PengajuanKreditFormState extends State<PengajuanKreditForm> {
  final TextEditingController _nominalController = TextEditingController();

  @override
  void dispose() {
    _nominalController.dispose();
    super.dispose();
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
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0), // Margin kanan dan kiri
              child: Text(
                "Masukkan Nominal Pengajuan",
                style: AppTextStyles.label,
              ),
            ),
            AppSpacing.heightMedium,
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0), // Margin kanan dan kiri
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
              child: Container(
                width: MediaQuery.of(context).size.width *
                    0.5, // Tombol lebih kecil
                padding: EdgeInsets.symmetric(vertical: 12), // Padding tombol
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: () {
                    String nominal = _nominalController.text;
                    if (nominal.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                "Pengajuan sebesar $nominal berhasil dikirim!")),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Nominal tidak boleh kosong.")),
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
