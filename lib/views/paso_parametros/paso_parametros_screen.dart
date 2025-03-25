import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Navegación con go_router

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController controller =
      TextEditingController(); // Caja de texto

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    ); // Crear controlador de pestañas
  }

  @override
  void dispose() {
    controller.dispose(); // Limpiar el recurso de texto
    _tabController.dispose(); // Cerrar el controlador de pestañas
    super.dispose();
  }

  // Función que permite la navegación según el método seleccionado
  void goToDetalle(String metodo, String valor) {
    if (valor.isEmpty) return;

    switch (metodo) {
      case 'go':
        context.go('/detalle/$valor/$metodo');
        break;
      case 'push':
        context.push('/detalle/$valor/$metodo');
        break;
      case 'replace':
        context.replace('/detalle/$valor/$metodo');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Nombres de algunos platos típicos colombianos
    List<String> nombres = [
      'Ajiaco',
      'Arepa con carne',
      'Picada',
      'Fritanga',
      'Carne de res',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        bottom: TabBar(
          controller: _tabController,
          labelColor:
              Colors.white, // Color del texto de la pestaña seleccionada
          unselectedLabelColor:
              Colors.grey, // Color del texto de las pestañas no seleccionadas
          indicatorColor:
              Colors.yellow, // Color del indicador de pestaña seleccionada
          tabs: const [Tab(text: 'GridView'), Tab(text: 'ListView')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Crear una cuadrícula con diferentes platos
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
            ),
            itemCount: nombres.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  goToDetalle('push', nombres[index]);
                },
                child: Container(
                  color: Colors.teal[(index % 9 + 1) * 100], // Color dinámico
                  child: Center(
                    child: Text(
                      nombres[index],
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
          // Lista con imágenes de platos típicos colombianos
          ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              List<String> images = [
                'https://media.gettyimages.com/id/1144436725/es/foto/persona-irreconocible-sosteniendo-un-delicioso-ajiaco-listo-para-servir-en-la-mesa.jpg?s=612x612&w=0&k=20&c=Pn6mSWUgjbdYak1Do43C2rGwB_6BxhGxkIifKfURsrk=',
                'https://media.gettyimages.com/id/1367505758/es/foto/arepa-con-carne-de-pollo-queso-y-aguacate-comida-tradicional-colombiana.jpg?s=612x612&w=0&k=20&c=YtsAGIgQ8pN2-xEu9_31L0LNLsKu6vqhJke1Dn0GW90=',
                'https://media.gettyimages.com/id/171589764/es/foto/picada-colombiano.jpg?s=612x612&w=0&k=20&c=y5X9JkaJ2V5C1FkkA_B019Qy3tXPtXRwLdJuExgZFHw=',
                'https://media.gettyimages.com/id/1194817447/es/foto/fritanga-typical-colombian-food.jpg?s=612x612&w=0&k=20&c=35lSdxlw741FW_IkGJHdQuuE3GOLTmPg1de-znS4k00=',
                'https://media.gettyimages.com/id/1200346341/es/foto/colombian-shredded-beef-with-gaira-cucayo-and-plantain.jpg?s=612x612&w=0&k=20&c=jDghz-H2nmIey_8qTaNNxaE0s528vcVBLsl8IeOSOEU=',
              ];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Image.network(
                    images[index % images.length],
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(nombres[index]),
                  subtitle: Text('Delicioso plato colombiano'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    goToDetalle('push', nombres[index]);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
