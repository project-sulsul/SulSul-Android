// 종성(받침) 체크 함수
bool checkBottomConsonant(String input) {
  if (input == '') return false;

  return (input.runes.last - 0xAC00) % 28 != 0;
}
