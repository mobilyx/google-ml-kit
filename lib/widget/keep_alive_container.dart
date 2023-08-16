import 'package:flutter/material.dart';

class KeepAliveContainer extends StatefulWidget {
  const KeepAliveContainer({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<KeepAliveContainer> createState() => _KeepAliveContainerState();
}

class _KeepAliveContainerState extends State<KeepAliveContainer>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
