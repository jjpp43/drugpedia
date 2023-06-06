import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneNumbersDialog extends StatelessWidget {
  final List<Map<String, dynamic>> phoneNumbers;

  const PhoneNumbersDialog({super.key, required this.phoneNumbers});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Column(
        children: [
          Text(
            '마약류중독자 무료치료병원',
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'Yes_Title',
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            '마약 중독은 의지의 결여가 아닌 건강 문제입니다. 중독의 낙인이 아닌 도움의 손길이 필요한 우리의 가족, 친구, 동료일 수 있습니다.',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Yes_Title',
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: phoneNumbers
            .map(
              (phoneNumber) => Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        child: Text(
                          phoneNumber['name'].toString(),
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontFamily: 'Yes_Title',
                          ),
                        ),
                        onTap: () async {
                          if (!await launchUrl(Uri.parse(phoneNumber['uri']))) {
                            throw 'X';
                          }
                          return;
                        },
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        child: Text(
                          phoneNumber['number'].toString(),
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            fontFamily: 'Yes_Title',
                          ),
                        ),
                        onTap: () => launchUrl(
                          Uri.parse('tel:${phoneNumber["number"]}'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
