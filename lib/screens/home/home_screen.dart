import 'package:consvita/core/global_imports.dart';
import 'package:easy_localization/easy_localization.dart'; // tłumaczenia
import 'widgets/home_body.dart';

/// Główna
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'.tr()),
        centerTitle: true,
      ),
      body: HomeBody(),
    );
  }
}
