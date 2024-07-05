import 'package:stacked/stacked_annotations.dart';
import 'package:sales_engine/ui/views/home/home_view.dart';
import 'package:sales_engine/ui/views/startup/startup_view.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sales_engine/ui/views/dashboard/dashboard_view.dart';
import 'package:sales_engine/services/api_service.dart';
import 'package:sales_engine/services/graphql_service.dart';
import 'package:sales_engine/ui/views/login/login_view.dart';
import 'package:sales_engine/services/authentication_service.dart';
// @stacked-import

@StackedApp(routes: [
  MaterialRoute(page: StartupView),
  MaterialRoute(page: HomeView),
  MaterialRoute(page: DashboardView),
  MaterialRoute(page: LoginView),
// @stacked-route
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: DialogService),
  LazySingleton(classType: BottomSheetService),
  LazySingleton(classType: ApiService),
  LazySingleton(classType: GraphqlService),
  LazySingleton(classType: AuthenticationService),
// @stacked-service
])
class App {}
