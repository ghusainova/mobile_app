import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'data/routes.dart';

const _interceptorName = 'back_button_interceptor';
const _routesToExclude = [
  ClientRoute.path,
  CatalogRoute.path,
  MasterStoRoute.path,
];

void addBackBtnInterceptor(BuildContext context) {
  BackButtonInterceptor.add(
    (stopDefaultButtonEvent, routeInfo) => _backBtnInterceptor(
      context,
      stopDefaultButtonEvent,
      routeInfo,
    ),
    name: _interceptorName,
    context: context,
  );
}

void removeBackBtnInterceptor(BuildContext context) {
  BackButtonInterceptor.removeByName(_interceptorName);
}

bool _backBtnInterceptor(
  BuildContext context,
  bool stopDefaultButtonEvent,
  RouteInfo info,
) {
  final currentRoute = GoRouter.of(context)
      .routerDelegate
      .currentConfiguration
      .matches
      .last
      .matchedLocation;
  final isRouteChanged = !_routesToExclude.contains(currentRoute);

  if (context.mounted && !isRouteChanged) {
    return true;
  }

  return false;
}
