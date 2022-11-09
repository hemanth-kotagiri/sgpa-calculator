import 'FetchResult.dart';

void main(List<String> args) async {
  ResultFetcher fetcher =
      ResultFetcher(hallticket: "185u1a0565", dob: "2001-04-03", year: "1,1");
  // ?hallticket=18N81A05L2&dob=3&degree=btech&examCode=1381&etype=r17
  print(await (fetcher.fetchSupplyResult(
    hallticket: "185u1a0588",
    dob: "3",
    degree: "btech",
    examCode: "1610",
    eType: "r17",
    type: "intgrade",
    result: "",
  )));

  print(await fetcher.fetchNotifications());
}
