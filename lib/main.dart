import 'package:flutter/material.dart';
import 'package:sorts_app/screens/SplashScreen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  final HttpLink httpLink = HttpLink(
    uri: 'https://api.reportresults.gia.edu',
  );

  final AuthLink authLink = AuthLink(
    //getToken: () => '81323e54-3793-47ce-a2b6-cba1ba5d4fcb',
    getToken: () => '36965900-7504-4e64-ba0b-263f66e4fd64',
  );
  Link link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: link,
    ),
  );
  runApp(SortsApp(client: client));
}

class SortsApp extends StatelessWidget {

  final ValueNotifier<GraphQLClient> client;

  const SortsApp({Key key, this.client}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: MaterialApp(
          title: "Sorts",
          home: SplashScreen(),
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor:
                Color(0xFF000000), //setting the background colour
            accentColor: Color(0xff2EA3EA),
          ),
          debugShowMaterialGrid: false,
        )
      )
    );
  }
}
