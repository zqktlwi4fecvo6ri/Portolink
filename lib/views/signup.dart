part of 'views.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static const String routeName = '/up';
  @override
  _SignUpState createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  final ctrlPhone = TextEditingController();
  final ctrlEmail = TextEditingController();
  final ctrlPass = TextEditingController();
  final ctrlCPass = TextEditingController();
  bool vis = true;
  bool load = false;
  @override
  void dispose() {
    ctrlName.dispose();
    ctrlPhone.dispose();
    ctrlEmail.dispose();
    ctrlPass.dispose();
    ctrlCPass.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/signup_bg.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken)
              )
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                children: [
                  const Flexible(
                    child: Center(
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: 60
                        )
                      )
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[500]?.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Center(
                        child: TextField(
                          style: const TextStyle(fontSize: 25),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: Icon(
                                FontAwesomeIcons.user,
                                size: 28
                              )
                            ),
                            hintText: 'Name'
                          ),
                          controller: ctrlName,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next
                        )
                      )
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[500]?.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Center(
                        child: TextField(
                          style: const TextStyle(fontSize: 25),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: Icon(
                                FontAwesomeIcons.phone,
                                size: 28
                              )
                            ),
                            hintText: 'Phone (+62)'
                          ),
                          controller: ctrlPhone,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next
                        )
                      )
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[500]?.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Center(
                        child: TextField(
                          style: const TextStyle(fontSize: 25),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: Icon(
                                FontAwesomeIcons.envelope,
                                size: 28
                              )
                            ),
                            hintText: 'Email'
                          ),
                          controller: ctrlEmail,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next
                        )
                      )
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[500]?.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Center(
                        child: TextField(
                          style: const TextStyle(fontSize: 25),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: Icon(
                                FontAwesomeIcons.lock,
                                size: 28
                              )
                            ),
                            hintText: 'Password',
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  vis = !vis;
                                });
                              },
                              child: Icon(
                                vis
                                ? Icons.visibility
                                : Icons.visibility_off,
                              )
                            )
                          ),
                          obscureText: vis,
                          controller: ctrlPass,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next
                        )
                      )
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[500]?.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Center(
                        child: TextField(
                          style: const TextStyle(fontSize: 25),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: Icon(
                                FontAwesomeIcons.checkCircle,
                                size: 28
                              )
                            ),
                            hintText: 'Confirm Pass'
                          ),
                          obscureText: vis,
                          controller: ctrlCPass,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done
                        )
                      )
                    )
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 40,
                    width: 150,
                    child: ElevatedButton.icon(
                      onPressed: ctrlName.text.isNotEmpty && ctrlPhone.text.isNotEmpty && ctrlEmail.text.isNotEmpty && ctrlPass.text.isNotEmpty && ctrlCPass.text.isNotEmpty
                      ? () async {
                        final net = await (Connectivity().checkConnectivity());
                        if (net == ConnectivityResult.none) {
                          Activity.showToast('No internet connection', const Color(0xFFFF0000));
                        }
                        else if (ctrlName.text.isEmpty) {
                          Activity.showToast('Name cannot be empty', const Color(0xFFFF0000));
                        }
                        else if (ctrlPhone.text.length <= 7 || ctrlPhone.text.length >= 13) {
                          Activity.showToast('Phone number is invalid', const Color(0xFFFF0000));
                        }
                        else if (ctrlPass.text != ctrlCPass.text) {
                          Activity.showToast('Password is not match', const Color(0xFFFF0000));
                        } else {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              load = true;
                            });
                            final Users users = Users(
                              '',
                              '',
                              ctrlName.text,
                              ctrlPhone.text.trim(),
                              ctrlEmail.text.trim(),
                              ctrlPass.text,
                              '',
                              '',
                              '',
                              '',
                              ''
                            );
                            final String msg = await Auth.signUp(users);
                            if (msg == 'Signed') {
                              setState(() {
                                load = false;
                              });
                              Activity.showToast('You can Sign In now', Colors.blue);
                              Navigator.pushReplacementNamed(context, SignIn.routeName);
                            }
                            else if (msg == 'Existed') {
                              setState(() {
                                load = false;
                              });
                              Activity.showToast('Email is already taken', const Color(0xFFFF0000));
                            }
                            else if (msg == 'Invalid Email') {
                              setState(() {
                                load = false;
                              });
                              Activity.showToast('Email is invalid', const Color(0xFFFF0000));
                            }
                            else if (msg == 'Invalid Pass') {
                              setState(() {
                                load = false;
                              });
                              Activity.showToast('Password is too weak', const Color(0xFFFF0000));
                            }
                            else if (msg == 'Disabled') {
                              setState(() {
                                load = false;
                              });
                              Activity.showToast('This email has been disabled', const Color(0xFFFF0000));
                            }
                          }
                        }
                      }
                      : null,
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith((states) {
                          return states.contains(MaterialState.pressed)
                          ? Colors.blue
                          : null;
                        }),
                        foregroundColor: MaterialStateProperty.resolveWith((states) {
                          return states.contains(MaterialState.pressed)
                          ? const Color(0xFF00FF00)
                          : null;
                        }),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                        )
                      ),
                      icon: const Icon(Icons.verified_user),
                      label: Row(
                        children: const [
                          Spacer(),
                          Text(
                            'SIGN UP',
                            style: TextStyle(
                              fontFamily: 'Prompt',
                              fontSize: 20
                            )
                          ),
                          Spacer(flex: 2)
                        ]
                      )
                    )
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, SignIn.routeName);
                    },
                    child: const Text(
                      'Already Have an Account',
                      style: TextStyle(
                        fontFamily: 'Flamenco',
                        fontSize: 30,
                        decoration: TextDecoration.underline,
                        decorationThickness: 1
                      )
                    )
                  ),
                  const SizedBox(height: 20)
                ]
              )
            )
          )
        ),
        load == true
        ? Activity.check()
        : Container()
      ]
    );
  }
}