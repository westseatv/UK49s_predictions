import 'dart:developer';
import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uk49s_predictions/core/providers.dart';
import '../constants/appwrite_constants.dart';

final highlightsDatabaseControllerProvider = Provider((ref) {
  final db = ref.watch(appwriteDatabaseProvider);
  return HighlightDatabaseController(db: db);
});

class HighlightDatabaseController {
  final Databases _db;
  HighlightDatabaseController({required Databases db}) : _db = db;
  Future getHighlightsDocuments() async {
    try {
      final documentsList = await _db.listDocuments(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.homevideos,
          queries: [Query.limit(1000)]);
      final allDocuments = documentsList.documents;
      return allDocuments;
    } on AppwriteException {
      log('error');
    }
  }
}
