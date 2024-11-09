class User {
  final String name;
  final String email;       // Email untuk autentikasi
  final String password;    // Password untuk autentikasi
  final double jumlah;         // Saldo atau jumlah yang dimiliki nasabah
  final double skorkredit;     // Skor kredit nasabah
  final String role;        // "admin" atau "nasabah"

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.jumlah,
    required this.skorkredit,
  });
}
