
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenDefaultTemplate extends StatefulWidget {
  final EdgeInsets padding;
  final Future<void> Function()? onRefresh;
  final List<Widget>? children;
  final ScrollController? scrollController;

  const ScreenDefaultTemplate({
    super.key,
    this.children,
    this.onRefresh,
    this.padding = const EdgeInsets.all(20),
    this.scrollController
  });

  @override
  State<ScreenDefaultTemplate> createState() => _ScreenDefaultTemplateState();
}

class _ScreenDefaultTemplateState extends State<ScreenDefaultTemplate> {

  @override
  Widget build(BuildContext context) {
    return CupertinoScrollbar(
      controller: widget.scrollController,
      child: CustomScrollView(
        controller: widget.scrollController,
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
              padding: widget.padding,
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