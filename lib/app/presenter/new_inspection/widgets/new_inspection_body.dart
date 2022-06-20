import 'package:fisplan_alupar/app/presenter/new_inspection/widgets/new_inspection_card.dart';
import 'package:fisplan_alupar/app/shared/widgets/textform_widget.dart';
import 'package:flutter/material.dart';

class NewInspectionBody extends StatelessWidget {
  const NewInspectionBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Você está criando uma nova inspeção para o projeto:'),
            const SizedBox(height: 10),
            const Text(
              'Project Name',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            NewInspectionCard(
              title: 'Filtros',
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const TextFormWidget(
                    labelText: 'Nome',
                    hintText: 'Nome da inspeção',
                  ),
                  const SizedBox(height: 20),
                  const TextFormWidget(
                    labelText: 'Descrição',
                    hintText: 'Informe a descrição da inspeção',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    color: Colors.black12,
                    thickness: 1,
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    title: const Text('Tipo de Instalação'),
                    trailing: const Icon(Icons.arrow_drop_down),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            NewInspectionCard(
              title: 'Foto',
              icon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.camera_alt),
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            NewInspectionCard(
              title: 'Áudios',
              icon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.mic_rounded),
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            NewInspectionCard(
              title: 'Localização',
              child: Column(children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text('Latitude'),
                    SizedBox(width: 10),
                    Text('-17.840286'),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Colors.black12,
                  thickness: 1,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text('Longitude'),
                    SizedBox(width: 10),
                    Text('-42.069027'),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Colors.black12,
                  thickness: 1,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text('Data/Hora'),
                    SizedBox(width: 10),
                    Text('20/06/2020 - 15:00'),
                  ],
                ),
              ]),
            ),
            NewInspectionCard(
              title: 'Comentarios',
              child: const Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFormWidget(
                  hintText: 'Informações adicionais',
                  maxLines: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
