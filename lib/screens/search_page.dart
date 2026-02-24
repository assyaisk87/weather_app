import 'package:weather_app/providers/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();

    return Scaffold(
      appBar: AppBar(title: Text('Поиск города')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: controller,
              decoration: InputDecoration(hintText: 'Введите название города'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await provider.fetchWeather(controller.text);

                if (context.mounted) {
                  if (provider.error == null) {
                    Navigator.pop(context);
                  } else {
                    print('SearchPage');
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Город не найден')));
                  }
                }
              },
              child: provider.isLoading
                  ? CircularProgressIndicator()
                  : Text('Начать поиск'),
            ),
          ],
        ),
      ),
    );
  }
}
