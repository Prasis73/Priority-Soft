import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_shoes/core/const/app_text_styles.dart';
import 'package:get_shoes/features/products/data/repositories/product_repository_impl.dart';
import 'package:get_shoes/features/products/presentation/bloc/discover_bloc.dart';
import 'package:get_shoes/features/products/presentation/bloc/discover_event.dart';
import 'package:get_shoes/features/products/presentation/bloc/discover_state.dart';
import 'package:get_shoes/features/products/presentation/pages/filter_option_page.dart';
import 'package:get_shoes/features/products/presentation/widgets/product_card.dart';
import 'package:get_shoes/features/products/presentation/widgets/cart_icon_badge.dart';

import 'package:google_fonts/google_fonts.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  Map<String, dynamic> currentFilters = {};
  final filters = ['All', 'Nike', 'Jordan', 'Adidas', 'Reebok'];
  String selectedBrand = "All";
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    context.read<DiscoverBloc>().add(FetchProducts());
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<DiscoverBloc>().add(FetchMoreProducts());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Discover',
          style: TextStyle(
              color: Color(0xff101010),
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          const CartIcon(),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.of(context).pushReplacementNamed('/login');
                  });
                },
                child: const Icon(Icons.logout)),
          )
        ],
      ),
      body: BlocProvider(
        create: (context) =>
            DiscoverBloc(ProductRepository())..add(FetchProducts()),
        child: BlocBuilder<DiscoverBloc, DiscoverState>(
          builder: (context, state) {
            if (state is DiscoverLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DiscoverLoaded) {
              return Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: filters.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 0.0),
                              child: TextButton(
                                child: Text(
                                  filters[index].toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: selectedBrand == filters[index]
                                          ? Colors.black
                                          : Colors.grey),
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedBrand = filters[index];
                                  });

                                  context.read<DiscoverBloc>().add(
                                      FetchProducts(
                                          filters: index == 0
                                              ? null
                                              : {'brand': filters[index]}));
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      state.products.isEmpty
                          ? Text(
                              "Empty Products",
                              style: AppTextStyles.semiBoldStyle16
                                  .copyWith(color: Colors.grey),
                            )
                          : Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: GridView.builder(
                                  controller: _scrollController,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 0.74,
                                          crossAxisSpacing: 10),
                                  itemCount: state.hasReachedMax
                                      ? state.products.length
                                      : state.products.length + 1,
                                  itemBuilder: (context, index) {
                                    final product = state.products[index];
                                    if (index >= state.products.length) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                    return InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              '/productDetails',
                                              arguments: product);
                                        },
                                        child: ProductCard(product: product));
                                  },
                                ),
                              ),
                            ),
                    ],
                  ),
                  Positioned(
                      child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () async {
                          Map<String, dynamic> currentFilters = {};
                          final filters = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FilterOptionsPage(
                                currentFilters: currentFilters,
                              ),
                            ),
                          );
                          if (filters != null) {
                            setState(() {
                              currentFilters = filters;
                            });

                            BlocProvider.of<DiscoverBloc>(context)
                                .add(FetchProducts(filters: currentFilters));
                            // setState(() {});
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 119,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.black),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/filter.svg',
                                    colorFilter: const ColorFilter.mode(
                                        Colors.white, BlendMode.srcIn),
                                  ),
                                  if (currentFilters['brand'] != null ||
                                      currentFilters['priceRange'] != null ||
                                      currentFilters['colors'] != null)
                                    const Positioned(
                                      top: 0,
                                      right: 0,
                                      child: CircleAvatar(
                                        radius: 3.5,
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(
                                width: 12.0,
                              ),
                              Text(
                                "FILTER",
                                style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))
                ],
              );
            } else if (state is DiscoverError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('No products available'));
          },
        ),
      ),
    );
  }
}
