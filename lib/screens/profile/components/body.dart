import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:untitled1/app_provider/api_provider.dart';
import 'package:untitled1/app_provider/state_provider.dart';

import 'package:untitled1/screens/sign_in/sign_in_screen.dart';
import 'package:untitled1/size_config.dart';
import 'dart:math' as math;
import 'profile_menu.dart';
import 'profile_pic.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Body extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(AppStateProvider.userNotifier);

    final animationController = useAnimationController(
        duration: Duration(
      milliseconds: 750,
    ));
    final _rotationAnimationRight = Tween(begin: 25 / 370, end: -120 / 360)
        .animate(CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.0, 0.5, curve: Curves.fastOutSlowIn)));
    final _rotationAnimationLeft = Tween(begin: math.pi / 2, end: 0.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.0, 0.5, curve: Curves.fastOutSlowIn)));
    final _scaleAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.fastOutSlowIn)));
    final _colorAnimation = ColorTween(
            begin: const Color(0x00ffffff), end: Colors.black.withOpacity(0.6))
        .animate(CurvedAnimation(
            parent: animationController, curve: Curves.fastOutSlowIn));
    late IO.Socket socket;
    socket = IO.io('http://127.0.0.1:3000',
        OptionBuilder().setTransports(['websocket']).build());
    void connectAndListen() {
      socket = IO.io('http://127.0.0.1:3000',
          OptionBuilder().setTransports(['websocket']).build());
      print('socket');

      socket.onConnect((_) {
        print('connect');
        socket.emit(
          'fromclient',
        );
      });

      //When an event recieved from server, data is added to the stream
      // socket.on('event', (data) => streamSocket.addResponse);
      socket.onDisconnect((_) => print('disconnect'));
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ProfilePic(),
            SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: "assets/icons/User Icon.svg",
              press: () => {},
            ),
            ProfileMenu(
              text: "Notifications",
              icon: "assets/icons/Bell.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Settings",
              icon: "assets/icons/Settings.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Help Center",
              icon: "assets/icons/Question mark.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              press: () {
                Navigator.pushNamed(context, SignInScreen.routeName);
              },
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       ref.read(API.socket).sign_in(userId: user!.userId!);
            //       // socket.on('fromserver', (data) => print(data));
            //     },
            //     child: Text('sign_in')),
            // ElevatedButton(
            //     onPressed: () {
            //       ref.read(API.socket).sendMessage(
            //           userId: user!.userId!,
            //           orderId: '123456789',
            //           receiveId: '123456789');
            //       // socket.on('fromserver', (data) => print(data));
            //     },
            //     child: Text('sendMessage')),
          ],
        ),
      ),
    );
  }
}
