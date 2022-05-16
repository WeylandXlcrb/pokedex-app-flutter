import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:pokedex_app/colors.dart';
import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/enums/pagination_state.dart';
import 'package:pokedex_app/models/named_api_resource_list.dart';
import 'package:pokedex_app/repos/pokemons_repo.dart';
import 'package:pokedex_app/screens/pokemon_details/pokemon_details_screen.dart';
import 'package:pokedex_app/screens/pokemons/widgets/pokemon_card.dart';
import 'package:pokedex_app/widgets/pokeball_loading_indicator.dart';

class PokemonsScreen extends StatefulWidget {
  static const routeName = 'pokemons';

  const PokemonsScreen({Key? key}) : super(key: key);

  @override
  State<PokemonsScreen> createState() => _PokemonsScreenState();
}

class _PokemonsScreenState extends State<PokemonsScreen> {
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

      _fetchPokemons(page: _currentPage + 1, isAppending: true);
    });
    _fetchPokemons();
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

  void _fetchPokemons({int page = 1, bool isAppending = false}) async {
    if (_paginationState != PaginationState.idle) {
      return;
    }

    setState(() {
      _hasError = false;
      _paginationState =
          isAppending ? PaginationState.appending : PaginationState.loading;
    });

    try {
      final resList =
          await context.read<PokemonsRepo>().getPokemonList(page: page);

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
    final Widget body;

    if (_hasError) {
      body = Center(
        child: Column(
          children: [
            const Text('An error has occurred'),
            TextButton(
              onPressed: _fetchPokemons,
              child: const Text('Try again'),
            ),
          ],
        ),
      );
    } else if (_paginationState == PaginationState.loading) {
      body = const Center(
        child: PokeballLoadingIndicator(),
      );
    } else {
      var itemCount = _resourceList!.results.length;

      if (_paginationState == PaginationState.appending) {
        itemCount += 1;
      }

      body = ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.all(kPaddingDefault * 1.5),
        itemCount: itemCount,
        separatorBuilder: (_, __) => const SizedBox(height: 16.0),
        itemBuilder: (_, index) {
          if (_paginationState == PaginationState.appending &&
              index == itemCount - 1) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: PokeballLoadingIndicator()),
            );
          }

          final resource = _resourceList!.results[index];

          return PokemonCard(
            pokemonName: resource.name,
            onTap: () => context.goNamed(
              PokemonDetailsScreen.routeName,
              params: {'name': resource.name},
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemons'),
        backgroundColor: CategoryColors.pokemons,
        elevation: 0,
      ),
      body: body,
    );
  }
}
