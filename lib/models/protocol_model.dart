import 'package:cog_screen/models/essential_oils_model.dart';

class ProtocolModel {
  final EOScreenHeader header;
  final EOList oils;
  final ProtocolInstructions protcolInstructions;

  ProtocolModel({
    required this.header,
    required this.oils,
    required this.protcolInstructions,
  });
}

class EOList {
  final String title;
  final List<String> oils;

  EOList({
    this.title = '',
    required this.oils,
  });
}

class ProtocolInstructions {
  final String title;
  final String instructions;
  final String frequencyDuration;

  ProtocolInstructions({
    this.title = '',
    this.instructions = '',
    this.frequencyDuration = '',

  });
}