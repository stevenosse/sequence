import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:sequence/src/features/music_details/services/open_in_player_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

// ignore: depend_on_referenced_packages
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class MockUrlLauncher extends Mock with MockPlatformInterfaceMixin implements UrlLauncherPlatform {}

void main() {
  late OpenInPlayerService openInPlayerService;
  late MockUrlLauncher urlLauncher;

  setUp(() {
    registerFallbackValue(LaunchMode.externalNonBrowserApplication);
    registerFallbackValue(const LaunchOptions());

    openInPlayerService = OpenInPlayerService();
    urlLauncher = MockUrlLauncher();

    UrlLauncherPlatform.instance = urlLauncher;
  });

  test('Can open an external url', () async {
    const url = 'https://stevenosse.com';

    when(() => urlLauncher.canLaunch(url)).thenAnswer((_) async => true);
    when(() => urlLauncher.launchUrl(url, any<LaunchOptions>())).thenAnswer((_) async => true);

    await openInPlayerService.open(url);

    verify(() => urlLauncher.canLaunch(url)).called(1);
    verify(() => urlLauncher.launchUrl(url, any<LaunchOptions>())).called(1);
  });
}
