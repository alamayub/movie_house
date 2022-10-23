import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_house/config/validators.dart';
import 'package:movie_house/providers/firebase_auth.dart';
import 'package:movie_house/widgets/custom_text_widget.dart';
import 'package:movie_house/widgets/loader.dart';
import 'package:movie_house/widgets/message_dialog.dart';

import '../widgets/custom_material_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              var user = snapshot.data!;
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      children: [
                        CustomTextWidget(
                          title: user.displayName!,
                          isTitle: true,
                        ),
                        CustomTextWidget(
                          title: user.email!,
                          date: true,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: CustomTextWidget(
                      title: user.toString(),
                      maxLines: 20,
                    ),
                  ),
                  CustomMaterialButton(
                    title: 'Logout',
                    color: Colors.red,
                    onPressed: () async {
                      var res = await showLogoutDialog(context);
                      if (res == true) FirebaseAuthProvider().logout();
                    },
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: CustomTextWidget(
                  title: snapshot.error.toString(),
                  isTitle: true,
                  color: Colors.red,
                ),
              );
            }
            return CustomMaterialButton(
              title: 'Login',
              onPressed: () => showLoginOptions(context),
            );
          }
          return const Loader();
        },
      ),
    );
  }
}

// login / register widget
showLoginOptions(BuildContext context) {
  // final Size size = MediaQuery.of(context).size;
  bool toggle = true, loading = false;
  String name = '', email = '', password = '';
  return showModalBottomSheet(
    isScrollControlled: true,
    isDismissible: !loading,
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (
        BuildContext context,
        StateSetter setModalState,
      ) =>
          SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24.0),
        child: loading == true
            ? const Center(
                child: Loader(),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextWidget(
                        title: toggle == true ? 'Login' : 'Register',
                        isTitle: true,
                      ),
                      GestureDetector(
                        onTap: () {
                          setModalState(() => toggle = !toggle);
                        },
                        child: CustomTextWidget(
                          color: Colors.blue,
                          title: toggle == false ? 'Login' : 'Register',
                          isTitle: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  toggle == false
                      ? TextField(
                          decoration: const InputDecoration(
                            hintText: 'Full Name*',
                            prefixIcon: Icon(Icons.person),
                          ),
                          onChanged: (val) {
                            setModalState(() => name = val);
                          },
                        )
                      : const SizedBox(),
                  SizedBox(height: toggle == false ? 10 : 0),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Email*',
                      prefixIcon: Icon(Icons.email),
                    ),
                    onChanged: (val) {
                      setModalState(() => email = val);
                    },
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: '******',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    onChanged: (val) {
                      setModalState(() => password = val);
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomMaterialButton(
                    title: toggle == true ? 'Login' : 'Register',
                    onPressed: () async {
                      bool res1 = Validators().isValidName(name);
                      bool res2 = Validators().isValidEmail(email);
                      bool res3 = Validators().isValidPassword(password);
                      if (email.isNotEmpty &&
                          res2 == true &&
                          password.isNotEmpty &&
                          res3 == true) {
                        if (toggle == true) {
                          try {
                            setModalState(() => loading = true);
                            await Future.delayed(const Duration(seconds: 5));

                            await FirebaseAuthProvider()
                                .loginWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                          } catch (e) {
                            setModalState(() => loading = false);
                            // ignore: use_build_context_synchronously
                            await showMessageDialog(
                              context,
                              'Error',
                              e.toString(),
                            );
                          }
                        } else {
                          if (name.isNotEmpty && res1 == true) {
                            try {
                              setModalState(() => loading = true);
                              await FirebaseAuthProvider()
                                  .registerWithEmailAndPassword(
                                name: name,
                                email: email,
                                password: password,
                              );
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop();
                            } catch (e) {
                              setModalState(() => loading = false);
                              // ignore: use_build_context_synchronously
                              await showMessageDialog(
                                context,
                                'Error',
                                e.toString(),
                              );
                            }
                          } else {
                            await showMessageDialog(
                              context,
                              'Warning',
                              'Please enter your full name.',
                            );
                          }
                        }
                      } else {
                        await showMessageDialog(
                          context,
                          'Warning',
                          'Please enter all required fields.',
                        );
                      }
                    },
                  ),
                ],
              ),
      ),
    ),
  );
}

// logout widget
Future<bool> showLogoutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: const Text('Are you sure, you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Logout'),
          )
        ],
      );
    },
  ).then((value) => value ?? false);
}
