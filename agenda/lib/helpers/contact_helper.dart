import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String _contactTable = "contactTable";
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String emailColumn = "emailColumn";
final String phoneColumn = "phoneColumn";
final String imageColumn = "imageColumn";

class ContactHelper {
  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDatabase();
      return _database;
    }
  }

  Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "contacts.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE $_contactTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT, $phoneColumn TEXT, $imageColumn TEXT)");
    });
  }

  Future<Contact> saveContact(Contact contact) async {
    Database dbContact = await database;
    contact.id = await dbContact.insert(_contactTable, contact.toMap());
    return contact;
  }

  Future<Contact> getContact(int id) async {
    Database dbContact = await database;
    List<Map> map = await dbContact.query(_contactTable,
        columns: [idColumn, nameColumn, emailColumn, phoneColumn, imageColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);

    if (map.length > 0) {
      return Contact.fromMap(map.first);
    } else {
      return null;
    }
  }

  Future<int> deleteContact(int idContact) async {
    Database dbContact = await database;
    return await dbContact
        .delete(_contactTable, where: "$idColumn = ?", whereArgs: [idContact]);
  }

  Future<int> updateContact(Contact contact) async {
    Database dbContact = await database;
    return await dbContact.update(_contactTable, contact.toMap(),
        where: "$idColumn = ?", whereArgs: [contact.id]);
  }

  Future<List<Contact>> getAllContacts() async {
    Database dbContact = await database;
    List listMaps = await dbContact.rawQuery("SELECT * FROM $_contactTable");
    List<Contact> listContacts = List();

    for (Map m in listMaps) {
      listContacts.add(Contact.fromMap(m));
    }

    return listContacts;
  }

  Future<int> getNumber() async {
    Database dbContact = await database;
    return Sqflite.firstIntValue(
        await dbContact.rawQuery("SELECT COUNT(*) FROM $_contactTable"));
  }

  Future close() async {
    Database dbContact = await database;
    dbContact.close();
  }
}

class Contact {
  int id;
  String name;
  String email;
  String phone;
  String image;


  Contact({this.name, this.email, this.phone, this.image});

  Contact.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    image = map[imageColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imageColumn: image,
    };

    if (id != null) {
      map[idColumn] = id;
    }

    return map;
  }

  @override
  String toString() {
    return "Contact(id: $id, name: $name, email: $email, phone: $phone, image: $image)";
  }
}
