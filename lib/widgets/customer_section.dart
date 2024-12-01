import 'package:flutter/material.dart';
import '../core/text_styles.dart';
import '../core/spacing.dart';
import 'customer_card.dart';
import 'AllCustomersPage.dart';

class CustomerSection extends StatelessWidget {
  final List<Map<String, dynamic>> customers = [
  {
    "name": "Nasabah 1",
    "jenis_kelamin": "Laki-Laki",
    "status": "Menikah",
    "tanggungan": 2,
    "pendidikan": "Sarjana",
    "status_karyawan": "Karyawan Tetap",
    "gaji": "Rp12.000.000",
    "properti": "Rumah, Mobil"
  },
  {
    "name": "Nasabah 2",
    "jenis_kelamin": "Perempuan",
    "status": "Lajang",
    "tanggungan": 0,
    "pendidikan": "Diploma",
    "status_karyawan": "Freelancer",
    "gaji": "Rp6.000.000",
    "properti": "Motor"
  },
  {
    "name": "Nasabah 3",
    "jenis_kelamin": "Laki-Laki",
    "status": "Cerai",
    "tanggungan": 1,
    "pendidikan": "SMA",
    "status_karyawan": "Wiraswasta",
    "gaji": "Rp8.000.000",
    "properti": "Rumah"
  },
  {
    "name": "Nasabah 4",
    "jenis_kelamin": "Perempuan",
    "status": "Menikah",
    "tanggungan": 3,
    "pendidikan": "Sarjana",
    "status_karyawan": "Karyawan Kontrak",
    "gaji": "Rp10.000.000",
    "properti": "Apartemen, Mobil"
  },
  {
    "name": "Nasabah 5",
    "jenis_kelamin": "Laki-Laki",
    "status": "Lajang",
    "tanggungan": 0,
    "pendidikan": "Diploma",
    "status_karyawan": "Karyawan Tetap",
    "gaji": "Rp7.000.000",
    "properti": "Motor"
  },
  {
    "name": "Nasabah 6",
    "jenis_kelamin": "Perempuan",
    "status": "Menikah",
    "tanggungan": 2,
    "pendidikan": "Magister",
    "status_karyawan": "Karyawan Tetap",
    "gaji": "Rp15.000.000",
    "properti": "Rumah, Mobil, Tanah"
  },
];


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "List Anggota",
              style: AppTextStyles.pengajuanNasabah,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllCustomersPage(customers: customers),
                  ),
                );
              },
              child: Text(
                "See All",
                style: AppTextStyles.seeAll,
              ),
            ),
          ],
        ),
        AppSpacing.heightHigh,
        SizedBox(
          height: 100, // Tinggi widget untuk setiap item nasabah
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: customers.length < 5 ? customers.length : 5, // Limit to 5 items for preview
            itemBuilder: (context, index) {
              final customer = customers[index];
              return CustomerCard(
                name: customer['name'],
                jenisKelamin: customer['jenis_kelamin'],
                status: customer['status'],
                tanggungan: customer['tanggungan'],
                pendidikan: customer['pendidikan'],
                statusKaryawan: customer['status_karyawan'],
                gaji: customer['gaji'],
                properti: customer['properti'],
              );
            },
          ),
        ),
      ],
    );
  }
}
