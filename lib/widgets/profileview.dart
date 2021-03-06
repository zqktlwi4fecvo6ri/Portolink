part of 'widgets.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key, required this.users}) : super(key: key);
  final Users users;
  @override
  _ProfileViewState createState() => _ProfileViewState();
}
class _ProfileViewState extends State<ProfileView> {
  final FToast ft = FToast();
  bool load = false;
  @override
  void initState() {
    super.initState();
    ft.init(context);
  }
  @override
  Widget build(BuildContext context) {
    final Users users = widget.users;
    final Brightness brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/profile_bg.jpg'),
          fit: BoxFit.fill
        )
      ),
      child: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              toolbarHeight: 75,
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                const Spacer(flex: 25),
                ThemeSwitcher(
                  builder: (context) => IconButton(
                    onPressed: () => ThemeSwitcher.of(context).changeTheme(
                      theme: ThemeModelInheritedNotifier.of(context).theme.brightness == Brightness.dark
                      ? BlackWhite.lightTheme()
                      : BlackWhite.darkTheme()
                    ),
                    icon: brightness == Brightness.dark ? const Icon(CupertinoIcons.sun_max_fill) : const Icon(CupertinoIcons.moon_stars_fill),
                    color: brightness == Brightness.dark ? Colors.white : Colors.black
                  )
                ),
                const Spacer()
              ]
            ),
            body: ListView(
              physics: const BouncingScrollPhysics(),
              children: <Column>[
                Column(
                  children: <Widget>[
                    ProfilePicture(
                      name: users.name,
                      radius: 75,
                      fontsize: 50,
                      random: true,
                      tooltip: true,
                      role: ''
                    ),
                    Text(
                      users.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontFamily: 'Oswald', fontSize: 30)
                    ),
                    Text(
                      users.email,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline, decorationThickness: 2)
                    ),
                    const SizedBox(height: 12),
                    Text(
                      users.phone,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontFamily: 'Dancing Script', fontSize: 25)
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Update(
                            name: users.name,
                            phone: users.phone,
                            email: users.email
                          )
                        )
                      ),
                      child: const Text('Update Profile'),
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith((states) {
                          return states.contains(MaterialState.pressed)
                          ? Colors.blue
                          : null;
                        }),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
                        ),
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 12, horizontal: 32))
                      )
                    ),
                    const SizedBox(height: 70),
                    Material(
                      child: InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Help(),
                          )
                        ),
                        child: SizedBox(
                          width: 350,
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Spacer(),
                              Icon(Icons.help),
                              Spacer(flex: 6),
                              Text('Help'),
                              Spacer(flex: 6),
                              Icon(Icons.keyboard_arrow_right_sharp),
                              Spacer()
                            ]
                          )
                        ),
                        highlightColor: Colors.blue,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: Colors.grey.withOpacity(0.6),
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(50))
                    ),
                    const SizedBox(height: 12),
                    Material(
                      child: InkWell(
                        onTap: () async {
                          setState(() => load = true);
                          final ConnectivityResult net = await (Connectivity().checkConnectivity());
                          final bool sub = await InternetConnectionChecker().hasConnection;
                          if (net == ConnectivityResult.none) {
                            setState(() => load = false);
                            ft.showToast(
                              child: Activity.showToast(
                                'No internet connection',
                                const Color(0xFFFF0000)
                              ),
                              toastDuration: const Duration(seconds: 1),
                              fadeDuration: 200
                            );
                          }
                          else if (sub) {
                            await Auth.signOut().then((value) {
                              setState(() => load = false);
                              Navigator.pushReplacementNamed(context, SignIn.routeName);
                            });
                          }
                          else {
                            setState(() => load = false);
                            ft.showToast(
                              child: Activity.showToast(
                                'No internet connection',
                                const Color(0xFFFF0000)
                              ),
                              toastDuration: const Duration(seconds: 1),
                              fadeDuration: 200
                            );
                          }
                        },
                        child: SizedBox(
                          width: 350,
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Spacer(),
                              Icon(Icons.logout),
                              Spacer(flex: 5),
                              Text('Sign Out'),
                              Spacer(flex: 5),
                              Icon(Icons.keyboard_arrow_right_sharp),
                              Spacer()
                            ]
                          )
                        ),
                        highlightColor: Colors.blue,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: Colors.grey.withOpacity(0.6),
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(50))
                    ),
                    const SizedBox(height: 12),
                    Material(
                      child: InkWell(
                        onTap: () async {
                          setState(() => load = true);
                          final ConnectivityResult net = await (Connectivity().checkConnectivity());
                          final bool sub = await InternetConnectionChecker().hasConnection;
                          if (net == ConnectivityResult.none) {
                            setState(() => load = false);
                            ft.showToast(
                              child: Activity.showToast(
                                'No internet connection',
                                const Color(0xFFFF0000)
                              ),
                              toastDuration: const Duration(seconds: 1),
                              fadeDuration: 200
                            );
                          }
                          else if (sub) {
                            await Auth.deleteAccount().then((value) {
                              setState(() => load = false);
                              ft.showToast(
                                child: Activity.showToast(
                                  'Goodbye',
                                  Colors.blue
                                ),
                                toastDuration: const Duration(seconds: 1),
                                fadeDuration: 200
                              );
                              Navigator.pushReplacementNamed(context, SignIn.routeName);
                            });
                          }
                          else { 
                            setState(() => load = false);
                            ft.showToast(
                              child: Activity.showToast(
                                'No internet connection',
                                const Color(0xFFFF0000)
                              ),
                              toastDuration: const Duration(seconds: 1),
                              fadeDuration: 200
                            );
                          }
                        },
                        child: SizedBox(
                          width: 350,
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Spacer(),
                              Icon(Icons.clear),
                              Spacer(flex: 5),
                              Text('Delete Account'),
                              Spacer(flex: 5),
                              Icon(Icons.keyboard_arrow_right_sharp),
                              Spacer()
                            ]
                          )
                        ),
                        highlightColor: const Color(0xFFFF0000),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: Colors.grey.withOpacity(0.6),
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(50))
                    )
                  ]
                )
              ]
            )
          ),
          load == true
          ? Activity.loading()
          : Container()
        ]
      )
    );
  }
}