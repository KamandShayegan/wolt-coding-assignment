import 'package:dio/dio.dart';
import 'package:wolt/constants/constants.dart';
import 'package:wolt/models/coordinate.dart';
import 'package:wolt/models/section_model.dart';

class ApiService {
  final dio = Dio();
  Future<List<SectionModel>> getRestaurant(Coordinate coordinate) async {
    final path =
        '${Constants.baseURL}?lat=${coordinate.lat}&lon=${coordinate.lon}';
    final response = await dio.get(path);
    print("called: $path");
    if (response.statusCode == 200) {
      final jsonFormatResponse = response.data;
      List<dynamic> sectionsJson = jsonFormatResponse['sections'] ?? [];
      List<SectionModel> sections = sectionsJson
          .map((sectionJson) => SectionModel.fromJson(sectionJson))
          .toList();
      return sections;
    } else {
      throw Exception("${response.statusCode}: ${response.statusMessage}");
    }
  }
}
