import 'dart:convert';

import 'package:clean_tdd_numbers/core/error/exception.dart';
import 'package:clean_tdd_numbers/data/number_trivia/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;


abstract class NumberTriviaRemoteDataSource {

  Future<NumberTriviaModel> getConcreteNumberTrivia(double number);
  Future<NumberTriviaModel> getRandomNumberTrivia();

}


typedef _funToGetRespose = Future<http.Response> Function();

extension IsOk on http.Response {
  bool get ok {
    return (statusCode ~/ 100) == 2;
  }
}


class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {

  http.Client client;
  NumberTriviaRemoteDataSourceImpl({required this.client});



  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(double number) async {
    return _getResponse(() {
      
        final String numberRequest = number.toStringAsFixed(0);

        final request = 'http://numbersapi.com/$numberRequest';
        print (request);

        return client.get(
            Uri.parse(request),
            headers: {'Content-Type': 'application/json'}); },
    );
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {

    return _getResponse(() {

        final request = 'http://numbersapi.com/random';
        print (request);

        return client.get(
            Uri.parse(request),
            headers: {'Content-Type': 'application/json'});}
    );
  }


  Future<NumberTriviaModel> _getResponse(_funToGetRespose fun) async {

    try {
      var response = await fun();

      if (!response.ok) {
        throw ServerException(reason: response.statusCode.toString());
      }

      return NumberTriviaModel.fromJson(json.decode(response.body));


    } catch (e) {
      throw ServerException(reason: e.toString());
    }

  }


}