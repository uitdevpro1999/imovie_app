import 'package:imovie_app/bootstrap.dart';
import 'package:imovie_app/presentation/app/app.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
