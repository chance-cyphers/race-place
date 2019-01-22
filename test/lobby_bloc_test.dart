import 'package:race_place/entrant.dart';
import 'package:race_place/bloc/lobby_bloc.dart';
import 'package:test/test.dart';

void main() {

  test("does some stuff", () async {
    var entrant = Entrant("bob", Links("tracks.com"));
    var lobbyBloc = LobbyBloc(entrant);

    var matchFound = lobbyBloc.matchFound.listen(expectAsync1((theBool) { // ignore: cancel_subscriptions
      print("the bool: " + theBool.toString());
    }, count: 3));

  });


}
