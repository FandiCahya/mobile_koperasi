import 'package:flutter/material.dart';
// import '../core/colors.dart';
import '../core/text_styles.dart';
import '../core/spacing.dart';

class CustomerCard extends StatelessWidget {
  final String name;
  final String jenisKelamin;
  final String status;
  final int tanggungan;
  final String pendidikan;
  final String statusKaryawan;
  final String gaji;
  final String properti;

  CustomerCard({
    required this.name,
    required this.jenisKelamin,
    required this.status,
    required this.tanggungan,
    required this.pendidikan,
    required this.statusKaryawan,
    required this.gaji,
    required this.properti,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          _showPopup(context);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8, // Make it responsive
          height: 100, // You can adjust the height based on your design needs
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0.5,
                blurRadius: 5,
                offset: Offset(4, 4),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.namaNasabah,
                ),
                AppSpacing.heightSmall,
                _buildDetail("Gaji", gaji),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: AppTextStyles.label,
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.label,
            ),
          ),
        ],
      ),
    );
  }

  // Function to show the popup with all data
  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Customer Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                _buildDetail("Nama", name),
                _buildDetail("Jenis Kelamin", jenisKelamin),
                _buildDetail("Status", status),
                _buildDetail("Tanggungan", tanggungan.toString()),
                _buildDetail("Pendidikan", pendidikan),
                _buildDetail("Status Karyawan", statusKaryawan),
                _buildDetail("Gaji", gaji),
                _buildDetail("Properti", properti),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
