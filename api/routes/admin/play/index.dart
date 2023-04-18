import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:match_repository/match_repository.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    final matchRepository = context.read<MatchRepository>();
    try {
      final body =
          jsonDecode(await context.request.body()) as Map<String, dynamic>;
      final data =
          jsonDecode(utf8.decode(base64Decode(body['data'].toString())))
              as Map<String, dynamic>;

      await matchRepository.playCard(
        matchId: data['matchId'].toString(),
        cardId: data['cardId'].toString(),
        deckId: data['deckId'].toString(),
        userId: data['userId'].toString(),
      );

      return Response(statusCode: HttpStatus.noContent);
    } catch (e) {
      return Response(
        statusCode: HttpStatus.internalServerError,
        body: e.toString(),
      );
    }
  }
  return Response(statusCode: HttpStatus.methodNotAllowed);
}