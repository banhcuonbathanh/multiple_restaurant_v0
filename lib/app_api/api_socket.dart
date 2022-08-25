import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import '../screens/cart/components/history_screen/history_screen.dart';

class APISocket {
  final Reader read;

  APISocket({required this.read});
  // final IO.Socket socket = IO.io('http://127.0.0.1:3000',
  //     OptionBuilder().setTransports(['websocket']).build());

  void connectAndListen() {
    final socket = read(socketProvider);
    socket.onConnect((_) {
      // print('connect');
      // socket.emit('fromclient', '${user.userId}');
    });

    //When an event recieved from server, data is added to the stream
    // socket.on('event', (data) => streamSocket.addResponse);
    socket.onDisconnect((_) => print('disconnect'));
  }

  void sign_in({required String userId}) {
    final socket = read(socketProvider);
    socket.onConnect((_) {
      // print('connect');
      // socket.emit('fromclient', '${user.userId}');
    });
    socket.onDisconnect((_) => print('disconnect'));
    socket.emit('sign_in', '${userId}');
  }

  void sendMessage(
      {required String userId,
      required String orderId,
      required String receiveId}) {
    final socket = read(socketProvider);
    socket.emit(
      "sendMessage",
      {
        "senderId": '${userId}',
        'receiveId': '${receiveId}',
        'orderId': '${orderId}'
      },
    );
  }
}
