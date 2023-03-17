import 'package:pokedex/src/pages/generations_grid_page.dart';
import 'package:pokedex/src/pages/pkmn_list_page.dart';

import '../pages/pkmn_detail_page.dart';

class AppRoutes {
  static const home = '/';
  static const pkmnList = '/pkmn-list';
  static const pkmnDetail = '/pkmn-detail';

  static final routes = {
    home: (context) => const GenerationsGridPage(),
    pkmnList: (context) => const PkmnListPage(),
    pkmnDetail: (context) => const PkmnDetailPage(),
  };
}
