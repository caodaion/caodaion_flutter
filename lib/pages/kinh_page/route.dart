import 'package:caodaion_flutter/pages/kinh_page/kinh_details.dart';
import 'package:go_router/go_router.dart';

final kinhRouter = [
  GoRoute(
    path: ':path',
    builder: (context, state) => const KinhDetails(),
  )
];
