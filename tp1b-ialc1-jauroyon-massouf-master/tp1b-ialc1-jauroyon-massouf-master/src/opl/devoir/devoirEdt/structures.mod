// horaire
tuple horaire {
    int heure;
    int minute;
}

// filiere
tuple filiere{
    string id;
    {string} coursCommuns;
    {string} parcours;
}

// parcoursEdt
tuple parcour {
    string id;
    int effectif;
    {string} cours;
}

// coursEdt
tuple cour {
    string code;
    string description;
    string prof;
    int duree;
    {string} besoins;
}

// serieCours
tuple serie {
    string id;
    int nbOccurences;
    int ecartMin;
    int ecartMax;
}

// salles
tuple salle {
    string id;
    int capacite;
    {string} services;
}

// indisponibilitesProfs et indisponibilitesSalles
tuple indisponible {
    string id;
    int jour;
    horaire debut;
    horaire fin;
}

// precedences
tuple precedence {
    string avant;
    string apres;
}

// memesHoraires
tuple memeHoraire {
    string cour1;
    string cour2;
}

// creneauxFixes
tuple creneauxFixe {
    string id;
    int seance;
    int jour;
    int creneau;
}