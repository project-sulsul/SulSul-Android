import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sul_sul/providers/nickname_provider.dart';


class UpdateNicknameScreen extends StatefulWidget {
  const UpdateNicknameScreen({super.key});

  @override
  State<UpdateNicknameScreen> createState() => _UpdateNicknameScreenState();
}

class _UpdateNicknameScreenState extends State<UpdateNicknameScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isNicknameValid = true;

  void validateNickname(String nickname) {
    if (nickname.length > 10 || nickname.isEmpty) {
      setState(() {
        _isNicknameValid = false;
      });
      return;
    } else if (nickname.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>\-/]'))) {
      setState(() {
        _isNicknameValid = false;
      });
      return;
    } else {
      setState(() {
        _isNicknameValid = true;
      });
      return;
    }
  }

  void _getNewNickname() {
    final provider = Provider.of<NicknameProvider>(context, listen: false);
    provider.getRandomNickname();
    _controller.text = provider.nickname;
  }

  Widget _validationText(String text) {
    Color color = _isNicknameValid ? Colors.black : Colors.red;
    return Row(
      children: [
        Icon(Icons.check, color: color),
        Align(
            alignment: Alignment.bottomLeft,
            child: Text(
                style: TextStyle(
                  color: color,
                ),
                text)),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Column(children: [
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('어떤 닉네임을 사용할까요?')),
                  TextFormField(
                    controller: _controller,
                    onChanged: (String value) {
                      validateNickname(value);
                    },
                    decoration: const InputDecoration(
                      hintText: '보라색하이볼',
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: OutlinedButton(
                          // TODO : 버튼 공통위젯으로 나오면 갈아끼우기
                          style: OutlinedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                          ),
                          onPressed: _getNewNickname,
                          child: const Text('랜덤 닉네임'))),
                ]),
              ),
              _validationText('특수문자는 안돼요'),
              _validationText('10자 이내로 입력해주세요'),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    // TODO : 버튼 공통위젯으로 나오면 갈아끼우기
                    style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                    onPressed: () => {},
                    child: const Text('다음')),
              ),
            ],
          ),
        ));
  }
}
