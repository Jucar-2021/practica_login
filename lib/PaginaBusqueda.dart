import 'dart:convert';
import 'PaginaDetalles.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Paginabusqueda extends StatefulWidget {
  const Paginabusqueda({super.key});

  @override
  State<Paginabusqueda> createState() => _PaginabusquedaState();
}

class _PaginabusquedaState extends State<Paginabusqueda> {
  List<Map<String, String>> librosEncontrados = [];
  final TextEditingController ctrlBuscar = TextEditingController();
  final DatabaseReference db = FirebaseDatabase.instance.ref().child("libro");

  @override
  void initState() {
    super.initState();
    ctrlBuscar.addListener(buscarLibro); // Escucha cambios en el campo
  }

  @override
  void dispose() {
    ctrlBuscar.removeListener(buscarLibro);
    ctrlBuscar.dispose();
    super.dispose();
  }

  Future<void> buscarLibro() async {
    String tituloABuscar = ctrlBuscar.text.toLowerCase().trim();

    if (tituloABuscar.isEmpty) {
      setState(() {
        librosEncontrados = [];
      });
      return;
    }

    DatabaseEvent event = await db.once();
    DataSnapshot resultadosDB = event.snapshot;

    List<Map<String, String>> resultados = [];

    for (var libro in resultadosDB.children) {
      String titulo = libro.child("titulo").value.toString().toLowerCase();
      if (titulo.contains(tituloABuscar)) {
        resultados.add({
          "titulo": libro.child("titulo").value.toString(),
          "imagen": libro.child("imagen").value?.toString() ?? "",
          "autor": libro.child("autor").value.toString(),
          "editorial": libro.child("editorial").value.toString(),
          "paginas": libro.child("paginas").value.toString(),
          "genero": libro.child("genero").value.toString(),
        });
      }
    }

    setState(() {
      librosEncontrados = resultados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buscar Libro"),
        centerTitle: true,
        backgroundColor: Colors.amber.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: ctrlBuscar,
              decoration: InputDecoration(
                labelText: "Buscar Libro",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) {
                buscarLibro();
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: librosEncontrados.isEmpty
                  ? const Center(child: Text("No se encontraron resultados"))
                  : ListView.builder(
                itemCount: librosEncontrados.length,
                itemBuilder: (context, index) {
                  final libro = librosEncontrados[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Paginadetalles(libro: libro),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 200,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: libro["imagen"]!.isNotEmpty
                                    ? Image.memory(
                                  base64Decode(libro["imagen"]!),
                                  fit: BoxFit.contain,
                                )
                                    : const Icon(
                                  Icons.image_not_supported,
                                  size: 80,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              libro["titulo"]!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
