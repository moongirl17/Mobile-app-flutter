import 'package:flutter_batch_6_project/helpers/helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group("Test function formatRupiah()", () {
    test('Mengembalikan Rp 10.000 jika input 10000', () {
      final result = formatRupiah(10000);
      expect(result, "Rp 10.000");
    });

    test('Mengembalikan (Rp 10.000) jika input -10000', () {
      final result = formatRupiah(-10000);
      expect(result, "(Rp 10.000)");
    });

    test('Mengembalikan Rp 0 jika input 0', () {
      final result = formatRupiah(0);
      expect(result, "Rp 0");
    });

    test('Mengembalikan Rp 0 jika input null', () {
      final result = formatRupiah(null);
      expect(result, "Rp 0");
    });

  });
}