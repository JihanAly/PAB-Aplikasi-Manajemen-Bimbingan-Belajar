import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> students = [];

  Color statusColor(String status) {
    if (status == "Lunas") return Colors.green;
    if (status == "Cicilan") return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFD7E9FF),
              Color(0xFFF8FBFF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 25),
              Text(
                "Manajemen Siswa Bimbel",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Kelola data siswa dengan mudah",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: students.isEmpty
                    ? Center(
                        child: Text(
                          "Belum ada data siswa",
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        itemCount: students.length,
                        itemBuilder: (context, index) {
                          final s = students[index];

                          return Container(
                            margin: EdgeInsets.only(bottom: 15),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      s["nama"] ?? "",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.edit,
                                              color: Colors.blue),
                                          onPressed: () async {
                                            final result =
                                                await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    FormPage(data: s),
                                              ),
                                            );
                                            if (result != null) {
                                              setState(() {
                                                students[index] = result;
                                              });
                                            }
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: () {
                                            setState(() {
                                              students.removeAt(index);
                                            });
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text("Kelas: ${s["kelas"]}"),
                                Text("Mapel: ${s["mapel"]}"),
                                Text("Jadwal: ${s["jadwal"]}"),
                                SizedBox(height: 8),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: statusColor(
                                            s["status"] ?? "")
                                        .withOpacity(0.2),
                                    borderRadius:
                                        BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    s["status"] ?? "",
                                    style: TextStyle(
                                      color: statusColor(
                                          s["status"] ?? ""),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 91, 156, 231),
        child: Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => FormPage()),
          );
          if (result != null) {
            setState(() {
              students.add(result);
            });
          }
        },
      ),
    );
  }
}

class FormPage extends StatefulWidget {
  final Map<String, String>? data;
  FormPage({this.data});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  TextEditingController nama = TextEditingController();
  TextEditingController kelas = TextEditingController();
  TextEditingController mapel = TextEditingController();
  TextEditingController jadwal = TextEditingController();
  String status = "Belum Lunas";

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      nama.text = widget.data!["nama"]!;
      kelas.text = widget.data!["kelas"]!;
      mapel.text = widget.data!["mapel"]!;
      jadwal.text = widget.data!["jadwal"]!;
      status = widget.data!["status"]!;
    }
  }

  InputDecoration inputStyle(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD7E9FF),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 87, 127, 173),
        title:
            Text(widget.data == null ? "Tambah Data" : "Edit Data"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nama,
              decoration: inputStyle("Nama"),
            ),
            SizedBox(height: 15),
            TextField(
              controller: kelas,
              decoration: inputStyle("Kelas"),
            ),
            SizedBox(height: 15),
            TextField(
              controller: mapel,
              decoration: inputStyle("Mata Pelajaran"),
            ),
            SizedBox(height: 15),
            TextField(
              controller: jadwal,
              decoration: inputStyle("Jadwal"),
            ),
            SizedBox(height: 15),
            DropdownButtonFormField(
              value: status,
              decoration: inputStyle("Status"),
              items: [
                DropdownMenuItem(
                    value: "Lunas", child: Text("Lunas")),
                DropdownMenuItem(
                    value: "Belum Lunas",
                    child: Text("Belum Lunas")),
                DropdownMenuItem(
                    value: "Cicilan",
                    child: Text("Cicilan")),
              ],
              onChanged: (value) {
                setState(() {
                  status = value!;
                });
              },
            ),
            SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 100, 167, 243),
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                Navigator.pop(context, {
                  "nama": nama.text,
                  "kelas": kelas.text,
                  "mapel": mapel.text,
                  "jadwal": jadwal.text,
                  "status": status,
                });
              },
              child: Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}