import 'package:placement_hub/utility/helper.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  /// to send email for the particular user
  Future<void> launchEmail(String mailAddress,String job) async {
    String email = Uri.encodeComponent(mailAddress);
    String subject = Uri.encodeComponent("Job Application for $job");
    String body = Uri.encodeComponent("I am Interest in Your company");
    Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
    if (!await launchUrl(mail)) {
      sendToastMessage(message: 'error launch in mail');
    }
  }

  Future<void> sendEmail() async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'hr@atees.in',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Example Subject & Symbols are allowed!',
      }),
    );
    launchUrl(emailLaunchUri);
  }

  /// to call for particular user
  Future<void> launchPhoneCall(String number) async {
    final Uri launchUri = Uri(scheme: 'tel', path: number);
    try {
      await launchUrl(launchUri);
    } catch (e) {
      sendToastMessage(message: e.toString());
    }
  }
}
