library flutter_changelog;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

/// Opens up a [ChangeLogScreen]
class ChangeLogScreen extends StatelessWidget {
  final Widget title;
  final String markdownData;
  final bool showAppBar;
  final String markdownFilePath;

  final ScrollController scrollController = ScrollController();

  ChangeLogScreen({
    this.title,
    this.markdownData,
    this.showAppBar = true,
    this.markdownFilePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: title ?? Text(""),
              leading: IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            )
          : null,
      body: SafeArea(
        child: markdownFilePath != null
            ? FutureBuilder(
                future: rootBundle.loadString(markdownFilePath),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return Markdown(
                      controller: scrollController,
                      data: snapshot.data,
                    );
                  }

                  return Center(child: CircularProgressIndicator());
                },
              )
            : Markdown(
                controller: scrollController,
                data: markdownData,
              ),
      ),
    );
  }
}
