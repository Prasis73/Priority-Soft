import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_shoes/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:get_shoes/features/auth/presentation/blocs/bloc/auth_event.dart';
import 'package:get_shoes/features/auth/presentation/blocs/bloc/auth_state.dart';
import 'package:get_shoes/features/auth/presentation/widgets/text_field.dart';
import 'package:get_shoes/features/products/presentation/pages/discover_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController fullNameController = TextEditingController();
    final TextEditingController phoneNumberController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is AuthAuthenticated) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const DiscoverPage()),
              (Route<dynamic> route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  controller: emailController,
                  hintText: 'Email',
                  icon: Icons.email,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  icon: Icons.lock,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: fullNameController,
                  hintText: 'Full Name',
                  icon: Icons.person,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: phoneNumberController,
                  hintText: 'Phone Number',
                  icon: Icons.phone,
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(RegisterRequested(
                      email: emailController.text,
                      password: passwordController.text,
                      fullName: fullNameController.text,
                      phoneNumber: phoneNumberController.text,
                    ));
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
