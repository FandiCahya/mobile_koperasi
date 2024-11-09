import 'package:application_koperasi/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../core/text_styles.dart';

class SkorKreditSection extends StatelessWidget {
  final String customerName;
  final double balance;
  final double creditScore;

  SkorKreditSection({
    required this.customerName,
    required this.balance,
    required this.creditScore,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Kredit Skor Anda",
          style: AppTextStyles.pengajuanNasabah,
        ),
        SizedBox(height: 16),
        Center(
          child: Column(
            children: [
              // Speedometer untuk Skor Kredit
              SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    showLabels: false,
                    showTicks: false,
                    axisLineStyle: AxisLineStyle(
                      thickness: 0.2,
                      color: Colors.grey[300],
                      thicknessUnit: GaugeSizeUnit.factor,
                    ),
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: creditScore,
                        color: AppColors.primaryColor,
                        width: 0.2,
                        sizeUnit: GaugeSizeUnit.factor,
                      ),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Text(
                          "${creditScore.toInt()}%",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor),
                        ),
                        angle: 90,
                        positionFactor: 0.1,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Informasi Nama, Saldo, dan Skor Kredit
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Nama", style: AppTextStyles.namaNasabah),
                      SizedBox(width: 8),
                      Text(": $customerName", style: AppTextStyles.namaNasabah),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text("Saldo", style: AppTextStyles.namaNasabah),
                      SizedBox(width: 8),
                      Text(
                        ": Rp. ${balance.toStringAsFixed(0)}",
                        style: AppTextStyles.namaNasabah,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text("Kredit Score", style: AppTextStyles.namaNasabah),
                      SizedBox(width: 8),
                      Text(": ${creditScore.toInt()}%", style: AppTextStyles.namaNasabah),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Icon atau tombol tambahan di pojok kanan bawah
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(Icons.add_box, size: 32, color: Colors.black),
                  onPressed: () {
                    // Tambahkan aksi di sini
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
