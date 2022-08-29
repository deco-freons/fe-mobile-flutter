import 'package:flutter_boilerplate/preference/data/preference_model.dart';

class PreferenceUtils {
  final String preferenceId;

  const PreferenceUtils({required this.preferenceId});

  PreferenceModel getModel() {
    switch (preferenceId) {
      case "GM":
        return const PreferenceModel(
            preferenceID: "GM", preferenceName: '🎮 Gaming');
      case "MV":
        return const PreferenceModel(
            preferenceID: "MV", preferenceName: '🎬 Movie');
      case "DC":
        return const PreferenceModel(
            preferenceID: "DC", preferenceName: '💃️ Dancing');
      case "CL":
        return const PreferenceModel(
            preferenceID: "CL", preferenceName: '🍽 Culinary');
      case "BB":
        return const PreferenceModel(
            preferenceID: "BB", preferenceName: '🏀 Basketball');
      case "NT":
        return const PreferenceModel(
            preferenceID: "NT", preferenceName: '🍃️ Nature');
      case "FB":
        return const PreferenceModel(
            preferenceID: "FB", preferenceName: '⚽️ Football');
    }
    return const PreferenceModel(
        preferenceID: "XX", preferenceName: 'No Preference');
  }
}
