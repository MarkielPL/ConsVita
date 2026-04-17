import 'package:consvita/app.dart';
import 'package:consvita/core/global_imports.dart';

/// SplashScreen wyświetla się przez kilka sekund
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();

    // Ukrywa pasek statusu i nawigacji, wchodząc w tryb pełnoekranowy
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Czeka 2 sekundy
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => ScreenSelector()),
      );
    });
  }

  @override
  void dispose() {
    // Przywraca pasek statusu i nawigacji po opuszczeniu ekranu
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // Pełna szerokość ekranu
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple], // Tło z gradientem
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          // Można użyć tła graficznego zamiast gradientu:
          // image: DecorationImage(
          //   image: AssetImage('sciezka do pliku'),
          // )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ikona aplikacji
            Icon(
              Icons.edit,
              size: 80,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            // Nazwa aplikacji
            const Text(
              'Consvita',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontSize: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
