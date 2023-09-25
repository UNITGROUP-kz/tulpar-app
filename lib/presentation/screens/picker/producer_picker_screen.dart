import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/data/enums/fetch_status.dart';
import 'package:garage/data/models/dictionary/producer_model.dart';

import '../../../logic/bloc/dictionary/producer/producer_cubit.dart';
import '../../widgets/form/fields/text_field.dart';
import '../../widgets/screen_templates/screen_default_template.dart';
import '../../widgets/tiles/producer_tile.dart';


@RoutePage<ProducerModel>()
class ProducerPickerScreen extends StatefulWidget {
  @override
  State<ProducerPickerScreen> createState() => _ProducerPickerScreenState();
}

class _ProducerPickerScreenState extends State<ProducerPickerScreen> {
  late ScrollController _scrollController;
  final Map<String, GlobalKey> list = {};

  @override
  void initState() {
    _refresh();
    _scrollController = ScrollController()..addListener(_listenerScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listenerScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future _refresh() async {
    return await context.read<ProducerCubit>().fetch();
  }

  _listenerScroll() async {
    if(_scrollController.position.maxScrollExtent < _scrollController.position.pixels + 200) {
      final params = context.read<ProducerCubit>().state.params;
      await context.read<ProducerCubit>().fetch(params?.copyWith(
          startRow: params.startRow + params.rowsPerPage
      ));
    }
  }

  _back(ProducerModel producer) => () {
    context.router.pop<ProducerModel>(producer);
  };

  _onFilter(String text) async {
    final params = context.read<ProducerCubit>().state.params;
    await context.read<ProducerCubit>().fetch(params?.copyWith(
        filter: text,
        startRow: 0
    ));
  }
  
  _toScrollLetter(String letter) => () {
    if(list[letter] != null) {
      RenderBox renderBox = list[letter]?.currentContext?.findRenderObject() as RenderBox;
      _scrollController.animateTo(
          renderBox.localToGlobal(Offset.zero).dy + _scrollController.offset - 50,
          duration: Duration(milliseconds: 100), // длительность анимации
          curve: Curves.easeInOut
      );
    }
  };

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      onRefresh: _refresh,
      scrollController: _scrollController,
      padding: EdgeInsets.zero,
      children: [
        Padding(
            padding: EdgeInsets.all(20),
            child: TextFieldWidget(icon: Icon(Icons.search), onSubmit: _onFilter,)
        ),
        BlocBuilder<ProducerCubit, ProducerState>(
          buildWhen: (context, state) {
            list.clear();
            return true;
          },
          builder: (context, state) {
            print('build');

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(state.popular.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0, bottom: 20),
                    child: Text('Популярные', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                  ),
                  ...state.popular.map((producer) {
                    return ProducerTile(producer: producer, callback: _back(producer));
                  }).toList(),
                  const SizedBox(height: 40),
                ],
                if(state.producers.isNotEmpty)...[

                  const Padding(
                    padding: EdgeInsets.only(left: 20.0, bottom: 20),
                    child: Text('По алфавиту', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                          children: state.letter.map((e) {
                            return GestureDetector(
                              onTap: _toScrollLetter(e),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.shade800,
                                ),
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.all(7),
                                child: Text(e, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                              ),
                            );
                          }).toList()
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...state.producers.map((producer) {
                    GlobalKey key = GlobalKey(debugLabel: producer.name);
                    String letter = producer.name[0].toUpperCase();
                    print(list[letter]);
                    if(list[letter] == null) {
                      list.addAll({letter: key});
                    }
                    return ProducerTile(key: key, producer: producer, callback: _back(producer));
                  }).toList(),
                ],

                if(state.status == FetchStatus.loading) const Center(
                  child: CupertinoActivityIndicator(),
                )
              ],
            );
          },
        )
      ],
    );
  }
}
