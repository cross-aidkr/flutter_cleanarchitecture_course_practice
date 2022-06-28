import 'package:cleanarchitecture_course/core/network/network_info.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([DataConnectionChecker])
void main(){
  late NetworkInfoImpl networkInfoImpl;
  late MockDataConnectionChecker mockDataConnectionChecker;

  setUp((){
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('isConnected', () {
    test(
      'should forward the call to DataConnectionChecker.hasConnection',
        () async {
          // arrange
          when(mockDataConnectionChecker.hasConnection)
              .thenAnswer((_) async => true);
          // act
          final result = await networkInfoImpl.isConnected;
          // asset
          verify(mockDataConnectionChecker.hasConnection);
          expect(result, true);
        }
    );
  });
}
