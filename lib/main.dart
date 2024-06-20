import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_shoes/features/auth/data/repositories/auth_repository.dart';
import 'package:get_shoes/features/auth/data/repositories/user_repository.dart';
import 'package:get_shoes/features/auth/domain/usecases/register_usecase.dart';
import 'package:get_shoes/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:get_shoes/features/auth/presentation/pages/login_page.dart';
import 'package:get_shoes/features/auth/presentation/pages/register_page.dart';
import 'package:get_shoes/features/auth/presentation/pages/splash_screen.dart';
import 'package:get_shoes/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:get_shoes/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:get_shoes/features/cart/presentation/bloc/cart_event.dart';
import 'package:get_shoes/features/cart/presentation/pages/cart_page.dart';
import 'package:get_shoes/features/products/data/repositories/product_repository_impl.dart';
import 'package:get_shoes/features/products/presentation/bloc/discover_bloc.dart';
import 'package:get_shoes/features/products/presentation/pages/discover_page.dart';
import 'package:get_shoes/features/products/presentation/pages/product_detail_page.dart';
import 'features/auth/domain/usecases/login_usecase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final authRepository = AuthRepository();
  final userRepository = UserRepository();
  final loginUseCase = LoginUseCase(authRepository: authRepository);
  final registerUseCase = RegisterUseCase(
      authRepository: authRepository, userRepository: userRepository);
  final cartRepository = CartRepository();

  runApp(MyApp(
      authRepository: authRepository,
      userRepository: userRepository,
      loginUseCase: loginUseCase,
      registerUseCase: registerUseCase,
      cartRepository: cartRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final CartRepository cartRepository;

  const MyApp(
      {super.key,
      required this.authRepository,
      required this.userRepository,
      required this.loginUseCase,
      required this.registerUseCase,
      required this.cartRepository});

  @override
  Widget build(BuildContext context) {
    final ProductRepository productRepository = ProductRepository();
    final CartRepository cartRepository = CartRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            loginUseCase: loginUseCase,
            registerUseCase: registerUseCase,
          ),
        ),
        BlocProvider<DiscoverBloc>(
          create: (context) => DiscoverBloc(productRepository),
        ),
        BlocProvider<CartItemBloc>(
          create: (context) => CartItemBloc(cartRepository: cartRepository),
        ),
        BlocProvider<CartItemBloc>(
          create: (context) => CartItemBloc(cartRepository: cartRepository)
            ..add(LoadCartItems()),
        ),
        RepositoryProvider<CartRepository>(
          create: (context) => CartRepository(),
        ),
      ],
      child: MaterialApp(
        title: 'Get Shoes',
        theme: ThemeData(
          scaffoldBackgroundColor:
              Colors.white, // Sets the default scaffold background color
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white, // Sets the app bar background color
          ),
          canvasColor: Colors
              .white, // Sets the default background color for various components
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginPage(),
          '/discover': (context) => const DiscoverPage(),
          '/register': (context) => const RegisterPage(),
          '/home': (context) => const DiscoverPage(),
          '/productDetails': (context) => const ProductDetailPage(),
          '/cartPage': (context) => const CartPage(),
        },
      ),
    );
  }
}
