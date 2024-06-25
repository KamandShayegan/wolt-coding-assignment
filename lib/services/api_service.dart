import 'package:dio/dio.dart';
import 'package:wolt/constants/constants.dart';
import 'package:wolt/constants/enums.dart';
import 'package:wolt/models/coordinate.dart';
import 'package:wolt/models/section_model.dart';
import 'package:wolt/viewmodels/base_viewmodel.dart';

class ApiService {
  final BaseViewmodel viewModel;
  final Dio dio;
  ApiService(this.viewModel, this.dio);

  Future<List<SectionModel>> getRestaurant(Coordinate coordinate) async {
    final path =
        '${Constants.baseURL}?lat=${coordinate.lat}&lon=${coordinate.lon}';
    viewModel.setAPIState(ApiState.loading);
    final response = await dio.get(path);
    print("called: $path");
    if (response.statusCode == 200) {
      viewModel.setAPIState(ApiState.success);
      final jsonFormatResponse = response.data;
      List<dynamic> sectionsJson = jsonFormatResponse['sections'] ?? [];
      List<SectionModel> sections = sectionsJson
          .map((sectionJson) => SectionModel.fromJson(sectionJson))
          .toList();
      return sections;
    } else {
      viewModel.setAPIState(ApiState.failure);
      viewModel.stopLooping();
      throw Exception("${response.statusCode}: ${response.statusMessage}");
    }
  }
}
