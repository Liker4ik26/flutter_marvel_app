import 'dart:ui';

import 'package:equatable/equatable.dart';

class CharacterDomain extends Equatable {
  const CharacterDomain({
    required this.id,
    required this.name,
    required this.description,
    required this.modified,
    required this.resourceURI,
    required this.urls,
    required this.thumbnail,
    required this.color,
  });

  final int? id;
  final String? name;
  final String? description;
  final DateTime? modified;
  final String? resourceURI;
  final List<UrlDomain?> urls;
  final ImageDomain thumbnail;
  final Color color;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        modified,
        resourceURI,
        urls,
        thumbnail,
        color,
      ];
}

class UrlDomain extends Equatable {
  const UrlDomain({
    required this.type,
    required this.url,
  });

  final String? type;
  final String? url;

  @override
  List<Object?> get props => [
        type,
        url,
      ];
}

class ImageDomain extends Equatable {
  const ImageDomain({
    required this.path,
    required this.extension,
  });

  final String? path;
  final String? extension;

  @override
  List<Object?> get props => [
        path,
        extension,
      ];
}
