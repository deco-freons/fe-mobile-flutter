import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/page/landing.dart';

class EmailConfirmation extends StatefulWidget {
  const EmailConfirmation({Key? key}) : super(key: key);
  static const routeName = '/email_confirmation';

  @override
  State<EmailConfirmation> createState() => _EmailConfirmationState();
}

class _EmailConfirmationState extends State<EmailConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 10.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black, size: 35.0),
            onPressed: () {
              Navigator.pushReplacementNamed(context, Landing.routeName);
            },
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0.0,
      ),
      body: Container(
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.secondary),
        child: SafeArea(child: buildEmailConfirmation()),
      ),
    );
  }

  Widget buildEmailConfirmation() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 87.0),
          child: Center(
            child: Image.asset('lib/common/assets/images/EmailDelivered.png'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 59.0, left: 40.0, right: 40.0),
          child: Center(
            child: Text("Confirm your email",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 51.0, right: 51.0),
          child: Center(
            child: Text(
                "Please check your inbox for a confirmation email. Click the link in the email to confirm your email address.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 18.0,
                )),
          ),
        ),
      ],
    );
  }
}
