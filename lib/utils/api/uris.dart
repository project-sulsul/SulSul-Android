const postSignInKakaoUri = '/auth/sign-in/kakao';
const postSignInGoogleUri = '/auth/sign-in/google';
const getPairingsUri = '/pairings';

const excludeAuthenticationUris = [
  postSignInKakaoUri,
  postSignInGoogleUri,
  getPairingsUri,
  // TODO : 추후 로그인이 필요없는 기능 uri 추가
];
