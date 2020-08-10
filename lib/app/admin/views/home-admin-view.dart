import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rocha_contabilidade/app/cliente/views/atendimento-view.dart';
import 'package:rocha_contabilidade/app/cliente/views/chamado-view.dart';
import 'package:rocha_contabilidade/app/shared/views/login-view.dart';
import 'package:rocha_contabilidade/app/utils/common.dart';
import 'package:rocha_contabilidade/app/widgets/text-widget.dart';

class HomeAdminView extends StatelessWidget {
  final PageController controller = PageController(
    initialPage: 0,
  );

  final GlobalKey<ScaffoldState> menuKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) {
        return Scaffold(
          key: menuKey,
          appBar: renderAppBar(sizingInfo),
          body: Container(
              child: Row(
            children: [
              sizingInfo.isMobile || sizingInfo.isTablet
                  ? renderNothing()
                  : renderMenu(),
              renderBody(sizingInfo)
            ],
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
      backgroundColor: Colors.white,
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
            TextWidget(text: 'Escurecer tela'),
            Switch(value: false, onChanged: null),
          ],
        )
      ],
    );
  }

  renderMenu() {
    return Container(
        width: Get.width / 6,
        height: Get.height,
        color: Colors.grey[300],
        child: renderMenuItens());
  }

  ListTile renderMenuItem(IconData icon, String title, String subtitle,
      String route, int pageIndex) {
    return ListTile(
      leading: Icon(icon),
      title: TextWidget(text: title),
      subtitle: TextWidget(text: subtitle),
      onTap: () => controller.jumpToPage(pageIndex),
    );
  }

  renderBody(SizingInformation sizingInfo) {
    return Expanded(
      child: Container(
        child: PageView(
          controller: controller,
          children: [AtendimentoView(), ChamadoView()],
        ),
      ),
    );
  }

  renderMenuItens() {
    return ListView(
      children: [
        ListTile(
          title: TextWidget(text: 'Olá, Gabriel!'),
          subtitle: TextWidget(text: 'Bem vindo a Rocha Contabilidade'),
          trailing: IconButton(
              icon: Icon(MdiIcons.logout),
              onPressed: () => Get.to(LoginView())),
        ),
        renderMenuItem(Icons.headset_mic, 'Atendimento online',
            'Tire suas dúvidas com nosso chat online', '/', 0),
        Divider(
          color: Colors.grey[400],
          thickness: 0.5,
        ),
        renderMenuItem(
            Icons.email,
            'Abrir chamado',
            'Solicite melhorias, sugestões e atendimentos personalizados',
            '/',
            1)
      ],
    );
  }
}
