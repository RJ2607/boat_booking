import 'package:boat_booking/views/booking/initial_details.dart';
import 'package:boat_booking/views/home/home_page.dart';
import 'package:flutter/material.dart';

import 'views/booking/boat_details.dart';
import 'views/booking/boat_selection.dart';
import 'views/booking/passenger_details.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MyHomePage());
      case '/booking_details':
        return MaterialPageRoute(builder: (_) => InitialDetails());
      case '/boat_selection':
        return MaterialPageRoute(builder: (_) => BoatSelection());
      case '/boat_details':
        return MaterialPageRoute(
            builder: (_) => BoatDetails(
                  passengerNumberController: null,
                  dateController: null,
                  docId: null,
                ));
      case '/passenger_details':
        return MaterialPageRoute(
            builder: (_) => PassengerDetails(
                  passengerNumberController: null,
                  dateController: null,
                  docId: null,
                ));

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: const Text('Page not found'),
        ),
      );
    });
  }
}
