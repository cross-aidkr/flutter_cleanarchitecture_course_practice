import 'package:cleanarchitecture_course/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:cleanarchitecture_course/features/number_trivia/presentation/bloc/number_trivia_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TriviaControlsState extends StatefulWidget {
  const TriviaControlsState({Key? key}) : super(key: key);

  @override
  State<TriviaControlsState> createState() => _TriviaControlsStateState();
}

class _TriviaControlsStateState extends State<TriviaControlsState> {
  final controller = TextEditingController();
  late String inputStr;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          // TextField
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Input a number',
            ),
            onChanged: (value){
              inputStr = value;
            },
            onSubmitted: (_){
              dispatchConcrete();
            },
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: RaisedButton(
                  child: Text('Search'),
                  color: Theme.of(context).accentColor,
                  textTheme: ButtonTextTheme.primary,
                  onPressed: dispatchConcrete,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: RaisedButton(
                  child: Text('Get random trivia'),
                  onPressed: dispatchRandom,
                ),
              ),
            ],
          )
        ]);
  }

  void dispatchConcrete(){
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetTriviaForConcreteNumber(inputStr));
  }

  void dispatchRandom(){
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetTriviaForRandomNumber());
  }
}
