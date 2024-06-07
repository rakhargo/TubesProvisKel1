class HealthFacility {
  final String id;

  final String namaFasilitas;
  final String alamatFasilitas;
  final String kecamatanFasilitas;
  final String kotaKabFasilitas;
  final String kodePosFasilitas;
  final String tingkatFasilitas;
  final String jumlahPoliklinik;
  final String daftarPoliklinik;
  final String fotoFaskes;
  final String logoFaskes;

  HealthFacility({
  required this.id,
  required this.namaFasilitas,
  required this.alamatFasilitas,
  required this.kecamatanFasilitas,
  required this.kotaKabFasilitas,
  required this.kodePosFasilitas,
  required this.tingkatFasilitas,
  required this.jumlahPoliklinik,
  required this.daftarPoliklinik,
  required this.fotoFaskes,
  required this.logoFaskes,
  }); 
}

class RelasiRsPoli 
{
  final String rsId;
  final String poliId;
  final String id;

  RelasiRsPoli({
    required this.rsId, 
    required this.poliId, 
    required this.id,
    });

  factory RelasiRsPoli.fromJson(Map<String, dynamic> json) {
    return RelasiRsPoli(
      rsId: json['rsId'].toString(),
      poliId: json['poliId'].toString(),
      id: json['id'].toString(),
    );
  }
}