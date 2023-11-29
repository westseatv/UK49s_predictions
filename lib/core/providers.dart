import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uk49s_predictions/databases/constants/appwrite_constants.dart';

final appwriteClientProvider = Provider((ref) {
  final Client client = Client()
      .setEndpoint(AppwriteConstants.appwriteEndpoint)
      .setProject(AppwriteConstants.projectId);
  return client;
});

final appwriteDatabaseProvider = Provider((ref) {
  final Databases databases = Databases(ref.watch(appwriteClientProvider));
  return databases;
});

final appwriteAccountProvider = Provider((ref) {
  final Account account = Account(ref.watch(appwriteClientProvider));
  return account;
});
