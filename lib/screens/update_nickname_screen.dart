import 'package:flutter/material.dart';

import 'package:sul_sul/models/user_repository.dart';
import 'package:sul_sul/providers/nickname_provider.dart';
import 'package:provider/provider.dart';
import 'package:sul_sul/providers/user_provider.dart';
import 'package:sul_sul/utils/api/api_client.dart';

import 'package:sul_sul/utils/constants.dart';
import 'package:sul_sul/utils/route.dart';
import 'package:sul_sul/theme/custom_icons_icons.dart';
import 'package:sul_sul/theme/colors.dart';

import 'package:sul_sul/screens/preference/alcohol_screen.dart';
import 'package:sul_sul/widgets/profile/profile.dart';
import 'package:sul_sul/widgets/profile/validation.dart';

import 'package:sul_sul/widgets/top_action_bar.dart';
import 'package:sul_sul/widgets/button.dart';
import 'package:sul_sul/widgets/blur_container.dart';

class UpdateNicknameScreen extends StatefulWidget {
  final bool isUpdate;

  const UpdateNicknameScreen({
    super.key,
    this.isUpdate = false,
  });

  @override
  State<UpdateNicknameScreen> createState() => _UpdateNicknameScreenState();
}

class _UpdateNicknameScreenState extends State<UpdateNicknameScreen> {
  final TextEditingController _controller = TextEditingController();

  bool _isNicknameCharValid = true;
  bool _isNicknameLenValid = true;
  bool _isRandomNickname = false;

  @override
  void initState() {
    super.initState();
    var nickname = context.read<UserProvider>().nickname;
    nickname != null ? _controller.text = nickname : _getNewNickname();
  }

  void validateNickname(String nickname) {
    var reg = r'[!@#$%^&*(),.?":{}|<>\-/]';

    setState(() {
      _isRandomNickname = false;
      _isNicknameLenValid = !(nickname.length > 10 || nickname.isEmpty);
      _isNicknameCharValid = !nickname.contains(RegExp(reg));
    });
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

  Widget _noticeValidation() {
    if (_controller.text.isEmpty && !_isRandomNickname) {
      return Column(
        children: [
          Validation(
            target: _controller.text,
            text: '특수문자 사용은 안돼요.',
            isValid: _isNicknameCharValid,
          ),
          Validation(
            target: _controller.text,
            text: '한글/영문, 숫자 포함 10자로 사용 가능해요.',
            isValid: _isNicknameLenValid,
          ),
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
                CustomIcons.arrow_forward_under,
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
              size: ButtonSize.medium,
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        _isNicknameCharValid
            ? Validation(
                target: _controller.text,
                text: '입력된 특수문자가 없어요.',
                isValid: _isNicknameCharValid,
              )
            : Validation(
                target: _controller.text,
                text: '특수문자가 포함되어 있어요.',
                isValid: _isNicknameCharValid,
              ),
        _isNicknameLenValid
            ? Validation(
                target: _controller.text,
                text: '적절한 글자수의 닉네임이에요.',
                isValid: _isNicknameLenValid,
              )
            : Validation(
                target: _controller.text,
                text: '한글/영문, 숫자 포함 1~10자 이내로 설정해주세요.',
                isValid: _isNicknameLenValid,
              ),
      ],
    );
  }

  Widget _button(UserRepository userRepository, void Function() onPressed) {
    var isValid = _controller.text.isNotEmpty &&
        _isNicknameCharValid &&
        _isNicknameLenValid;

    return BlurContainer(
      padding: 20,
      child: Column(
        children: [
          if (!_isRandomNickname)
            Button(
              title: '랜덤 닉네임 쓸래요!',
              onPressed: _getNewNickname,
              type: ButtonType.plane,
              size: ButtonSize.mini,
              padding: const EdgeInsets.symmetric(horizontal: 24),
            ),
          if (!_isRandomNickname) const SizedBox(height: 20),
          Button(
            title: widget.isUpdate ? '완료' : '다음',
            onPressed: onPressed,
            type: isValid ? ButtonType.active : ButtonType.disable,
            size: ButtonSize.large,
          ),
        ],
      ),
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

    String? userImage = context.watch<UserProvider>().image;

    void onPressNextButton() {
      userRepository.updateNickname(_controller.text).then((res) {
        // TODO: 프로필 이미지 변경
        if (res != null) context.read<UserProvider>().setUser(res);
      });

      if (!widget.isUpdate) {
        Navigator.of(context)
            .push(createRoute(const PreferenceAlcoholScreen()));
        return;
      }

      Navigator.pop(context);
    }

    return Scaffold(
      appBar: TopActionBar(
        type: ActionBarType.back,
        title: userImage != '' ? '프로필 수정' : '',
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.isUpdate) Profile(image: userImage),
                      widget.isUpdate
                          ? const Text(
                              '닉네임 변경',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          : const Text(
                              '어떤 닉네임을 사용할까요?',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      SizedBox(height: widget.isUpdate ? 4 : 15),
                      // TODO: TextField 공통 위젯 교체
                      TextFormField(
                        controller: _controller,
                        onChanged: (String value) {
                          validateNickname(value);
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
                                    CustomIcons.cancel_rounded_filled,
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
              ],
            ),
          ),
          _button(userRepository, onPressNextButton),
        ],
      ),
    );
  }
}
