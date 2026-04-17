import 'package:consvita/core/global_imports.dart';
import 'package:consvita/models/app_theme_mode.dart';
import 'package:consvita/providers/settings_provider.dart';
import 'package:easy_localization/easy_localization.dart';

/// Ekran ustawień
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final controller = ref.read(settingsProvider.notifier);

    final cardColor = Theme.of(context).cardColor;

    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr()),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              settings.saveSettings();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('saved'.tr())),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              'app_settings'.tr(), // tłumacznie
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Card(
            color: cardColor,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Włącznik stylu
                  SwitchListTile(
                     title: Text('theme_swich'.tr()),
                     value: settings.useCustomTheme,
                     onChanged: controller.toggleCustomTheme,
                  ),
                  const SizedBox(height: 16),
          
                  // Wybór motywu
                  DropdownButtonFormField<AppThemeMode>(
                    value: settings.themeMode,
                    decoration: InputDecoration(
                      labelText: 'theme'.tr(),
                      prefixIcon: Icon(Icons.color_lens),
                    ),
                    items: SettingsContrtoller.getThemeItems(),
                    onChanged: (value) {
                      if (value != null) controller.setThemeMode(value);
                    },
                  ),
                  const SizedBox(height: 16),

                  // Wybór języka
                  DropdownButtonFormField<String>(
                    value: settings.languageCode,
                    decoration: InputDecoration(
                      labelText: 'language'.tr(),
                      prefixIcon: Icon(Icons.language),
                    ),
                    items: SettingsContrtoller.getLanguageItems(),
                    onChanged: (value) {
                      if (value != null) controller.setLanguage(value, context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
