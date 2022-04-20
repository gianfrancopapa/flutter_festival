# Flutter Web & Firebase Authentication with Email and Password!

[![Somnio Software](docs/logo.png)][somnio_software_link]

Developed with :blue_heart: &nbsp;by [Somnio Software][somnio_software_link]

This repository contains an opinionated example on how to integrate Firebase Web Authentication using Email & Passowrd in your Flutter Web project!
We also make use of the BLoC pattern and some best practices.

[//]: # "Links"
[somnio_software_link]: https://somniosoftware.com/


#### Pre requisities
- Flutter installed
- Firebase account

#### Create the project

```
# Include fvm (optional)
# We will be using only web
fvm flutter create --project-name webapp --org com.somnio --platforms web
```

#### VS Code configuration

Add your launch.json in vscode

```
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Web",
            "request": "launch",
            "type": "dart",
            "deviceId": "chrome",
            "program": "lib/main.dart",
        },
    ]
}
```

### 1- UI & State Management

Let's start with creating the required UI. It should look like this:

<img src="docs/login_ui.png" height="400">

#### Add dependencies
```
flutter_bloc
equatable
firebase_core
firebase_auth
```

#### Mason

```
# download mason
dart pub global activate mason_cli
# verify mason is installed
mason --version
# init
mason init
# get all bricks registered
mason get
# check for install bricks
mason ls
```

#### Add login_bloc brick

```
mason add -g login_bloc \
--git-url https://github.com/gianfrancopapa/bricks \
--git-path bricks/login_bloc
```

### 2- Authentication Repository

#### Add authentication_repository brick
```
mason add -g authentication_repository \
--git-url https://github.com/gianfrancopapa/bricks \
--git-path bricks/authentication_repository
```

#### Firebase Cli

```
# https://firebase.google.com/docs/cli
curl -sL https://firebase.tools | upgrade=true bash
```

#### FlutterFire Cli

```
# install
dart pub global activate flutterfire_cli
# config
flutterfire config
```

#### Initialize Firebase in main

```
void main() async {
  bootstrap(
    () async {
      return FlutterFestivalApp();
    },
  );
}

void bootstrap(Future<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(await builder());
}
```