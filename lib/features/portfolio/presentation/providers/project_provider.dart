import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/github_datasource.dart';
import '../../data/repositories/portfolio_repository_impl.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/usecases/get_projects.dart';

final projectProvider = FutureProvider<List<ProjectEntity>>((ref) async {
  final datasource = GithubDatasource();

  final repository = PortfolioRepositoryImpl(datasource);

  final usecase = GetProjects(repository);

  return usecase();
});
