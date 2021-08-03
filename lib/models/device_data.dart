class Device {
  String guid;
  String mac;
  String type;
  String quantity;
  String name;
  String version;
  String minor;
  String status;

  Device(
    this.guid,
    this.mac,
    this.minor,
    this.name,
    this.quantity,
    this.status,
    this.type,
    this.version,

  );

  Device.fromMap(Map<String, dynamic> device){
    this.guid = device["guid"];
    this.mac = device["mac"];
    this.type = device["type"];
    this.quantity = device["quantity"];
    this.name = device["name"];
    this.version = device["version"];
    this.minor = device["minor"];
    this.status = device["status"];
  }

  Map<String, dynamic> toMap() =>{
    'guid' : guid,
    'mac' : mac,
    'type' : type,
    'quantity' : quantity,
    'name' : name,
    'version' : version,
    'minor' : minor,
    'status' : status
  };

  String get getGuid => guid;
  String get getMac => mac;
  String get getType => type;
  String get getQuantity => quantity;
  String get getName => name;
  String get getVersion => version;
  String get getMinor => minor;
  String get getStatus => status;

  set getGuid (String value) {guid = value;}
  set getMac (String value) {mac = value;}
  set getType (String value) {type = value;}
  set getQuantity (String value) {quantity = value;}
  set getName (String value) {name = value;}
  set getVersion (String value) {version = value;}
  set getMinor (String value) {minor = value;}
  set getStatus (String value) {status = value;}
}