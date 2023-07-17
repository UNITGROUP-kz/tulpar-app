
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenDefaultTemplate extends StatefulWidget {

  final Future<void> Function()? onRefresh;
  final List<Widget>? children;

  const ScreenDefaultTemplate({super.key, this.children, this.onRefresh});

  @override
  State<ScreenDefaultTemplate> createState() => _ScreenDefaultTemplateState();
}

class _ScreenDefaultTemplateState extends State<ScreenDefaultTemplate> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future _refresh() {
    return Future(() => null);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoScrollbar(
      controller: _scrollController,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          if(widget.onRefresh != null) CupertinoSliverRefreshControl(
            onRefresh: widget.onRefresh,
            refreshIndicatorExtent: 100.0,
            refreshTriggerPullDistance: 120.0,
            builder: (BuildContext context, RefreshIndicatorMode refreshState, double pulledExtent, double refreshTriggerPullDistance, double refreshIndicatorExtent) {
              return CupertinoSliverRefreshControl.buildRefreshIndicator(
                context,
                refreshState,
                pulledExtent,
                refreshTriggerPullDistance,
                refreshIndicatorExtent,
              );
            },
          ),
          SliverToBoxAdapter(
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                  children: widget.children ?? []
              ),
            ),
          )
        ]

      ),
    );
  }
}