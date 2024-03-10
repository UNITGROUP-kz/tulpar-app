import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/logic/bloc/user/cart/cart_counter_cubit.dart';
import 'package:garage/logic/bloc/user/cart/cart_cubit.dart';
import '../../../widgets/screen_templates/screen_default_template.dart';

@RoutePage(name: 'CartRouter')
class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      children: [
        BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if(state is CartSuccess) {
              return Column(
                children: state.carts.map((element) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            height: MediaQuery.of(context).size.width * 0.15,
                            child: CachedNetworkImage(
                              imageUrl: element.part.image ?? '',
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: (context, value) => Image.network(
                                'https://www.pulsecarshalton.co.uk/wp-content/uploads/2016/08/jk-placeholder-image.jpg',
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, value, err) => Image.network(
                                'https://www.pulsecarshalton.co.uk/wp-content/uploads/2016/08/jk-placeholder-image.jpg',
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: Text(element.part.name)
                        ),
                        Expanded(
                          child: BlocBuilder<CartCounterCubit, CartCounterState>(
                            builder: (context, state) {
                              if(state is CartCounterSuccess) {
                                final counter = state.counter.firstWhereOrNull((counter) => counter.partId == element.part.id);
                                if(counter == null) return Offstage();
                                return Row(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            context.read<CartCounterCubit>().minus(counter);
                                          },
                                          child: Icon(Icons.remove, size: 25),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        child: Text((counter.count ?? 0).toString(),
                                          style: TextStyle(fontSize: 18),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            context.read<CartCounterCubit>().plus(counter);
                                          },
                                          child: Icon(Icons.add, size: 25,),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              } return Container();

                            },
                          ),
                        )

                      ],
                    ),
                  );
                }).toList()
              );
            }
            return Center(heightFactor: 25, child: CupertinoActivityIndicator());
          },
        )

      ],
    );
  }

}