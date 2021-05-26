import 'package:flutter/material.dart';
import 'package:gemography_test/model/repo_model.dart';
import 'package:gemography_test/providers/providers.dart';
import 'package:gemography_test/style/font_style.dart';
import 'package:gemography_test/widgets/loading_alert_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

class RepoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Trending Repos",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white70,
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: context.read(repoViewModelProvider).getMostStarredRepos(),
            builder: (context, AsyncSnapshot<RepoModel> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              RepoModel? repoModel = snapshot.data;

              return ListView.builder(
                itemCount: repoModel!.items.length,

                itemBuilder: (context, index) {
                  String longUserFullName = repoModel.items[index].fullName;
                  String userFullName = longUserFullName.substring(0, longUserFullName.indexOf('/'));

                  return Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(repoModel.items[index].name,
                                      style: kRepoNameStyle),
                                  const SizedBox(height: 8.0),
                                  RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    text: TextSpan(
                                        style: kFontNormalStyle,
                                        text: repoModel.items[index].description),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 15,
                                            child: Image.network(repoModel
                                                .items[index].owner.avatarUrl),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            userFullName,
                                            style: kFontNormalStyle,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.star,
                                              color: Colors.black, size: 18),
                                          SizedBox(width: 4),
                                          Text(repoModel.items[index].stargazersCount.toString(),
                                            style: kFontNormalStyle,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Container(
                                    width: double.infinity,
                                    color: Colors.grey.withOpacity(0.5),
                                    height: 1.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          LoadingAndAlertWidget(),
        ],
      ),
    );
  }
}
