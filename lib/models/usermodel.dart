import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.login,
    this.id,
    this.avatarUrl,
    this.htmlUrl,
    this.name,
    this.location,
    this.bio,
    this.twitterUsername,
    this.publicRepos,
    this.followers,
    this.following,
    this.createdAt,
    this.updatedAt,
  });

  String login;
  int id;
  String avatarUrl;
  String htmlUrl;
  String name;
  String location;
  String bio;
  String twitterUsername;
  int publicRepos;
  int followers;
  int following;
  DateTime createdAt;
  DateTime updatedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    login: json["login"],
    id: json["id"],
    avatarUrl: json["avatar_url"],
    htmlUrl: json["html_url"],
    name: json["name"],
    location: json["location"],
    bio: json["bio"],
    twitterUsername: json["twitter_username"],
    publicRepos: json["public_repos"],
    followers: json["followers"],
    following: json["following"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "login": login,
    "id": id,
    "avatar_url": avatarUrl,
    "html_url": htmlUrl,
    "name": name,
    "location": location,
    "bio": bio,
    "twitter_username": twitterUsername,
    "public_repos": publicRepos,
    "followers": followers,
    "following": following,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
