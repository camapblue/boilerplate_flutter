library storybook;

import 'package:flutter/material.dart';
// import 'package:boilerplate_flutter/models/models.dart';
export 'stateful_story.dart';

/// A Storybook is a widget displaying a collection of [Story] widgets.
///
/// The Storybook is a simple [Scaffold] widget that displays its [Story]
/// widgets in vertical [ListView].
///
/// Storybook.
///
///
///

/// ## Sample code
///
/// ```dart
/// runApp(new StoryboardApp([
///     new MyFancyWidgetStory(),
///     new MyBasicWidgetStory(),
/// ]));
/// ```
class StoryboardApp extends MaterialApp {
  /// Creates a new Storyboard App.
  ///
  ///  * [stories] defines the list of stories that will be combined into
  ///  a storyboard.
  StoryboardApp(List<Story> stories)
      : assert(stories != null, 'stories musst not be null'),
        super(home: Storybook(stories));
}

/// ## Sample code
///
/// ```dart
/// runApp(
///     MaterialApp(
///         home: Storybook([
///             MyFancyWidgetStory(),
///             MyBasicWidgetStory(),
///         ])));
/// ```

class Storybook extends StatelessWidget {
  final _kStoryBookTitle = 'Storybook';

  Storybook(this.stories)
      : assert(stories != null, 'stories must not be null'),
        super();

  final List<Story> stories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_kStoryBookTitle)),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) => stories[index],
        itemCount: stories.length,
      ),
    );
  }
}

/// A Story widget is intended as a single "page" of a [Storybook].  It is
/// intended that authors write their own concrete implementations of Stories
/// to include in a [Storybook].
///
/// A story consists of one or more Widgets.  Each Story is rendered as either
/// a [ExpansionTile] or, in the case when there exists only a single
/// fullscreen widget, as [ListTile].
///
/// The story's Widget children are arranged as a series of [Row]s within an
/// ExpansionTile, or if the widget is full screen, is displayed by navigating
/// to a route.
///

typedef StoryBuilder = Widget Function(BuildContext context);

class WidgetMap {
  final String title;
  final StoryBuilder builder;
  const WidgetMap({this.title, this.builder});
}

class StoryScreen extends StatelessWidget {
  final StoryBuilder builder;
  final String title;
  final AppBar appBar;
  
  StoryScreen(this.title, this.appBar, this.builder);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ??
          AppBar(
            title: Text(title),
          ),
      body: builder(context),
    );
  }
}

abstract class Story extends StatelessWidget {
  const Story({Key key}) : super(key: key);

  List<WidgetMap> storyContent();

  String get title => runtimeType.toString();

  AppBar get appBar => null;

  Widget _widgetTileLauncher(
          StoryBuilder builder, String title, BuildContext context) =>
      ListTile(
        leading: const Icon(Icons.launch),
        title: Text(title),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<Null>(
              builder: (_) {
                return StoryScreen(title, appBar, builder);
              },
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    final List<WidgetMap> _storyContent = storyContent();
    if (_storyContent.length == 1) {
      return _widgetTileLauncher(
          _storyContent[0].builder, _storyContent[0].title ?? title, context);
    } else {
      return ExpansionTile(
        leading: const Icon(Icons.fullscreen),
        key: PageStorageKey<Story>(this),
        title: Text(title),
        children: _storyContent
            .map((WidgetMap w) =>
                _widgetTileLauncher(w.builder, w.title ?? title, context))
            .toList(),
      );
    }
  }
}
