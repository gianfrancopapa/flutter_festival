import 'package:flutter/material.dart';
import 'package:webapp/login/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Festival Login"),
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        listenWhen: (previous, current) => current.status != previous.status,
        listener: (BuildContext context, LoginState state) {
          if (state.status == LoginStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Error!"),
              ),
            );
          }
          if (state.status == LoginStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Login exitoso!"),
              ),
            );
          }
        },
        buildWhen: (previous, current) => current.status != previous.status,
        builder: (BuildContext context, LoginState state) {
          return const _LoginForm();
        },
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: const [
            Text("Email"),
            SizedBox(height: 10),
            _EmailTextField(),
            SizedBox(height: 10),
            Text("Password"),
            SizedBox(height: 10),
            _PasswordTextField(),
            SizedBox(height: 10),
            _SubmitButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (email) => context.read<LoginBloc>().add(
            LoginEmailChangedEvent(email: email),
          ),
      decoration: const InputDecoration(hintText: 'Email'),
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (password) => context.read<LoginBloc>().add(
            LoginPasswordChangedEvent(password: password),
          ),
      obscureText: true,
      decoration: const InputDecoration(hintText: 'Password'),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = context.select((LoginBloc bloc) => bloc.state.status);
    final isLoading = status == LoginStatus.loading;

    return ElevatedButton(
      onPressed: isLoading
          ? null
          : () => context.read<LoginBloc>().add(
                const LoginButtonPressedEvent(),
              ),
      child: const Text("Login"),
    );
  }
}
