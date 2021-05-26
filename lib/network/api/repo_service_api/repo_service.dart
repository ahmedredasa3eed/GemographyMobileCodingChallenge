import 'package:gemography_test/model/repo_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class RepoServiceApi {

  Future<RepoModel> getMostStarredRepos() async {
    try {

      String encodedUri = Uri.encodeFull("?q=sort=stars&order=desc");
      var uri = "https://api.github.com/search/repositories?q=sort=stars&order=desc";

      print(uri);
      final url = Uri.parse(uri);

      final  response = await http.get(url);
      final json = jsonDecode(response.body);
      final result = RepoModel.fromJson(json);
      return result;
    } catch (error) {
      print("this error : $error");
    }
    return RepoModel(totalCount: 0, items: []);
  }
}
