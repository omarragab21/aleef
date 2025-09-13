abstract final class ApiRoutes {
  const ApiRoutes._();

  // Base URL
  static const String baseUrl = 'https://api.aleef.com';
  static const String baseUrlApi =
      'https://aleef.meetsyourneed.com/api'; // Replace with your actual API base URL

  // Auth Routes
  static const String userRegister = '/auth/user/register';
  static const String userLogin = '/auth/user/login';
  static const String userVerifyOtp = '/auth/user/verify-otp';
  static const String userLogout = '/auth/user/logout';

  // Home Routes
  static const String homeData = '/home';

  // Main Routes
  static const String mainData = '/main';

  // Animals Routes
  static const String animals = '/animals';
  static const String pets = '/pets';

  // Services Routes
  static const String services = '/services';
  static const String doctors = '/doctors';
  static const String products = '/products';
  static const String categories = '/categories';

  // Profile Routes
  static const String profile = '/profile';
  static const String profileAvatar = '/profile/avatar';

  // Governorates Routes
  static const String governorates = '/governorates';

  // Cities Routes
  static const String cities = '/cities';
}
