import 'package:flutter/material.dart';
import 'package:sorts_app/screens/SplashScreen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'service/graphqlConf.dart';

// void main() => runApp(
//       GraphQLProvider(
//         client: graphQLConfiguration.client,
//         child: CacheProvider(child: SortsApp()),
//       ),
//     );
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

void main()  {

   WidgetsFlutterBinding.ensureInitialized();
  runApp(SortsApp(client: graphQLConfiguration.client));
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
