abstract final class ApiRoutes {
  const ApiRoutes._();

  // Base URL
  static const String baseUrl =
      'https://api.aleef.com'; // Replace with your actual API base URL

  // Auth Routes
  static const String userRegister = '/auth/user/register';
  static const String userLogin = '/auth/user/login';
  static const String userLogout = '/auth/user/logout';

  // Home Routes
  static const String homeData = '/home';

  // Main Routes
  static const String mainData = '/main';

  // Animals Routes
  static const String animals = '/animals';

  // Services Routes
  static const String services = '/services';

  // Profile Routes
  static const String profile = '/profile';
}
