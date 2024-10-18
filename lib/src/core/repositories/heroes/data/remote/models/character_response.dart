import 'package:json_annotation/json_annotation.dart';

part 'character_response.g.dart';

@JsonSerializable()
class CharacterResponse {
  const CharacterResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.modified,
    required this.resourceURI,
    required this.urls,
    required this.thumbnail,
  });

  factory CharacterResponse.fromJson(Map<String, dynamic> json) =>
      _$CharacterResponseFromJson(json);

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'modified')
  final DateTime? modified;

  @JsonKey(name: 'resourceURI')
  final String? resourceURI;

  @JsonKey(name: 'urls')
  final List<UrlResponse>? urls;

  @JsonKey(name: 'thumbnail')
  final ImageResponse? thumbnail;
}

@JsonSerializable()
class UrlResponse {
  const UrlResponse({
    required this.type,
    required this.url,
  });

  factory UrlResponse.fromJson(Map<String, dynamic> json) =>
      _$UrlResponseFromJson(json);

  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'url')
  final String? url;
}

@JsonSerializable()
class ImageResponse {
  const ImageResponse({
    required this.path,
    required this.extension,
  });

  factory ImageResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageResponseFromJson(json);

  @JsonKey(name: 'path')
  final String? path;

  @JsonKey(name: 'extension')
  final String? extension;
}
