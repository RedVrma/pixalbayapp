import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pixalbayapp/data/api/PixelBayService.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late PixelBayService service;
  late MockDio mockDio;

  setUp(() {
    dotenv.testLoad(fileInput: "../../../lib/.env");
    mockDio = MockDio();
    service = PixelBayService(apiClient: mockDio);
  });

  test('PixelBayService can be instantiated', () {
    expect(service, isNotNull);
  });
}
