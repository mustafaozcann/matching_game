import 'package:flutter_riverpod/flutter_riverpod.dart';

final heartProvider = StateProvider<int>((ref) {
  return 10;
});
