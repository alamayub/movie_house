import 'package:flutter/material.dart';
import 'package:movie_house/widgets/custom_text_widget.dart';

import '../widgets/custom_material_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      child: CustomMaterialButton(
        title: 'Login',
        onPressed: () => showLoginOptions(context),
      ),
    );
  }
}

showLoginOptions(BuildContext context) {
  // final Size size = MediaQuery.of(context).size;
  bool toggle = true;
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (
        BuildContext context,
        StateSetter setModalState,
      ) =>
          SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24.0),
        child: Column(
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
                    title: toggle == false ? 'Login' : 'Register',
                    isTitle: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Full Name*',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Email*',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                hintText: '******',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 10),
            CustomMaterialButton(
              title: 'Login',
              onPressed: () {},
            ),
          ],
        ),
      ),
    ),
  );
}
