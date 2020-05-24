import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoadContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool cover;

  const LoadContainer(
      {Key key, @required this.child, this.isLoading, this.cover = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return !cover
        ? !isLoading ? child : _loadingView
        : Stack(
            children: <Widget>[child, isLoading ? _loadingView : null],
          );
  }

  Widget get _loadingView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
