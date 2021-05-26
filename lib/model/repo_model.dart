class RepoModel {
   late int totalCount;
   late List<Items> items;

  RepoModel({required this.totalCount,required this.items});

  RepoModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }
}

class Items {
  late String name;
  late String fullName;
  late Owner owner;
  late String description;
  late int stargazersCount;
  Items(
      {
        required this.name,
        required this.fullName,
        required this.owner,
        required this.description,
        required this.stargazersCount
      });

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    fullName = json['full_name'];
    owner = (json['owner'] != null ? new Owner.fromJson(json['owner']) : null)!;
    description = json['description'];
    stargazersCount = json['stargazers_count'];
  }
}

class Owner {
  late String avatarUrl;
  Owner({required this.avatarUrl});
  Owner.fromJson(Map<String, dynamic> json) {
    avatarUrl = json['avatar_url'];
  }

}

