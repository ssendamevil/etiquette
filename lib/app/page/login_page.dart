import 'package:etiquette/app/bloc/auth/auth_bloc.dart';
import 'package:etiquette/app/page/learning_page.dart';
import 'package:etiquette/app/page/position_type_page.dart';
import 'package:etiquette/domain/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(context.read<AuthRepository>()),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginViewState();
  }
}

class LoginViewState extends State<LoginView> {
  late AuthBloc _bloc;
  late TextEditingController _textController;
  late TextEditingController _codeController;
  bool isPending = false;
  bool showBottom = true;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<AuthBloc>();
    _textController = TextEditingController();
    _codeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Column(
            children: [
              const SizedBox(height: 140),
              Center(
                child: SvgPicture.asset(
                  'assets/logo.svg',
                  width: 65.25,
                  height: 65.25,
                ),
              ),
              const SizedBox(height: 22.75),
              const Center(
                child: Text(
                  'Log in to etiquette',
                  style: TextStyle(
                    color: Color(0xFF2F2F2F),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Geometria',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(
                  left: 17,
                  right: 17,
                ),
                child: TextField(
                  controller: _textController,
                  enabled: !isPending,
                  decoration: InputDecoration(
                      hintText: 'Phone number',
                      hintStyle: const TextStyle(
                        fontFamily: 'Geometria',
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF8B8B8B),
                      ),
                      fillColor: const Color(0xFFEFEFEF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFFC3C3C3),
                          width: 1,
                        ),
                        gapPadding: 15,
                      )),
                ),
              ),
              BlocBuilder<AuthBloc, AuthState>(builder: _stateBuilder),
              BlocListener<AuthBloc, AuthState>(
                listener: _stateListener,
                child: Container(),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: (showBottom)
          ? BottomAppBar(
              color: Colors.transparent,
              elevation: 0,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 17,
                        vertical: 44,
                      ),
                      child: ElevatedButton(
                        onPressed: (!isPending)
                            ? () {
                                _bloc.add(
                                    AuthRegisterEvent(_textController.text));
                                setState(() => showBottom = false);
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFFE7B638),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 14.5,
                            horizontal: 14.5,
                          ),
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'RF Dewi',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }

  Widget _stateBuilder(BuildContext context, AuthState state) {
    if (state.state == AuthStateType.initial) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 17,
                      ),
                      child: ElevatedButton(
                        onPressed: (!isPending)
                            ? () {
                                _bloc.add(AuthLoginEvent(_textController.text));
                                setState(() => showBottom = false);
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF6A81FF),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 14.5,
                          ),
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'RF Dewi',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    } else if (state.isLogin != null && state.state == AuthStateType.success) {
      if (state.isLogin!) {
        return Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(
                right: 17,
                left: 17,
              ),
              child: TextField(
                controller: _codeController,
                enabled: !isPending,
                onChanged: (text) => setState(() {}),
                decoration: InputDecoration(
                    hintText: 'Confirmation code',
                    hintStyle: const TextStyle(
                      fontFamily: 'Geometria',
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF8B8B8B),
                    ),
                    fillColor: const Color(0xFFEFEFEF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFFC3C3C3),
                        width: 1,
                      ),
                      gapPadding: 15,
                    )),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 17,
                    ),
                    child: ElevatedButton(
                      onPressed: (_codeController.text.isNotEmpty && !isPending)
                          ? () => _bloc.add(AuthCodeEnteredEvent(
                                int.parse(_codeController.text),
                                true,
                              ))
                          : null,
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF6A81FF),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 14.5,
                        ),
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'RF Dewi',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      } else {
        return Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(
                right: 17,
                left: 17,
              ),
              child: TextField(
                controller: _codeController,
                enabled: !isPending,
                onChanged: (text) => setState(() {}),
                decoration: InputDecoration(
                    hintText: 'Confirmation code',
                    hintStyle: const TextStyle(
                      fontFamily: 'Geometria',
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF8B8B8B),
                    ),
                    fillColor: const Color(0xFFEFEFEF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFFC3C3C3),
                        width: 1,
                      ),
                      gapPadding: 15,
                    )),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 17,
                    ),
                    child: ElevatedButton(
                      onPressed: (_codeController.text.isNotEmpty && !isPending)
                          ? () => _bloc.add(AuthCodeEnteredEvent(
                                int.parse(_codeController.text),
                                false,
                              ))
                          : null,
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFFE7B638),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 14.5,
                          horizontal: 14.5,
                        ),
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'RF Dewi',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }
    }
    return Container();
  }

  void _stateListener(BuildContext context, AuthState state) {
    if (state.failureMessage != null) {
      Fluttertoast.showToast(msg: state.failureMessage!);
    }
    if (state.state == AuthStateType.codeAccepted) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const PositionTypePage(),
      ));
    } else if (state.state == AuthStateType.isProgress) {
      setState(() => isPending = true);
    } else if (state.state == AuthStateType.initial ||
        state.state == AuthStateType.success) {
      setState(() => isPending = false);
    }
  }
}
