import 'FetchResult.dart';

void main(List<String> args) async {
  ResultFetcher fetcher =
      ResultFetcher(hallticket: "185u1a0565", dob: "2001-04-03", year: "1,1");

  List result = await fetcher.fetchResult();
  print(result);
}
