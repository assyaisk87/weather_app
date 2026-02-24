import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/screens/search_page.dart';
import 'package:weather_app/widgets/weather_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherProvider>().fetchWeather('Almaty');
    });
  }

  Color _getBackgroundColor(double temp) {
    if (temp <= 0) return Colors.blue.shade900;
    if (temp <= 15) return Colors.blue;
    if (temp <= 25) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();

    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        color: provider.weather == null
            ? Colors.grey
            : _getBackgroundColor(provider.weather!.temperature),
        child: Center(
          child: provider.isLoading
              ? CircularProgressIndicator()
              : provider.error != null
              ? Text(provider.error!)
              : provider.weather != null
              ? WeatherCard(weatherModel: provider.weather!)
              : Text('Начните поиск по городу'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(_createRoute());
        },
        child: Icon(Icons.search),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      transitionsBuilder: (context, animation, secAnimation, child) {
        final slide = Tween(
          begin: Offset(1, 0),
          end: Offset(0, 0),
        ).animate(animation);

        return SlideTransition(position: slide, child: child);
      },

      pageBuilder: (context, animation, secAnimation) {
        return SearchPage();
      },
    );
  }
}
