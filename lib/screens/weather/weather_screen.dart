import 'package:consvita/core/global_imports.dart';
import 'package:easy_localization/easy_localization.dart';
import 'widgets/weather_body.dart';

/// Pogoda
class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('weather'.tr()),
        centerTitle: true,
      ),
      body: WeatherBody(),
    );
  }
}
