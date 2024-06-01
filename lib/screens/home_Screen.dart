import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_wall_app/auth/post_Auth.dart';
import 'package:social_wall_app/components/custom_button.dart';
import 'package:social_wall_app/components/ktext_field.dart';

import '../components/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  final FirestorePost _database = FirestorePost();
  TextEditingController postController = TextEditingController();
  HomeScreen({super.key});
  void getPost() {
    if (postController.text.isNotEmpty) {
      String message = postController.text;
      _database.addPost(message);
    }
    postController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "Home",
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Expanded(
                  child: KTextField(
                      controller: postController,
                      hint: "Say Something ...",
                      obscureText: false),
                ),
                PostCustomButton(
                  onTap: getPost,
                )
              ],
            ),
          ),
          StreamBuilder(
            stream: _database.getPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final posts = snapshot.data!.docs;
              if (snapshot.data == null && posts.isEmpty) {
                return const Center(child: Text("No Post Yet"));
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    String message = posts[index]['PostMessage'];
                    String email = posts[index]['userEmail'];
                    //double timeStap = posts[index]['TimeStamp'];
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 25, bottom: 25, right: 25),
                      child: Container(
                        //padding: EdgeInsets.all(25),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(15)),
                        child: ListTile(
                          title: Text(
                            message,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(email,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  fontSize: 16)),
                          //trailing: Text(),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
      drawer: CustomDrawer(),
    );
  }
}
