import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:stock_app/component/symbol_tile.dart';
import 'package:stock_app/repositories/symbol_repository/symbol_repository.dart';
import 'package:stock_app/screen/home/bloc/home_bloc.dart';
import 'package:stock_app/screen/home/bloc/home_event.dart';
import 'package:stock_app/screen/home/bloc/home_state.dart';
import 'package:stock_app/screen/login/view/login.dart';
import 'package:stock_app/util/globals.dart';
import 'package:stock_app/util/navigate.dart';
import 'package:stock_app/util/string.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SymbolRepository repository = SymbolRepository();
    return BlocProvider(
      create: (_) => HomeBloc(symbolRepository: repository),
      child: const HomePageView(),
    );
  }

}

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageViewState();

}

class _HomePageViewState extends State<HomePageView> {
  late ScrollController _scrollController;

  void _scrollListener() {
    setState(() {
      if (_scrollController.position.extentAfter < 0.2 * screenHeight) {
        context.read<HomeBloc>().add(const HomeLoadMoreFavoriteSymbol(id: '',));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    print(screenHeight);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.08,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Row(
          children: [
            SizedBox(width: 0.01 * screenWidth,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stockString,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Text(
                  '${DateTime.now().day} ${month.elementAt(DateTime.now().month)}',
                  style: const TextStyle(
                    color: Color(0xFF9F9F9F),
                    fontWeight: FontWeight.bold,
                    fontSize: 27,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          InkWell(
            child: ProfilePicture(
              name: account.name,
              radius: 0.025 * screenHeight,
              fontsize: 18,
            ),
            onTap: () {
              Navigate.pushPage(context, LoginPage());
            },
          ),
          SizedBox(width: screenWidth * 0.05,)
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.03,),
              Container(
                width: double.infinity,
                height: screenHeight * 0.05,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(201, 201, 201, 1),
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
                child: TextField(
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: Colors.black, size: 20,),
                    hintText: searchString,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  autofocus: false,
                  cursorColor: Colors.blue,
                  onChanged: (text) {
                    context.read<HomeBloc>().add(HomeSearchSymbol(searchContent: text));
                  },
                ),
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state.searchContent == '') {
                    switch (state.symbolTileListStatus) {
                      case HomeStatus.initial:
                        context.read<HomeBloc>().add(const HomeSubscriptionRequest(id: ''));
                        return const Center();
                      case HomeStatus.loading:
                        return Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 0.02 * screenHeight,);
                              },
                              itemBuilder: (context, index) {
                                return SymbolRow(
                                  close: state.symbolTileList.elementAt(index).close,
                                  regularMarketPrice: state.symbolTileList.elementAt(index).regularMarketPrice,
                                  previousClose: state.symbolTileList.elementAt(index).previousClose,
                                  symbol: state.symbolTileList.elementAt(index).symbol,
                                  shortName: state.symbolTileList.elementAt(index).shortName,
                                );
                              },
                              itemCount: state.symbolTileList.length,
                            ),
                            const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        );
                      case HomeStatus.success:
                        return Column(
                          children: [
                            SizedBox(height: screenHeight * 0.02,),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 0.02 * screenHeight,);
                              },
                              itemBuilder: (context, index) {
                                return SymbolRow(
                                  close: state.symbolTileList.elementAt(index).close,
                                  regularMarketPrice: state.symbolTileList.elementAt(index).regularMarketPrice,
                                  previousClose: state.symbolTileList.elementAt(index).previousClose,
                                  symbol: state.symbolTileList.elementAt(index).symbol,
                                  shortName: state.symbolTileList.elementAt(index).shortName,
                                );
                              },
                              itemCount: state.symbolTileList.length,
                            ),
                          ],
                        );
                      case HomeStatus.failure:
                        return const Center(
                          child: Text("Something went wrong", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold,),),
                        );
                    }
                  } else {
                    switch (state.symbolTileSearchListStatus) {
                      case HomeStatus.initial:
                        return const Center();
                      case HomeStatus.loading:
                        return Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 0.02 * screenHeight,);
                              },
                              itemBuilder: (context, index) {
                                return SymbolRow(
                                  close: state.symbolTileSearchList.elementAt(index).close,
                                  regularMarketPrice: state.symbolTileSearchList.elementAt(index).regularMarketPrice,
                                  previousClose: state.symbolTileSearchList.elementAt(index).previousClose,
                                  symbol: state.symbolTileSearchList.elementAt(index).symbol,
                                  shortName: state.symbolTileSearchList.elementAt(index).shortName,
                                );
                              },
                              itemCount: state.symbolTileSearchList.length,
                            ),
                            const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        );
                      case HomeStatus.success:
                        return Column(
                          children: [
                            SizedBox(height: screenHeight * 0.02,),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 0.02 * screenHeight,);
                              },
                              itemBuilder: (context, index) {
                                return SymbolRow(
                                  close: state.symbolTileSearchList.elementAt(index).close,
                                  regularMarketPrice: state.symbolTileSearchList.elementAt(index).regularMarketPrice,
                                  previousClose: state.symbolTileSearchList.elementAt(index).previousClose,
                                  symbol: state.symbolTileSearchList.elementAt(index).symbol,
                                  shortName: state.symbolTileSearchList.elementAt(index).shortName,
                                );
                              },
                              itemCount: state.symbolTileSearchList.length,
                            ),
                          ],
                        );
                      case HomeStatus.failure:
                        return const Center(
                          child: Text("Something went wrong", style: TextStyle(color: Colors.black, fontSize: 30),),
                        );
                    }
                  }
                },
              ),
            ],
          )
        ),
      ),
    );
  }

}