import 'dart:math';

import 'package:chat/components/messages.dart';
import 'package:chat/components/new_message.dart';
import 'package:chat/models/chat_notifications.dart';
import 'package:chat/pages/notification_page.dart';
import 'package:chat/services/auth/auth_service.dart';
import 'package:chat/services/notification/push_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Chat'),
        centerTitle: true,
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).primaryIconTheme.color,
                ),
                items: [
                  DropdownMenuItem(
                      value: 'logout',
                      child: Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.exit_to_app,
                              color: Colors.black87,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text('Sair')
                          ],
                        ),
                      )),
                ],
                onChanged: (value) => {
                      if (value == 'logout') {AuthService().logout()}
                    }),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return NotificationPage();
                  }));
                },
                icon: Icon(Icons.notifications),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: CircleAvatar(
                  maxRadius: 8,
                  backgroundColor: Colors.red.shade800,
                  child: Text(
                    '${Provider.of<PushNotificationService>(context).itemsCount}',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
