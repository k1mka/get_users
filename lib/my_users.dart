import 'package:flutter/material.dart';
import 'package:get_users/button.dart';
import 'package:get_users/network_service.dart';
import 'package:get_users/user_model.dart';

class MyUsers extends StatefulWidget {
  const MyUsers({Key? key}) : super(key: key);

  @override
  State<MyUsers> createState() => _MyUsersState();
}

class _MyUsersState extends State<MyUsers> {
  late Future<UserModel> future;
  final service = GetUsersServiceImpl();

  @override
  void initState() {
    super.initState();
    future = service.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<UserModel>(
                future: future,
                builder: (context, value) {
                  if (value.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (value.hasError) {
                    return const Center(
                      child: Icon(Icons.close, color: Colors.red),
                    );
                  }

                  if (value.data == null) {
                    return const Center(child: Text('data is null'));
                  }
                  return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (_, i) => UserWidget(user: value.data!),
                  );
                },
              ),
            ),
            CustomButton(
              text: 'GetUsers',
              color: Colors.green,
              onPressed: () {
                setState(() {
                  future = service.fetchUsers();
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

class UserWidget extends StatelessWidget {
  final UserModel user;

  const UserWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '${user.name} ${user.userName} ${user.email}',
      ),
    );
  }
}
