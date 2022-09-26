library storybook;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
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
/// runApp(
///     MaterialApp(
///         home: Storybook([
///             MyFancyWidgetStory(),
///             MyBasicWidgetStory(),
///         ])));
/// ```

class Storybook extends StatefulWidget {
  const Storybook(this.stories, {Key? key}) : super(key: key);

  final List<Story> stories;

  @override
  State<Storybook> createState() => _StorybookState();
}

class _StorybookState extends State<Storybook> {
  StoryScreen? _screen;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (widget.stories.isNotEmpty) {
          final screen = widget.stories.first.firstWidget;
          if (screen != null) {
            setState(() {
              _screen = screen;
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Storybook')),
      body: kIsWeb
          ? Row(
              children: [
                SizedBox(
                  width: 300,
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) =>
                        widget.stories[index]
                          ..addOnStoryTapped(
                            (screen) => setState(
                              () {
                                _screen = screen;
                              },
                            ),
                          ),
                    itemCount: widget.stories.length,
                  ),
                ),
                Expanded(
                  child: _screen ?? const SizedBox(),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) =>
                  widget.stories[index],
              itemCount: widget.stories.length,
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
  final String? title;
  final StoryBuilder builder;
  const WidgetMap({this.title, required this.builder});
}

class StoryScreen extends StatelessWidget {
  final StoryBuilder builder;
  final String title;
  final AppBar? appBar;

  const StoryScreen(this.title, this.appBar, this.builder, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? Scaffold(body: builder(context))
        : Scaffold(
            appBar: appBar ??
                AppBar(
                  title: Text(title),
                ),
            body: builder(context),
          );
  }
}

typedef OnStoryTapped = void Function(StoryScreen);

// ignore: must_be_immutable
abstract class Story extends StatelessWidget {
  Story({Key? key}) : super(key: key);

  List<WidgetMap> storyContent();

  String get title => runtimeType.toString();

  AppBar? get appBar => null;

  OnStoryTapped? _onStoryTapped;

  StoryScreen? get firstWidget {
    final content = storyContent();
    final storyScreen = StoryScreen(
      content[0].title ?? title,
      appBar,
      content[0].builder,
    );

    return storyScreen;
  }

  // ignore: use_setters_to_change_properties
  void addOnStoryTapped(OnStoryTapped onTapped) {
    _onStoryTapped = onTapped;
  }

  Widget _widgetTileLauncher(
          StoryBuilder builder, String title, BuildContext context) =>
      ListTile(
        leading: const Icon(Icons.launch),
        title: Text(title),
        onTap: () {
          final storyScreen = StoryScreen(title, appBar, builder);
          if (_onStoryTapped != null) {
            _onStoryTapped!(storyScreen);
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (_) {
                return storyScreen;
              },
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    final content = storyContent();
    if (content.length == 1) {
      return _widgetTileLauncher(
          content[0].builder, content[0].title ?? title, context);
    } else {
      return ExpansionTile(
        leading: const Icon(Icons.fullscreen),
        key: PageStorageKey<Story>(this),
        title: Text(title),
        children: content
            .map((WidgetMap w) =>
                _widgetTileLauncher(w.builder, w.title ?? title, context))
            .toList(),
      );
    }
  }
}
