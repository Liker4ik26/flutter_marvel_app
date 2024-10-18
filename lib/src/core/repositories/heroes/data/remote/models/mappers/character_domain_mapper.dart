import 'package:marvel/src/core/repositories/heroes/data/remote/models/character_response.dart';
import 'package:marvel/src/core/repositories/heroes/domain/models/character_domain.dart';
import 'package:marvel/src/core/utils/random_color.dart';

extension CharacterDomainMapper on CharacterResponse {
  CharacterDomain toDomain() {
    return CharacterDomain(
      id: id,
      name: name,
      description: description,
      modified: modified,
      resourceURI: resourceURI,
      urls: urls!.map((e) => e.toDomain()).toList(),
      thumbnail: thumbnail!.toDomain(),
      color: getRandomColor(),
    );
  }
}

extension UrlDomainMapper on UrlResponse {
  UrlDomain toDomain() {
    return UrlDomain(type: type, url: url);
  }
}

extension ImageDomainMapper on ImageResponse {
  ImageDomain toDomain() {
    return ImageDomain(path: path, extension: extension);
  }
}
