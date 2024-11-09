// lib/utils/status_dialog.dart

import 'package:flutter/material.dart';

void showStatusDialog(BuildContext context, bool isAccepted) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.all(16.0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              isAccepted ? Icons.check_circle : Icons.cancel,
              color: isAccepted ? Colors.green : Colors.red,
              size: 40,
            ),
            SizedBox(height: 16),
            Text(
              isAccepted ? "Nasabah Diterima" : "Nasabah Ditolak",
              style: TextStyle(
                color: isAccepted ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      );
    },
  );
}

void showDetailsDialog(BuildContext context, String name, String amount, double creditScore, String currentStatus, Function updateStatus) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.all(16.0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (currentStatus != "pending")
              Center(
                child: Icon(
                  currentStatus == "accepted" ? Icons.check_circle : Icons.cancel,
                  color: currentStatus == "accepted" ? Colors.green : Colors.red,
                  size: 40,
                ),
              ),
            SizedBox(height: 16),
            Text("Detail Nasabah", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text("Nama: $name", style: TextStyle(fontSize: 16)),
            Text("Jumlah: $amount", style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text("Kredit Score", style: TextStyle(fontSize: 14)),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: creditScore / 100,
              color: Colors.green,
              backgroundColor: Colors.red,
            ),
            SizedBox(height: 16),
            if (currentStatus == "pending") ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      updateStatus(true);
                      showStatusDialog(context, true);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Terima",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      updateStatus(false);
                      showStatusDialog(context, false);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Tolak",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      );
    },
  );
}
