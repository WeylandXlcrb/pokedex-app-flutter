import 'package:flutter/material.dart';

import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/enums/pagination_state.dart';
import 'package:pokedex_app/models/named_api_resource.dart';
import 'package:pokedex_app/models/named_api_resource_list.dart';
import 'package:pokedex_app/widgets/pokeball_loading_indicator.dart';

typedef IndexedResourceWidgetBuilder = Widget Function(
  BuildContext context,
  int index,
  NamedAPIResource resource,
);

typedef PageFetcher = Future<NamedAPIResourceList> Function({
  int limit,
  int page,
});

class PaginatedResourceList extends StatefulWidget {
  final IndexedWidgetBuilder separatorBuilder;
  final IndexedResourceWidgetBuilder itemBuilder;
  final PageFetcher pageFetcher;
  final EdgeInsetsGeometry? padding;

  const PaginatedResourceList({
    Key? key,
    required this.separatorBuilder,
    required this.itemBuilder,
    required this.pageFetcher,
    this.padding,
  }) : super(key: key);

  @override
  State<PaginatedResourceList> createState() => _PaginatedResourceListState();
}

class _PaginatedResourceListState extends State<PaginatedResourceList> {
  final _scrollController = ScrollController();

  var _paginationState = PaginationState.idle;
  var _currentPage = 1;
  var _hasError = false;
  NamedAPIResourceList? _resourceList;

  bool get _isScrollThresholdReached =>
      _scrollController.offset >=
      _scrollController.position.maxScrollExtent - kPaginationPreloadThreshold;

  bool get _isLastPage => _resourceList?.next == null;

  bool get _canLoadMore =>
      _paginationState == PaginationState.idle &&
      !_isLastPage &&
      _isScrollThresholdReached;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (!_canLoadMore) {
        return;
      }

      _fetchPage(page: _currentPage + 1, isAppending: true);
    });
    _fetchPage();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchPage({int page = 1, bool isAppending = false}) async {
    if (_paginationState != PaginationState.idle) {
      return;
    }

    setState(() {
      _hasError = false;
      _paginationState =
          isAppending ? PaginationState.appending : PaginationState.loading;
    });

    try {
      final resList = await widget.pageFetcher(page: page);

      setState(() {
        _resourceList = _resourceList?.rebuild((rL) => rL
              ..previous = resList.previous
              ..next = resList.next
              ..results.addAll(resList.results)) ??
            resList;
        _currentPage = page;
      });
    } catch (err) {
      print(err);
      setState(() => _hasError = true);
    } finally {
      setState(() => _paginationState = PaginationState.idle);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Center(
        child: Column(
          children: [
            const Text('An error has occurred'),
            TextButton(
              onPressed: _fetchPage,
              child: const Text('Try again'),
            ),
          ],
        ),
      );
    } else if (_paginationState == PaginationState.loading) {
      return const Center(
        child: PokeballLoadingIndicator(),
      );
    } else {
      var itemCount = _resourceList!.results.length;

      if (_paginationState == PaginationState.appending) {
        itemCount += 1;
      }

      return ListView.separated(
        controller: _scrollController,
        padding: widget.padding ?? const EdgeInsets.all(kPaddingDefault * 1.5),
        itemCount: itemCount,
        separatorBuilder: widget.separatorBuilder,
        itemBuilder: (context, index) {
          if (_paginationState == PaginationState.appending &&
              index == itemCount - 1) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: PokeballLoadingIndicator()),
            );
          }

          final resource = _resourceList!.results[index];

          return widget.itemBuilder(context, index, resource);
        },
      );
    }
  }
}
