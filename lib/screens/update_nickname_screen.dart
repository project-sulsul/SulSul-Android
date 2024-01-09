import 'package:flutter/material.dart';

import 'package:sul_sul/models/user_repository.dart';
import 'package:sul_sul/providers/nickname_provider.dart';
import 'package:provider/provider.dart';
import 'package:sul_sul/utils/api/api_client.dart';

import 'package:sul_sul/theme/custom_icons_icons.dart';
import 'package:sul_sul/theme/colors.dart';
import 'package:sul_sul/utils/constants.dart';

import 'package:sul_sul/widgets/header.dart';
import 'package:sul_sul/widgets/button.dart';

class UpdateNicknameScreen extends StatefulWidget {
  const UpdateNicknameScreen({super.key});

  @override
  State<UpdateNicknameScreen> createState() => _UpdateNicknameScreenState();
}

class _UpdateNicknameScreenState extends State<UpdateNicknameScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isNicknameCharValid = true;
  bool _isNicknameLenValid = true;
  bool _isRandomNickname = true;

  void validateNickname(String nickname) {
    if (nickname.length > 10 || nickname.isEmpty) {
      setState(() {
        _isNicknameLenValid = false;
      });
    }
    if (nickname.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>\-/]'))) {
      setState(() {
        _isNicknameCharValid = false;
      });
    }
    if (nickname.length <= 10 &&
        nickname.isNotEmpty &&
        !nickname.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>\-/]'))) {
      setState(() {
        _isNicknameCharValid = true;
        _isNicknameLenValid = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getNewNickname();
  }

  void _clearNickname() {
    _controller.clear();
    setState(() {
      _isRandomNickname = false;
      _isNicknameCharValid = false;
      _isNicknameLenValid = false;
    });
  }

  void _getNewNickname() async {
    final provider = Provider.of<NicknameProvider>(context, listen: false);
    await provider.getRandomNickname();
    _controller.text = provider.nickname;

    setState(() {
      _isRandomNickname = true;
    });
  }

  Widget _validationText(String text, bool isValid) {
    Color color = _controller.text.isEmpty
        ? Dark.gray700
        : isValid
            ? Dark.green050
            : Dark.red050;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          _controller.text.isEmpty || isValid
              ? Icon(
                  CustomIcons.select,
                  color: color,
                  size: 10,
                )
              : Icon(
                  CustomIcons.cancle,
                  color: color,
                  size: 10,
                ),
          Container(
            alignment: Alignment.bottomLeft,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              text,
              style: TextStyle(
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _noticeValidation() {
    if (_controller.text.isEmpty && !_isRandomNickname) {
      return Column(
        children: [
          _validationText('특수문자 사용은 안돼요.', _isNicknameCharValid),
          _validationText('한글/영문, 숫자 포함 10자로 사용 가능해요.', _isNicknameLenValid),
        ],
      );
    }

    if (_isRandomNickname) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                CustomIcons.arrow,
                color: Dark.gray500,
                size: 16,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: const Text(
                  '랜덤으로 설정된 닉네임이에요.',
                  style: TextStyle(fontSize: 16, color: Dark.gray500),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: Button(
                title: '다른거 할래요',
                onPressed: _getNewNickname,
                size: ButtonSize.medium),
          ),
        ],
      );
    }

    return Column(
      children: [
        _isNicknameCharValid
            ? _validationText('입력된 특수문자가 없어요.', _isNicknameCharValid)
            : _validationText('특수문자가 포함되어 있어요.', _isNicknameCharValid),
        _isNicknameLenValid
            ? _validationText('적절한 글자수의 닉네임이에요.', _isNicknameLenValid)
            : _validationText(
                '한글/영문, 숫자 포함 1~10자 이내로 설정해주세요.', _isNicknameLenValid),
      ],
    );
  }

  Widget _nextButton(UserRepository userRepository) {
    return Button(
      title: '다음',
      onPressed: _controller.text.isNotEmpty &&
              _isNicknameCharValid &&
              _isNicknameLenValid
          ? () => userRepository.updateNickname(_controller.text)
          : () {},
      type: _controller.text.isNotEmpty &&
              _isNicknameCharValid &&
              _isNicknameLenValid
          ? ButtonType.active
          : ButtonType.disable,
      size: ButtonSize.large,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserRepository userRepository = UserRepository(apiClient: sulsulServer);

    return Scaffold(
      appBar: const Header(title: ''),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '어떤 닉네임을 사용할까요?',
                      style: TextStyle(
                        color: Dark.gray900,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // TODO: TextField 공통 위젯 교체
                  TextFormField(
                    controller: _controller,
                    onChanged: (String value) {
                      validateNickname(value);
                      setState(() {
                        _isRandomNickname = false;
                      });
                    },
                    cursorColor: Dark.gray900,
                    style: const TextStyle(
                      color: Dark.gray900,
                      fontWeight: FontWeight.w600,
                      fontSize: 32,
                    ),
                    decoration: InputDecoration(
                      hintText: '닉네임을 입력해주세요',
                      hintStyle: const TextStyle(color: Dark.gray200),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      suffixIcon: _controller.text.isNotEmpty
                          ? GestureDetector(
                              onTap: _clearNickname,
                              child: const Icon(
                                CustomIcons.cancel_rounded,
                                color: Dark.gray400,
                                size: 20,
                              ),
                            )
                          : null,
                    ),
                  ),
                  _noticeValidation()
                ],
              ),
            ),
            _isRandomNickname
                ? const SizedBox(height: 20)
                : Button(
                    title: '랜덤 닉네임 쓸래요!',
                    onPressed: _getNewNickname,
                    type: ButtonType.plane,
                    size: ButtonSize.large,
                  ),
            _nextButton(userRepository),
          ],
        ),
      ),
    );
  }
}
