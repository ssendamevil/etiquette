import 'package:fresh/fresh.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'entity/token_entity.dart';
import 'hives.dart';

class HiveTokenStorage extends TokenStorage<OAuth2Token> {
  final Box _box;

  HiveTokenStorage() : _box = Hive.box<TokenEntity>(Hives.boxToken);

  @override
  Future<void> delete() async {
    await _box.delete(Hives.boxToken);
  }

  @override
  Future<OAuth2Token?> read() async {
    TokenEntity? token = _box.get(Hives.keyToken);
    if (token != null) {
      return OAuth2Token(
        accessToken: token.access,
        refreshToken: token.refresh,
      );
    } else {
      return null;
    }
  }

  @override
  Future<void> write(OAuth2Token token) async {
    final tokenEntity = TokenEntity(token.accessToken, token.refreshToken!);
    await _box.put(Hives.keyToken, tokenEntity);
  }
}
