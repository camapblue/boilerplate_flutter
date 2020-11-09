import 'package:flutter/material.dart';

typedef Widget StoryBuider();
typedef RenderFunction = void Function(Function render);

class StatefulStory extends StatefulWidget {
  final StoryBuider builder;
  final RenderFunction renderFunction;
  StatefulStory({@required this.builder, @required this.renderFunction});

  @override
  State<StatefulWidget> createState() {
    return _StatefulStory();
  }
}

class _StatefulStory extends State<StatefulStory> {
  @override
  void initState() {
    super.initState();

    widget.renderFunction(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder();
  }
}
