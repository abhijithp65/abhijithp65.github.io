import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/constants/api_constants.dart';
import '../models/project_model.dart';

class GithubDatasource {
  Future<List<ProjectModel>> fetchRepositories() async {
    final response = await http.get(Uri.parse(ApiConstants.baseUrl));

    final data = jsonDecode(response.body);

    return List<ProjectModel>.from(
      data.map((repo) => ProjectModel.fromJson(repo)),
    );
  }
}
