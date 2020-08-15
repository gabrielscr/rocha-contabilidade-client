import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rocha_contabilidade/app/cliente/views/chamado-listar-view.dart';
import 'package:rocha_contabilidade/app/cliente/views/chamado-view.dart';
import 'package:rocha_contabilidade/app/shared/controllers/auth-controller.dart';
import 'package:rocha_contabilidade/app/shared/controllers/theme-controller.dart';
import 'package:rocha_contabilidade/app/utils/common.dart';
import 'package:rocha_contabilidade/app/utils/routes.dart';
import 'package:rocha_contabilidade/app/widgets/text-widget.dart';

class HomeAdminView extends StatelessWidget {
  final PageController controller = PageController(
    initialPage: 0,
  );

  final GlobalKey<ScaffoldState> menuKey = new GlobalKey<ScaffoldState>();

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) {
        return Scaffold(
          key: menuKey,
          appBar: renderAppBar(sizingInfo),
          body: Container(
              child: Row(
            children: [sizingInfo.isMobile || sizingInfo.isTablet ? renderNothing() : renderMenu(), renderBody(sizingInfo)],
          )),
          drawer: Drawer(
            child: renderMenuItens(),
          ),
        );
      },
    );
  }

  renderAppBar(SizingInformation sizingInfo) {
    return AppBar(
      title: TextWidget(text: 'Rocha Contabilidade'),
      elevation: 0,
      backgroundColor: isModoDark ? Colors.black : Colors.white,
      leading: sizingInfo.isMobile || sizingInfo.isTablet
          ? IconButton(
              icon: Icon(
                Icons.short_text,
                color: Colors.black,
              ),
              onPressed: () => menuKey.currentState.openDrawer())
          : renderNothing(),
      actions: [
        Row(
          children: [
            IconButton(
                icon: Icon(MdiIcons.moonLastQuarter),
                onPressed: () {
                  ThemeController.to.modoDark.value = !ThemeController.to.modoDark.value;

                  if (ThemeController.to.modoDark.value) {
                    ThemeController.to.changeTheme(ThemeMode.dark);
                  } else {
                    ThemeController.to.changeTheme(ThemeMode.light);
                  }
                }),
          ],
        )
      ],
    );
  }

  renderMenu() {
    return Container(width: Get.width / 6, height: Get.height, color: isModoDark ? Colors.grey[800] : Colors.grey[300], child: renderMenuItens());
  }

  ListTile renderMenuItem(IconData icon, String title, String subtitle, Function onTap) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Icon(
          icon,
          color: isModoDark ? Colors.white : Colors.black,
        ),
      ),
      title: TextWidget(text: title),
      subtitle: TextWidget(text: subtitle),
      onTap: onTap,
    );
  }

  renderBody(SizingInformation sizingInfo) {
    return Expanded(
      child: Container(
        child: PageView(
          controller: controller,
          children: [ChamadoListarView(), ChamadoView()],
        ),
      ),
    );
  }

  renderMenuItens() {
    return ListView(
      children: [
        ListTile(
          title: TextWidget(text: 'Olá, ${authController.usuario.value.nome}.'),
          subtitle: TextWidget(text: 'Seja bem vindo!'),
          trailing: IconButton(icon: Icon(MdiIcons.logout), onPressed: () => AuthController.to.logoff()),
        ),
        renderMenuItem(Icons.headset_mic, 'Meus atendimentos', 'Consulte seus chamados', () => controller.jumpToPage(0)),
        Divider(
          color: Colors.grey[400],
          thickness: 0.5,
        ),
        renderMenuItem(Icons.email, 'Abrir chamado', 'Toque aqui para abrir', () => goTo('chamado-abrir'))
      ],
    );
  }
}
