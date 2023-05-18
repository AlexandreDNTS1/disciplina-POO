// Generated by DDC, the Dart Development Compiler (to JavaScript).
// Version: 2.19.2 (stable) (Tue Feb 7 18:37:17 2023 +0000) on "linux_x64"
// Module: zapp_user_main
// Flags: soundNullSafety(true), enableAsserts(true)
define('zapp_user_main', ['dart_sdk', 'flutter_sdk'], (function load__zapp_user_main(dart_sdk, flutter_sdk) {
  'use strict';
  const core = dart_sdk.core;
  const async = dart_sdk.async;
  const _interceptors = dart_sdk._interceptors;
  const js = dart_sdk.js;
  const ui = dart_sdk.ui;
  const dart = dart_sdk.dart;
  const dartx = dart_sdk.dartx;
  const bottom_navigation_bar_item = flutter_sdk.src__widgets__bottom_navigation_bar_item;
  const icon$ = flutter_sdk.src__widgets__icon;
  const icon_data = flutter_sdk.src__widgets__icon_data;
  const bottom_navigation_bar = flutter_sdk.src__material__bottom_navigation_bar;
  const framework = flutter_sdk.src__widgets__framework;
  const basic = flutter_sdk.src__widgets__basic;
  const text = flutter_sdk.src__widgets__text;
  const app_bar = flutter_sdk.src__material__app_bar;
  const colors = flutter_sdk.src__material__colors;
  const popup_menu = flutter_sdk.src__material__popup_menu;
  const text_style = flutter_sdk.src__painting__text_style;
  const icons = flutter_sdk.src__material__icons;
  const app = flutter_sdk.src__material__app;
  const theme_data = flutter_sdk.src__material__theme_data;
  const scaffold = flutter_sdk.src__material__scaffold;
  const binding = flutter_sdk.src__widgets__binding;
  var $46zapp_entry = Object.create(dart.library);
  var main = Object.create(dart.library);
  var web_plugin_registrant = Object.create(dart.library);
  var $toString = dartx.toString;
  var $indexOf = dartx.indexOf;
  var $_get = dartx._get;
  var $map = dartx.map;
  var $toList = dartx.toList;
  dart._checkModuleNullSafetyMode(true);
  dart._checkModuleRuntimeTypes(false);
  var T = {
    VoidTovoid: () => (T.VoidTovoid = dart.constFn(dart.fnType(dart.void, [])))(),
    ListOfString: () => (T.ListOfString = dart.constFn(core.List$(core.String)))(),
    ListOfStringTodynamic: () => (T.ListOfStringTodynamic = dart.constFn(dart.fnType(dart.dynamic, [T.ListOfString()])))(),
    JSArrayOfString: () => (T.JSArrayOfString = dart.constFn(_interceptors.JSArray$(core.String)))(),
    dynamicToNull: () => (T.dynamicToNull = dart.constFn(dart.fnType(core.Null, [dart.dynamic])))(),
    VoidToNull: () => (T.VoidToNull = dart.constFn(dart.fnType(core.Null, [])))(),
    ObjectAndStackTraceTovoid: () => (T.ObjectAndStackTraceTovoid = dart.constFn(dart.fnType(dart.void, [core.Object, core.StackTrace])))(),
    ZoneAndZoneDelegateAndZone__Tovoid: () => (T.ZoneAndZoneDelegateAndZone__Tovoid = dart.constFn(dart.fnType(dart.void, [async.Zone, async.ZoneDelegate, async.Zone, core.String])))(),
    IconDataToBottomNavigationBarItem: () => (T.IconDataToBottomNavigationBarItem = dart.constFn(dart.fnType(bottom_navigation_bar_item.BottomNavigationBarItem, [icon_data.IconData])))(),
    StringToExpanded: () => (T.StringToExpanded = dart.constFn(dart.fnType(basic.Expanded, [core.String])))(),
    JSArrayOfWidget: () => (T.JSArrayOfWidget = dart.constFn(_interceptors.JSArray$(framework.Widget)))(),
    PopupMenuButtonOfColor: () => (T.PopupMenuButtonOfColor = dart.constFn(popup_menu.PopupMenuButton$(ui.Color)))(),
    PopupMenuItemOfColor: () => (T.PopupMenuItemOfColor = dart.constFn(popup_menu.PopupMenuItem$(ui.Color)))(),
    PopupMenuEntryOfColor: () => (T.PopupMenuEntryOfColor = dart.constFn(popup_menu.PopupMenuEntry$(ui.Color)))(),
    JSArrayOfPopupMenuEntryOfColor: () => (T.JSArrayOfPopupMenuEntryOfColor = dart.constFn(_interceptors.JSArray$(T.PopupMenuEntryOfColor())))(),
    ListOfPopupMenuEntryOfColor: () => (T.ListOfPopupMenuEntryOfColor = dart.constFn(core.List$(T.PopupMenuEntryOfColor())))(),
    BuildContextToListOfPopupMenuEntryOfColor: () => (T.BuildContextToListOfPopupMenuEntryOfColor = dart.constFn(dart.fnType(T.ListOfPopupMenuEntryOfColor(), [framework.BuildContext])))(),
    ColorTovoid: () => (T.ColorTovoid = dart.constFn(dart.fnType(dart.void, [ui.Color])))(),
    intTovoid: () => (T.intTovoid = dart.constFn(dart.fnType(dart.void, [core.int])))()
  };
  const CT = Object.create({
    _: () => (C, CT)
  });
  dart.defineLazy(CT, {
    get C0() {
      return C[0] = dart.fn(main.main, T.VoidTovoid());
    },
    get C1() {
      return C[1] = dart.constList([], core.String);
    },
    get C2() {
      return C[2] = dart.const({
        __proto__: text.Text.prototype,
        [Widget_key]: null,
        [Text_selectionColor]: null,
        [Text_textHeightBehavior]: null,
        [Text_textWidthBasis]: null,
        [Text_semanticsLabel]: null,
        [Text_maxLines]: null,
        [Text_textScaleFactor]: null,
        [Text_overflow]: null,
        [Text_softWrap]: null,
        [Text_locale]: null,
        [Text_textDirection]: null,
        [Text_textAlign]: null,
        [Text_strutStyle]: null,
        [Text_style]: null,
        [Text_textSpan]: null,
        [Text_data]: "Dicas"
      });
    },
    get C4() {
      return C[4] = dart.const({
        __proto__: icon_data.IconData.prototype,
        [IconData_matchTextDirection]: false,
        [IconData_fontPackage]: null,
        [IconData_fontFamily]: "MaterialIcons",
        [IconData_codePoint]: 61288
      });
    },
    get C5() {
      return C[5] = dart.const({
        __proto__: icon_data.IconData.prototype,
        [IconData_matchTextDirection]: false,
        [IconData_fontPackage]: null,
        [IconData_fontFamily]: "MaterialIcons",
        [IconData_codePoint]: 61817
      });
    },
    get C6() {
      return C[6] = dart.const({
        __proto__: icon_data.IconData.prototype,
        [IconData_matchTextDirection]: false,
        [IconData_fontPackage]: null,
        [IconData_fontFamily]: "MaterialIcons",
        [IconData_codePoint]: 61563
      });
    },
    get C3() {
      return C[3] = dart.constList([C[4] || CT.C4, C[5] || CT.C5, C[6] || CT.C6], icon_data.IconData);
    },
    get C7() {
      return C[7] = dart.constList(["Cafés", "Cervejas", "Nações"], core.String);
    },
    get C8() {
      return C[8] = dart.const({
        __proto__: main.MyApp.prototype,
        [Widget_key]: null
      });
    }
  }, false);
  var C = Array(9).fill(void 0);
  var I = ["file:///zapp/project/lib/main.dart"];
  $46zapp_entry.runAppGuarded = function runAppGuarded() {
    async.runZonedGuarded(core.Null, dart.fn(() => {
      if (T.ListOfStringTodynamic().is(C[0] || CT.C0)) {
        T.ListOfStringTodynamic().as(C[0] || CT.C0)(T.JSArrayOfString().of([]));
      } else {
        (C[0] || CT.C0)();
      }
      if (js.context.hasProperty("__notifyFlutterRendered")) {
        async.Future.delayed(new core.Duration.new({milliseconds: 250})).then(core.Null, dart.fn(_ => {
          js.context.callMethod("__notifyFlutterRendered", [false]);
        }, T.dynamicToNull()));
      }
    }, T.VoidToNull()), dart.fn((e, stackTrace) => {
      if (js.context.hasProperty("zappHandlerUserError")) {
        js.context.callMethod("zappHandlerUserError", [e[$toString](), stackTrace.toString()]);
      }
    }, T.ObjectAndStackTraceTovoid()), {zoneSpecification: new async._ZoneSpecification.new({print: dart.fn((self, parent, zone, line) => {
          if (js.context.hasProperty("zappHandlerUserPrint")) {
            js.context.callMethod("zappHandlerUserPrint", [line]);
          }
        }, T.ZoneAndZoneDelegateAndZone__Tovoid())})});
  };
  $46zapp_entry.main = function main$() {
    return async.async(dart.void, function* main() {
      yield ui.webOnlyWarmupEngine({runApp: dart.fn(() => {
          $46zapp_entry.runAppGuarded();
        }, T.VoidToNull()), registerPlugins: dart.fn(() => {
          web_plugin_registrant.registerPlugins();
        }, T.VoidToNull())});
    });
  };
  var icons$ = dart.privateName(main, "NewNavBar.icons");
  var onButtonPressed$ = dart.privateName(main, "NewNavBar.onButtonPressed");
  var rotulos$ = dart.privateName(main, "NewNavBar.rotulos");
  main.NewNavBar = class NewNavBar extends framework.StatelessWidget {
    get icons() {
      return this[icons$];
    }
    set icons(value) {
      super.icons = value;
    }
    get onButtonPressed() {
      return this[onButtonPressed$];
    }
    set onButtonPressed(value) {
      super.onButtonPressed = value;
    }
    get rotulos() {
      return this[rotulos$];
    }
    set rotulos(value) {
      super.rotulos = value;
    }
    static ['_#new#tearOff'](opts) {
      let icons = opts && 'icons' in opts ? opts.icons : null;
      let onButtonPressed = opts && 'onButtonPressed' in opts ? opts.onButtonPressed : null;
      let rotulos = opts && 'rotulos' in opts ? opts.rotulos : null;
      return new main.NewNavBar.new({icons: icons, onButtonPressed: onButtonPressed, rotulos: rotulos});
    }
    construirNavBar() {
      return this.icons[$map](bottom_navigation_bar_item.BottomNavigationBarItem, dart.fn(icon => new bottom_navigation_bar_item.BottomNavigationBarItem.new({icon: new icon$.Icon.new(icon), label: this.rotulos[$_get](this.icons[$indexOf](icon))}), T.IconDataToBottomNavigationBarItem()))[$toList]();
    }
    build(context) {
      return new bottom_navigation_bar.BottomNavigationBar.new({onTap: this.onButtonPressed, items: this.construirNavBar()});
    }
  };
  (main.NewNavBar.new = function(opts) {
    let icons = opts && 'icons' in opts ? opts.icons : null;
    let onButtonPressed = opts && 'onButtonPressed' in opts ? opts.onButtonPressed : null;
    let rotulos = opts && 'rotulos' in opts ? opts.rotulos : null;
    this[icons$] = icons;
    this[onButtonPressed$] = onButtonPressed;
    this[rotulos$] = rotulos;
    main.NewNavBar.__proto__.new.call(this);
    ;
  }).prototype = main.NewNavBar.prototype;
  dart.addTypeTests(main.NewNavBar);
  dart.addTypeCaches(main.NewNavBar);
  dart.setMethodSignature(main.NewNavBar, () => ({
    __proto__: dart.getMethods(main.NewNavBar.__proto__),
    construirNavBar: dart.fnType(core.List$(bottom_navigation_bar_item.BottomNavigationBarItem), []),
    build: dart.fnType(framework.Widget, [framework.BuildContext])
  }));
  dart.setLibraryUri(main.NewNavBar, I[0]);
  dart.setFieldSignature(main.NewNavBar, () => ({
    __proto__: dart.getFields(main.NewNavBar.__proto__),
    icons: dart.finalFieldType(core.List$(icon_data.IconData)),
    onButtonPressed: dart.finalFieldType(dart.fnType(dart.void, [core.int])),
    rotulos: dart.finalFieldType(core.List$(core.String))
  }));
  var objects$ = dart.privateName(main, "NewBode.objects");
  main.NewBode = class NewBode extends framework.StatelessWidget {
    get objects() {
      return this[objects$];
    }
    set objects(value) {
      this[objects$] = value;
    }
    static ['_#new#tearOff'](opts) {
      let objects = opts && 'objects' in opts ? opts.objects : C[1] || CT.C1;
      return new main.NewBode.new({objects: objects});
    }
    processarUmElemento(obj) {
      return new basic.Expanded.new({child: new basic.Center.new({child: new text.Text.new(obj)})});
    }
    build(context) {
      return new basic.Column.new({children: this.objects[$map](basic.Expanded, dart.fn(obj => new basic.Expanded.new({child: new basic.Center.new({child: new text.Text.new(obj)})}), T.StringToExpanded()))[$toList]()});
    }
  };
  (main.NewBode.new = function(opts) {
    let objects = opts && 'objects' in opts ? opts.objects : C[1] || CT.C1;
    this[objects$] = objects;
    main.NewBode.__proto__.new.call(this);
    ;
  }).prototype = main.NewBode.prototype;
  dart.addTypeTests(main.NewBode);
  dart.addTypeCaches(main.NewBode);
  dart.setMethodSignature(main.NewBode, () => ({
    __proto__: dart.getMethods(main.NewBode.__proto__),
    processarUmElemento: dart.fnType(basic.Expanded, [core.String]),
    build: dart.fnType(framework.Widget, [framework.BuildContext])
  }));
  dart.setLibraryUri(main.NewBode, I[0]);
  dart.setFieldSignature(main.NewBode, () => ({
    __proto__: dart.getFields(main.NewBode.__proto__),
    objects: dart.fieldType(core.List$(core.String))
  }));
  var Widget_key = dart.privateName(framework, "Widget.key");
  var Text_selectionColor = dart.privateName(text, "Text.selectionColor");
  var Text_textHeightBehavior = dart.privateName(text, "Text.textHeightBehavior");
  var Text_textWidthBasis = dart.privateName(text, "Text.textWidthBasis");
  var Text_semanticsLabel = dart.privateName(text, "Text.semanticsLabel");
  var Text_maxLines = dart.privateName(text, "Text.maxLines");
  var Text_textScaleFactor = dart.privateName(text, "Text.textScaleFactor");
  var Text_overflow = dart.privateName(text, "Text.overflow");
  var Text_softWrap = dart.privateName(text, "Text.softWrap");
  var Text_locale = dart.privateName(text, "Text.locale");
  var Text_textDirection = dart.privateName(text, "Text.textDirection");
  var Text_textAlign = dart.privateName(text, "Text.textAlign");
  var Text_strutStyle = dart.privateName(text, "Text.strutStyle");
  var Text_style = dart.privateName(text, "Text.style");
  var Text_textSpan = dart.privateName(text, "Text.textSpan");
  var Text_data = dart.privateName(text, "Text.data");
  main.NewAppBar = class NewAppBar extends app_bar.AppBar {
    static ['_#new#tearOff'](opts) {
      let key = opts && 'key' in opts ? opts.key : null;
      return new main.NewAppBar.new({key: key});
    }
  };
  (main.NewAppBar.new = function(opts) {
    let key = opts && 'key' in opts ? opts.key : null;
    main.NewAppBar.__proto__.new.call(this, {title: C[2] || CT.C2, actions: T.JSArrayOfWidget().of([new main.ColorMenuButton.new()]), key: key});
    ;
  }).prototype = main.NewAppBar.prototype;
  dart.addTypeTests(main.NewAppBar);
  dart.addTypeCaches(main.NewAppBar);
  dart.setLibraryUri(main.NewAppBar, I[0]);
  main.ColorMenuButton = class ColorMenuButton extends framework.StatefulWidget {
    static ['_#new#tearOff'](opts) {
      let key = opts && 'key' in opts ? opts.key : null;
      return new main.ColorMenuButton.new({key: key});
    }
    createState() {
      return new main._ColorMenuButtonState.new();
    }
  };
  (main.ColorMenuButton.new = function(opts) {
    let key = opts && 'key' in opts ? opts.key : null;
    main.ColorMenuButton.__proto__.new.call(this, {key: key});
    ;
  }).prototype = main.ColorMenuButton.prototype;
  dart.addTypeTests(main.ColorMenuButton);
  dart.addTypeCaches(main.ColorMenuButton);
  dart.setMethodSignature(main.ColorMenuButton, () => ({
    __proto__: dart.getMethods(main.ColorMenuButton.__proto__),
    createState: dart.fnType(main._ColorMenuButtonState, [])
  }));
  dart.setLibraryUri(main.ColorMenuButton, I[0]);
  var _selectedColor = dart.privateName(main, "_selectedColor");
  main._ColorMenuButtonState = class _ColorMenuButtonState extends framework.State$(main.ColorMenuButton) {
    build(context) {
      return new (T.PopupMenuButtonOfColor()).new({itemBuilder: dart.fn(context => T.JSArrayOfPopupMenuEntryOfColor().of([new (T.PopupMenuItemOfColor()).new({value: colors.Colors.red, child: new text.Text.new("Vermelho", {style: new text_style.TextStyle.new({color: colors.Colors.red, fontWeight: ui.FontWeight.bold, fontSize: 20})})}), new (T.PopupMenuItemOfColor()).new({value: colors.Colors.blue, child: new text.Text.new("Azul", {style: new text_style.TextStyle.new({color: colors.Colors.blue, fontWeight: ui.FontWeight.bold, fontSize: 20})})}), new (T.PopupMenuItemOfColor()).new({value: colors.Colors.green, child: new text.Text.new("Verde", {style: new text_style.TextStyle.new({color: colors.Colors.green, fontWeight: ui.FontWeight.bold, fontSize: 20})})})]), T.BuildContextToListOfPopupMenuEntryOfColor()), onSelected: dart.fn(cor => {
          this.setState(dart.fn(() => {
            this[_selectedColor] = cor;
          }, T.VoidTovoid()));
          core.print("Cor selecionada: " + dart.str(cor));
        }, T.ColorTovoid()), icon: new icon$.Icon.new(icons.Icons.color_lens, {color: this[_selectedColor]})});
    }
    static ['_#new#tearOff']() {
      return new main._ColorMenuButtonState.new();
    }
  };
  (main._ColorMenuButtonState.new = function() {
    this[_selectedColor] = colors.Colors.red;
    main._ColorMenuButtonState.__proto__.new.call(this);
    ;
  }).prototype = main._ColorMenuButtonState.prototype;
  dart.addTypeTests(main._ColorMenuButtonState);
  dart.addTypeCaches(main._ColorMenuButtonState);
  dart.setMethodSignature(main._ColorMenuButtonState, () => ({
    __proto__: dart.getMethods(main._ColorMenuButtonState.__proto__),
    build: dart.fnType(framework.Widget, [framework.BuildContext])
  }));
  dart.setLibraryUri(main._ColorMenuButtonState, I[0]);
  dart.setFieldSignature(main._ColorMenuButtonState, () => ({
    __proto__: dart.getFields(main._ColorMenuButtonState.__proto__),
    [_selectedColor]: dart.fieldType(ui.Color)
  }));
  var IconData_matchTextDirection = dart.privateName(icon_data, "IconData.matchTextDirection");
  var IconData_fontPackage = dart.privateName(icon_data, "IconData.fontPackage");
  var IconData_fontFamily = dart.privateName(icon_data, "IconData.fontFamily");
  var IconData_codePoint = dart.privateName(icon_data, "IconData.codePoint");
  main.MyApp = class MyApp extends framework.StatelessWidget {
    static ['_#new#tearOff'](opts) {
      let key = opts && 'key' in opts ? opts.key : null;
      return new main.MyApp.new({key: key});
    }
    build(context) {
      return new app.MaterialApp.new({theme: theme_data.ThemeData.new({primarySwatch: colors.Colors.deepPurple}), debugShowCheckedModeBanner: false, home: new scaffold.Scaffold.new({appBar: new main.NewAppBar.new(), body: new main.NewBode.new({objects: T.JSArrayOfString().of(["La Fin Du Monde - Bock - 65 ibu", "Sapporo Premiume - Sour Ale - 54 ibu", "Duvel - Pilsner - 82 ibu"])}), bottomNavigationBar: new main.NewNavBar.new({icons: C[3] || CT.C3, onButtonPressed: dart.fn(index => core.print("Tocaram no botão " + dart.str(index)), T.intTovoid()), rotulos: C[7] || CT.C7})})});
    }
  };
  (main.MyApp.new = function(opts) {
    let key = opts && 'key' in opts ? opts.key : null;
    main.MyApp.__proto__.new.call(this, {key: key});
    ;
  }).prototype = main.MyApp.prototype;
  dart.addTypeTests(main.MyApp);
  dart.addTypeCaches(main.MyApp);
  dart.setMethodSignature(main.MyApp, () => ({
    __proto__: dart.getMethods(main.MyApp.__proto__),
    build: dart.fnType(framework.Widget, [framework.BuildContext])
  }));
  dart.setLibraryUri(main.MyApp, I[0]);
  main.main = function main$0() {
    let app = C[8] || CT.C8;
    binding.runApp(app);
  };
  web_plugin_registrant.registerPlugins = function registerPlugins() {
  };
  dart.trackLibraries("zapp_user_main", {
    "file:///zapp/project/.zapp_entry.dart": $46zapp_entry,
    "file:///zapp/project/lib/main.dart": main,
    "file:///zapp/project/.dart_tool/dartpad/web_plugin_registrant.dart": web_plugin_registrant
  }, {
  }, '{"version":3,"sourceRoot":"","sources":["/zapp/project/.zapp_entry.dart","/zapp/project/lib/main.dart","/zapp/project/.dart_tool/dartpad/web_plugin_registrant.dart"],"names":[],"mappings":";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;AA2CI,IA1BF,iCAAgB;AACd,UAAoB,6BAGD;AAF8B,QAA9B,AAAkB,6BAElB,eAF2B;;AAEL,QAAF,CAApB;;AAEnB,UAAO,AAAQ,uBAAY;AAKvB,QAJK,AAAqC,qBAA7B,qCAAuB,uBAAW,QAAC;AAG9C,UAFC,AAAQ,sBAAW,2BAA2B,CAC/C;;;wBAIL,SAAC,GAAG;AACL,UAAO,AAAQ,uBAAY;AAIvB,QAHC,AAAQ,sBAAW,wBAAwB,CAC5C,AAAE,CAAD,eACD,AAAW,UAAD;;2DAGM,yCACb,SAAC,MAAM,QAAQ,MAAM;AAC1B,cAAO,AAAQ,uBAAY;AAC4B,YAAlD,AAAQ,sBAAW,wBAAwB,CAAC,IAAI;;;EAI3D;;AAEiB;AAQd,MAPD,MAAS,gCACC;AACS,UAAf;6CAEe;AACmB,UAAjB;;IAGvB;;;;;;ICpDuB;;;;;;IACI;;;;;;IACN;;;;;;;;;;;;;AAQjB,YAAO,AACF,AAIA,sEAJI,QAAC,QAAS,kEACH,mBAAK,IAAI,UACR,AAAO,oBAAC,AAAM,qBAAQ,IAAI;IAG7C;UAG0B;AACxB,YAAO,2DACE,6BACA;IAEX;;;QAnBmB;QACD;QACA;IAFC;IACD;IACA;AAHlB;;EAG2B;;;;;;;;;;;;;;;;;IAqBd;;;;;;;;;;wBAGuB;AAClC,YAAO,gCACE,6BAAc,kBAAK,GAAG;IAEjC;UAG0B;AACxB,YAAO,iCACO,AACL,AAGA,mCAHI,QAAC,OAAQ,+BACD,6BAAc,kBAAK,GAAG;IAG7C;;;QAhBc;;AAAd;;EAAkC;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;QAoBjB;AACX,4EAEW,wBACP,uCAJO,GAAG;;EAMb;;;;;;;;;;AAOgC;IAAuB;;;QAHlC;AAAQ,wDAAW,GAAG;;EAAC;;;;;;;;;;UAUzB;AACxB,YAAO,oDACQ,QAAc,WAAmC,uCAC5D,2CACgB,0BACP,kBACL,oBACO,qCACS,+BACS,8BACb,UAIhB,2CACgB,2BACP,kBACL,gBACO,qCACS,gCACS,8BACb,UAIhB,2CACgB,4BACP,kBACL,iBACO,qCACS,iCACS,8BACb,wEAKN,QAAO;AAGf,UAFF,cAAS;AACa,YAApB,uBAAiB,GAAG;;AAGQ,UAA9B,WAAM,AAAuB,+BAAJ,GAAG;mCAExB,mBAAW,gCAAmB;IAExC;;;;;;IAjDM,uBAAwB;;;EAkDhC;;;;;;;;;;;;;;;;;;;;;UAM4B;AACxB,YAAO,iCACE,yCAAgC,wDACX,aACtB,mCACI,gCACF,+BAAiB,wBACrB,mCACA,wCACA,qDAEmB,+DAMF,QAAC,SAAU,WAAM,AAAyB,+BAAN,KAAK;IAKlE;;;QAzBmB;AAAb,8CAAa,GAAG;;EAAE;;;;;;;;;AA6BlB;AACK,IAAX,eAAO,GAAG;EACZ;;EClJwB","file":"main.js"}');
  // Exports:
  return {
    zapp__project__$46zapp_entry: $46zapp_entry,
    zapp__project__lib__main: main,
    zapp__project__$46dart_tool__dartpad__web_plugin_registrant: web_plugin_registrant
  };
}));

//# sourceMappingURL=main.js.map
