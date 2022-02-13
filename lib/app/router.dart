import 'package:auto_route/auto_route.dart';
import 'package:ace_weather/ui/home/home_view.dart';
import 'package:ace_weather/ui/login/login_view.dart';

@MaterialAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: LoginView, initial: true),
  AutoRoute(page: HomeView)
])
class $AppRouter {}
