import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HymnList extends StatefulWidget {
  const HymnList({super.key, required this.file});

  final String file;

  @override
  State<HymnList> createState() => _HymnListState();
}

class _HymnListState extends State<HymnList> {
  List<String> hymns = [];

  @override
  void initState() {
    super.initState();

    DefaultAssetBundle.of(context).loadString(widget.file).then((file) =>
        setState(() => hymns = file.split(RegExp(r'\d{3}')).skip(1).toList()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hymns – ${widget.file.substring(13)} – ${hymns.length}'),
      ),
      body: ListView.builder(
        itemCount: hymns.length,
        itemBuilder: (context, i) {
          final content = '${i + 1}. ${hymns[i].trim()}';
          return OutlinedButton(
            onPressed: () {
              Get.to(() => HymnDisplay(hymnContent: content));
            },
            child: SizedBox(
              width: Get.width,
              child: Text(
                content.firstLine,
                textAlign: TextAlign.start,
              ),
            ),
          );
        },
      ),
    );
  }
}

class HymnDisplay extends StatelessWidget {
  const HymnDisplay({super.key, required this.hymnContent});

  final String hymnContent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hymnContent.firstLine),
      ),
      body: ListView(
        children: [
          Center(
            child: Text(
              hymnContent,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ],
      ),
    );
  }
}

extension FirstLine on String {
  String get firstLine => substring(0, indexOf('\n'));
}
