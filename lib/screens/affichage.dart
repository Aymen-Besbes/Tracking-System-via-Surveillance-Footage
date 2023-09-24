import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:pcd_version_finale/screens/super_user_screen.dart';

void main() {
  runApp(Affichage());
}

class Affichage extends StatefulWidget {
  @override
  _AffichageState createState() => _AffichageState();
}

class _AffichageState extends State<Affichage> {
  late List<String> similarities;
  late List<DateTime> dates;
  late List<String> locations;
  Random random = Random();

  List<String> locationsList =  [
    'Municipalité principale de Sfax, Beb Bhar, Sfax',
    'Hôtel de Ville de Sfax, Avenue Habib Bourguiba, Sfax',
    'Palais de Justice de Sfax, Rue de la République, Sfax',
    'Gouvernorat de Sfax, Rue Hedi Chaker, Sfax',
    'Siège de la Chambre de Commerce et d\'Industrie de Sfax, Avenue de la Liberté, Sfax',
    'Siège de la Banque Centrale de Tunisie - Succursale de Sfax, Rue Farhat Hached, Sfax',
    'Hôpital Universitaire Habib Bourguiba de Sfax, Avenue de la Victoire, Sfax',
    'Siège de la Télévision Tunisienne - Centre Régional de Sfax, Rue du 20 Mars, Sfax',
    'Maison de la Culture de Sfax, Avenue Mongi Bali, Sfax',
    'Stade Taieb Mhiri, Rue Salah Ben Youssef, Sfax',
    'Musée Dar Jallouli, Rue de la Kasbah, Sfax',
    'Centre Culturel International de Sfax, Avenue des Martyrs, Sfax',
    'Société des Foires Internationales de Sfax, Route de Tunis, Sfax',
    'Cité administrative, Avenue de la Liberté, Sfax',
    'Institut Supérieur des Sciences Infirmières de Sfax, Avenue de la Victoire, Sfax',
    'Faculté des Sciences Economiques et de Gestion de Sfax, Rue de l\'économie, Sfax',
    'Collège Sadiki, Rue Ibn Khaldoun, Sfax',
    'Lycée Technique de Sfax, Rue de la Tunisie, Sfax',
    'Café El Khottab, Rue de la Mosquée, Sfax',
    'Restaurant Le Méditerranée, Corniche de Sfax, Sfax',
    'Complexe Sportif Chedly-Zouiten, Rue 18 Janvier, Sfax',
    'Centre Commercial Carrefour Sfax, Avenue Hedi Nouira, Sfax',
    'Marché Central de Sfax, Avenue Habib Bourguiba, Sfax',
    'Cinéma Rio, Avenue de la Liberté, Sfax',
    'Jardin Public de Sfax, Avenue Mongi Bali, Sfax',
    'Hôtel El Layeli, Corniche de Sfax, Sfax',
    'Plage Chaffar, Route de Lafrane, Sfax',
    'Société de Réalisation et de Gestion de la Ville de Sfax, Avenue de la Victoire, Sfax',
    'Complexe Olympique de Sfax, Route de Tunis, Sfax',
    'Clinique El Amen, Rue Salah Ben Youssef, Sfax',
    'Salle de Spectacles Sidi Mansour, Rue du 20 Mars, Sfax',
    'Mosquée Al Abbassi, Avenue Hedi Nouira, Sfax',
    'École Supérieure de Commerce de Sfax, Rue Hedi Chaker, Sfax',
    'Centre de Loisirs Sfax Plage, Corniche de Sfax, Sfax',
    'Club Sportif Sfaxien, Avenue de la Liberté, Sfax',
    'Complexe Culturel de Sfax, Rue Farhat Hached, Sfax',
    'Centre Hospitalier Universitaire Habib Bourguiba de Sfax, Avenue Majida Boulila, Sfax',
    'Bibliothèque Municipale de Sfax, Rue de la Paix, Sfax',
    'Maison de Jeunes de Sfax, Avenue Habib Bourguiba, Sfax',
    'Centre de Formation Professionnelle de Sfax, Rue de l\'artisanat, Sfax',
    'Bureau de Poste de Sfax, Avenue de la Liberté, Sfax',
    'Église Sainte-Marie, Rue Sadok Mokaddem, Sfax',
    'Terrain de Football Jbel Arko, Avenue Hedi Nouira, Sfax',
    'Supermarché Magasin Général, Rue Farhat Hached, Sfax',
    'Piscine Olympique de Sfax, Avenue de la Victoire, Sfax',
    'Hôtel Les Oliviers Palace, Rue des Martyrs, Sfax',
    'Gare de Sfax, Avenue de la République, Sfax',
    'Théâtre Municipal de Sfax, Avenue Hedi Nouira, Sfax',
    'Conservatoire Municipal de Musique de Sfax, Rue des Palmiers, Sfax',
    'Parc Al-Nasr, Rue du 20 Mars, Sfax',
    'Université de Sfax, Route de Soukra, Sfax',
    'Café El Kasbah, Rue de la Kasbah, Sfax',
    'Clinique Alyssa, Avenue Hedi Nouira, Sfax',
    'École Primaire 2 Mars, Avenue de la Victoire, Sfax',
    'Centre de Formation des Moniteurs de Sfax, Avenue de la Liberté, Sfax',
    'Lycée Technique de l\'Automobile, Rue Salah Ben Youssef, Sfax',
    'Stade Zouiten, Avenue Majida Boulila, Sfax',
    'Résidence Universitaire Sidi Mansour, Avenue Mongi Bali, Sfax',
    'Polyclinique el Nasr, Avenue Hedi Nouira, Sfax',
    'Institut Supérieur des Sciences Appliquées et de Technologie de Sfax, Route de Soukra, Sfax',
    'Rue de la République, Sfax',
    'Rue Hedi Chaker, Sfax',
    'Avenue de la Liberté, Sfax',
    'Rue Farhat Hached, Sfax',
    'Avenue de la Victoire, Sfax',
    'Rue du 20 Mars, Sfax',
    'Avenue Mongi Bali, Sfax',
    'Rue Salah Ben Youssef, Sfax',

  ];


  @override
  void initState() {
    super.initState();
    similarities = [];
    dates = [];
    locations = [];
    generateValues();
    sortData();
  }

  void generateValues() {
    int numItems = random.nextInt(4) + 3; // Générer un nombre aléatoire entre 3 et 6

    DateTime currentDate = DateTime.now();
    int hour = currentDate.hour;
    int minute = currentDate.minute;

    for (int i = 0; i < numItems; i++) {
      // Générer une similarité aléatoire entre 90 et 100
      int similarityValue = random.nextInt(11) + 90;
      similarities.add(similarityValue.toString());

      // Générer une date aléatoire proche de la date actuelle
      int day = currentDate.day + random.nextInt(3);
      int month = currentDate.month;
      int year = currentDate.year;
      hour = (hour + random.nextInt(4)) % 24;
      minute = random.nextInt(60);
      DateTime dateTime = DateTime(year, month, day, hour, minute);
      dates.add(dateTime);

      // Choisir une localisation aléatoire dans la liste des villes
      int index = random.nextInt(locationsList.length);
      locations.add(locationsList[index]);
    }
  }

  void sortData() {
    dates.sort((a, b) => a.compareTo(b));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(

          backgroundColor: Colors.deepPurpleAccent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => PickImage(),
                ),
              );
            },
          ),

          title: Text('Informations de mouvements'),
        ),
        body: ListView.builder(
          itemCount: similarities.length,
          itemBuilder: (context, index) {
            String formattedDate = DateFormat('dd-MM-yyyy à HH:mm').format(dates[index]);
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Similarité : ${similarities[index]}%',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Date : $formattedDate',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Localisation : ${locations[index]}',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
