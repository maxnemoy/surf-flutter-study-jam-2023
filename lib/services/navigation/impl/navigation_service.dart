part of '../i_navigation_service.dart';

@Singleton(as: INavigationService, env: [Environment.dev])
class NavigationService implements INavigationService {
  final GlobalKey<ScaffoldMessengerState> _massagerKey;

  final GlobalKey<NavigatorState> _navigatorKey;
  late final GoRouter _router;

  NavigationService()
      : _massagerKey = GlobalKey<ScaffoldMessengerState>(),
        _navigatorKey = GlobalKey<NavigatorState>() {
    _router = GoRouter(
      redirectLimit: 5,
      debugLogDiagnostics: true,
      navigatorKey: navigatorKey,
      redirect: (context, state) {
        if (state.location == "") {
          return "/ticketList";
        }
        return null;
      },
      routes: [
        GoRoute(
            path: "/ticketList",
            builder: (context, state) => const TicketStoragePage()),
        GoRoute(
            path: "/ticketDetail",
            builder: (context, state) => TicketDetailPage(
                data: state.extra != null
                    ? (state.extra! as Map)["item"] as TicketData?
                    : null)),
      ],
    );
  }

  @override
  GoRouter get router => _router;

  @override
  GlobalKey<ScaffoldMessengerState> get massagerKey => _massagerKey;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  void showToast(String text) {
    _massagerKey.currentState?.showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Future<dynamic> showPopUpDialog(
    Widget dialog, {
    bool barrierDismissible = false,
  }) async {
    final context = navigatorKey.currentState!.overlay!.context;

    return await showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (_) => dialog,
    );
  }

  @override
  void popDialog({dynamic ext}) =>
      Navigator.of(navigatorKey.currentState!.overlay!.context).pop(ext);

  @override
  void pop() => _router.pop();

  @override
  void go(String path, {Object? extra}) => _router.go(path, extra: extra);

  @override
  void push(String path, {Object? extra}) => _router.push(path, extra: extra);
}
