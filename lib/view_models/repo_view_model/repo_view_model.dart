import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemography_test/entities/snack_bar_entity.dart';
import 'package:gemography_test/model/repo_model.dart';
import 'package:gemography_test/providers/providers.dart';

class RepoViewModel extends ChangeNotifier{
  final Reader reader;

  RepoViewModel(this.reader);

  Future<RepoModel> getMostStarredRepos() async {

    final repoServiceProviders = reader(repoServiceProvider);
    final snackBarProvider = reader(snackBarStateProvider);
    final loadingProvider = reader(loadingStateProvider);

    final result = await repoServiceProviders.getMostStarredRepos();

    loadingProvider.state = false;

    if (result.totalCount > 0) {
      print("Count is : ${result.totalCount.toString()}");
      snackBarProvider.state = SnackBarEntity.success(message: "Most Stared Repos Loaded Successfully");

      result.items.sort((a, b) => b.stargazersCount.compareTo(a.stargazersCount));

      return  result;
    } else {

      snackBarProvider.state = SnackBarEntity.error(message: "Failed to load repos ");

      return RepoModel(totalCount: 0, items: []);

    }

  }

}