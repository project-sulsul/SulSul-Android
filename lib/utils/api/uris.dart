const postSignInKakaoUri = '/v1/auth/sign-in/kakao';
const postSignInGoogleUri = '/v1/auth/sign-in/google';

const excludeAuthenticationUris = [
  postSignInKakaoUri,
  postSignInGoogleUri,
  // TODO : 추후 로그인이 필요없는 기능 uri 추가
];
