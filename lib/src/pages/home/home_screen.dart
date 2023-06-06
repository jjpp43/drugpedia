import 'package:flutter/material.dart';
import 'components/main_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String _meth = 'assets/svg/meth_white.svg';
  static const String _weed = 'assets/svg/weed_white.svg';
  static const String _cocaine = 'assets/svg/cocaine_white.svg';
  static const String _mdma = 'assets/svg/mdma_white.svg';
  static const String _heroin = 'assets/svg/heroin_white.svg';
  static const String _fentanyl = 'assets/svg/fentanyl_white.svg';

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MainButton(
                    svg: _meth,
                    type: {
                      'korean': '필로폰',
                      'english': 'meth',
                    },
                    backgroundColor: Color(0xffFF81B0),
                  ),
                  MainButton(
                    svg: _weed,
                    type: {
                      'korean': '대마',
                      'english': 'weed',
                    },
                    backgroundColor: Color(0xffFFB2A3),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MainButton(
                    svg: _cocaine,
                    type: {
                      'korean': '코카인',
                      'english': 'cocaine',
                    },
                    backgroundColor: Color(0xffFDD086),
                  ),
                  MainButton(
                    svg: _heroin,
                    type: {
                      'korean': '헤로인',
                      'english': 'heroin',
                    },
                    backgroundColor: Color(0xff9FE6AC),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MainButton(
                    svg: _mdma,
                    type: {
                      'korean': '엑스터시',
                      'english': 'mdma',
                    },
                    backgroundColor: Color(0xff7FE3C9),
                  ),
                  MainButton(
                    svg: _fentanyl,
                    type: {
                      'korean': '펜타닐',
                      'english': 'fentanyl',
                    },
                    backgroundColor: Color(0xffE8D7F8),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
