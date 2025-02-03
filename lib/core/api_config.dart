class ApiConfig {
  static const String baseUrl = "http://localhost/kspdummy/";

  // Daftar endpoint
  static const String loginEndpoint = "${baseUrl}login.php";
  static const String getPengajuanKreditEndpoint = "${baseUrl}get_pengajuan_kredit.php";
  static const String getResikoKreditEndpoint = "${baseUrl}get_resiko_kredit.php";
  static const String postDistrbusiKreditEndpoint = "${baseUrl}add_submission.php";
  static const String postResikoKreditEndpoint = "${baseUrl}pengajuan_resiko_kredit.php";
  static const String getPenawaranKreditEndpoint = "${baseUrl}get_penawaran_kredit.php";
  static const String getDisKreditEndpoint = "${baseUrl}get_distribusi_kredit.php";
  static const String getMemberEndpoint = "${baseUrl}get_member.php";
  static const String postPenawaranKreditEndpoint = "${baseUrl}add_offer.php";
  static const String addMemberEndpoint = "${baseUrl}add_member.php";
}
