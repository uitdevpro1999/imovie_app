import 'package:auto_route/auto_route.dart';
import 'package:imovie_app/presentation/ui/community/feed/community_page.dart';

@RoutePage()
class CommunityMinePage extends CommunityPage {
  const CommunityMinePage({super.key}) : super(mineOnly: true);
}
