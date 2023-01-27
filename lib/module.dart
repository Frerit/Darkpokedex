import 'package:darkpokedex/app/detail/detail_page.dart';
import 'package:darkpokedex/app/list/presenter/module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          "/",
          module: ListModule(),
        ),
        ChildRoute(
          "/details",
          child: (context, args) => DetailPageView(
            args: args.data,
          ),
        )
      ];
}
