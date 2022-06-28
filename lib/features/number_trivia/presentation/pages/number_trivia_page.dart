import 'package:cleanarchitecture_course/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:cleanarchitecture_course/features/number_trivia/presentation/bloc/number_trivia_state.dart';
import 'package:cleanarchitecture_course/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/widgets.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Number Trivia')),
      body: SingleChildScrollView(child: buildBody(context)),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return sl<NumberTriviaBloc>();
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ), // Top half
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return MessageDisplay(message: 'Start searching!');
                  } else if (state is Loading) {
                    return LoadingDisplay();
                  } else if (state is Loaded) {
                    return TriviaDisplay(numberTrivia: state.trivia);
                  } else if (state is Error) {
                    return MessageDisplay(
                      message: state.message,
                    );
                  } else {
                    return MessageDisplay(
                      message: 'start',
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              // Bottom half
              TriviaControlsState(),
            ],
          ),
        ),
      ),
    );
  }
}

