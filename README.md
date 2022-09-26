# boilerplate_flutter

Boilerplate Flutter

## Getting Started

This project is a mobile app of Boilerplate that building by Flutter.

## Awareness
- Always think about the milion users are using this app, so it must be the **World Class** app
- Coding is not just feature done, it's the **reflection of success**
- To get the best quality, must have the **best solution**
- Always think about & follow up **SOLID principal** for every solutions
- Naming is **VERY VERY IMPORTANT**, it's not coding, it's solution

## Architecture

Apply Clean Architecture + BloC pattern 
```
|---------------  Layers  --------------|
| Presentations | Business Logic | Data |
|:-------------------------------------:|

|--------------------------  Actual  ---------------------------|
| Presentations  |      Business Logic    |         Data        |
|:-------------------------------------------------------------:|
| Module <--> Bloc <--> Service <--> Repository <--> Client/Dao |
|:-------------------------------------------------------------:|
|:----  Extension Entity   ----|----    Basic Entity   --------:|
|:-------------------------------------------------------------:|
```
### Module
- This is the major view layer of mobile app and is categorized by module (feature or epic). 
- View (widget) is rendered based on the bloc state if needed. 
- Widgets that are used across module will be placed in *widgets folder* and **MUST NOT** build based on bloc state.
- All common widgets will be imported from local package call *common*
- A widget or screen can have multiple blocs to control UI's state or no blocs at all.

Examples of a standard widget that build based on bloc states:
```
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoaderBloc, LoaderState>(
      builder: (context, state) {
        return Visibility(
            visible: state is LoaderRunSuccess,
            child: Container(
              color: Colors.green.withAlpha(100),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ));
      },
    );
  }
```

### Bloc
- It's the main stateful layer that keep all app's state and data.
- Data must keep in State class, not in bloc itself 
- Bloc can handle all UI's business, such as proceed an user's action, control loading flow, change theme or update new language, ... All UIs that need update by state, it's responsible of Bloc
- Bloc is managed through by EventBus, control constructor and dispose, communicate between blocs by add event or listen state changes, and even for broadcast on global channel
- The naming convention to define Event and State class can reference [here](https://bloclibrary.dev/#/blocnamingconventions)
- State class **MUST** be extended by Equatable, but Event class.
- BaseBloc is advanced class of Bloc to handle some generic business such as show/hide app loading (locked loading), handle callApi with common error handling.
- Bloc key is required for all blocs, use Constants to define key.
- Bloc can reference to multiple services to handle business, but less is better.

Example of Bloc new instance:
```
  BlocProvider<LanguageBloc>(create: (_) => LanguageBloc.instance())
```

Static method for bloc constructor:
```
  static LanguageBloc instance() {
    return EventBus().newBloc(Keys.blocs().languageBloc, LanguageBloc)
        as LanguageBloc;
  }
```

and the constructor in DI class:
```
  LanguageBloc: (Key key) => LanguageBloc(key, settingService: Provider().settingService)
```

### Service
- It's the main layer to handle all data business
- It's a stateless layer, so it will be constructed on demand
- A service may contain many usecases that belong to a same module or epic
- A service can communicate with other services
- All services **MUST** be defined with an interface (abstract class), bloc communicate with service through by the interface 

### Repository
- It's imported from local package name *repository*
- The main data source of app that is used by service layer
- It's a stateless layer, so it will be constructed on demand
- It contains a little bit business rules to branch data source that should be used, from client or dao
- It also handle the caching logic rules, from memory or local storage
- All repositories **MUST** be defined with an interface (abstract class), service communicate with repository through by the interface 

### Client/Dao
- It's data source layer, client means data is from RestFul API and dao means data is from local storage
- BaseBloc is advanced class to handle all generic calling API, retry when access token is expired and need to refresh, also for general API error handling
- BaseDao is advanced class to handle the generic storage, save/get list or item, or even for a string or an integer
- All clients & daos **MUST** be defined with an interface (abstract class), repository communicate with client/dao through by the interface 

### Model
- It covers all entities in app
- Have 2 kind of models, basic entity and extension entity.
- Basic entity is belong to repository, it defines all entity's properties and support basic parsing with JSON
- Extension entity is belong to UI layer, it defines all utility methods of an entity
- All entity **MUST** extended by Equatable that useful in smart comparation

## Dependencies Injection
- There are 3 kinds of class to support construct instance for DI, EventBus, Provider and Repository
- EventBus is a singleton class that not only work as a bloc manager but also support to provider bloc instance. All constructor of bloc should be a static function inside Bloc class for easy to maintain.
- Provider is a singleton class that provide the instance of service.
- Repository is a singleton class that provide the instance of repository, client & dao

Example for DI of service class:
```
  UserService get userService =>
        UserServiceImpl(userRepository: Repository().userRepository);
```

and repository class:
```
  UserRepository get userRepository =>
      UserRepositoryImpl(userClient: userClient, userDao: userDao);
```

## Code Structure
Here is list all of key folders or files in code structure:
```
.
|-- assets                              *store all assets that are font, icon, image, video or animation*
|   |-- animations                      *support .flr file to play vector animation*
|   |-- fonts                           *prefer .ttf file font*
|   |-- icons                           *support .svg file*
|   |-- images                          *support .png file and need 3 sizes with the same name*               
|       |-- 2.0x      
|       |   |-- image.png               *2x size image file, calculate by pixel*
|       |-- 3.0x
|       |   |-- image.png               *3x size image file, calculate by pixel*
|       |-- image.png                   *1x size image file, calculate by pixel*
|-- common                              *local package that includes all common things can be used in other project*
|   |-- lib
|       |-- extension                   *all common extension such as string, int, color, ...*
|       |-- logging                     *interface & class that support logging*
|-- environments                        *setup all configs that based on the environment, using .ENV file*
|   |-- dev                             *Development environment*
|   |-- prod                            *Production environment*
|   |-- qc                              *Testing environment*
|-- lib
|   |-- blocs                           *all blocs that need in project*
|       |-- language                    *each bloc has a folder with name of bloc only*
|           |-- language_bloc.dart      *the Bloc class that extends of BaseBloc*
|           |-- language_event.dart     *define all Event class, must follow the naming convention strongly*
|           |-- language_state.dart     *define all State class that extends of Equatable, must follow the naming convention*
|           |-- language.dart           *the index file that export all files in bloc folder*
|   |-- configs
|       |-- configs.dart                *Configs class, a singleton instance to get data from environment configs*
|   |-- constants                       *define all constant values such Keys, Strings, ...*
|   |-- i18n                            *define all localization strings that json format*
|   |-- models                          *define all extension entities and all entities that need in UI layer*
|   |-- modules                         *define all UI widgets that categorized by module or epic*
|   |-- services                        *define all service classes*
|   |-- utils                           *define all utility classes*
|   |-- widgets                         *define all common widgets and can use across modules but not use bloc inside*
|   |-- localization.dart               *the class that implement the localiztion feature*
|   |-- main.dart                       *the main class that app launch from*
|   |-- provider.dart                   *the singleton class that supports DI for service classes*
|   |-- routes.dart                     *define the root routes of app*
|-- repository
|   |-- lib
|   |   |-- client                      *define all client classes*
|   |   |-- dao                         *define all dao classes*
|   |   |-- exception                   *define all exceptions that return from RestfulAPI*
|   |   |-- model                       *define all basic entities*
|   |   |-- repository                  *define all repository classes*
|   |   |-- configs.dart                *Configs class for data layer, all config values from environment*
|   |   |-- repository.dart             *Repository class, singleton class that support DI for data layer*
|   |-- test                            *unit testing for repository, require testing for repositorry only*
|-- storybook                           *define all widgets that add in storybook*
|-- test                                *unit testing for service & bloc, widget is optional*
|-- pubspec.yaml                        *dependencies configuration for flutter app*
|-- run-tests.sh                        *shell script to run unit test & show coverage*                        
|-- run.sh                              *shell script to run app with environment support*
|-- storybook.sh                        *shell script to run storybook*
```

## Storybook
It's used for view all common widgets (only widgets that are not based on bloc to render). It **MUST** cover all widgets that in common package and in widgets folder.

How to add widget into storybook:
1. Create a story file to add widget into. A story file should cover all states of the widget, not only the happy case.
2. Export the story file in index file at /storybook/lib/stories/stories.dart
3. Add new story into storybook/lib/main.dart

To start running storybook, run shell script: `./storybook.sh`

## Theme
- Do not create new extension for ThemeData for any reason. Instead that, we AppThemeData extension to apply theme in UI.
- The theme data is based on Theme entity and will be updated accordingly 
- The theme will be applied only in modules folder. Other widgets (in common package or widgets folder) don't apply theme data, it **MUST** support to customize theme if needed.

## Environment
- All configurations data **MUST** set in .evn files, includes configurations for UI layers, service layers, repository layers, and even for common package.
- Configs class, a singleton class is set for all packages that need to load configuration data
- For testing purpose, the configuration data should be passed as parameters in constructor of class instead of hard using.

To run app with setting new environment for qc, run shell script:
```
  ./run.sh -e qc
```

For the next run with qc environement, it can be run normally with Flutter command `flutter run`

## Testing
- All Blocs **MUST** have unit testing for all Events and StreamSubscriptions, except static constructor.
- All Services **MUST** have unit testing for all public methods.
- All Repositories **MUST** have unit testing for all public methods.

```
  flutter packages pub run build_runner build --delete-conflicting-outputs
```

## Logging
- Support logging for 6 standard levels of logs, here is lists (order by the priority of log)
  1. fatal: *for any issuse that kill the app or business*
  2. error: *for any exception that the app catch*
  3. warning: *for any potential error, invalid data or unexpected value that cause lead to error*
  4. info: *for log actions or events from end-user*
  5. debug: *for debug purpose and will not see in production, only see in development or testing mode*
  6. trace: *for tracking in order to identify bugs, do not keep it when bug is resolved*
- The logging level for each environment will be set in .env files
- The Log class is a singleton and be able to get from singleton instance of Common class

## Donations

Please give me a coffee if it's helpful for you. Thanks ^_^

[![](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.me/lequangdaoitm/10)

