using CP;

// Binome : Jauroyon Maxime, Massouf Philippe

// ---------------------- Structures ------------------------
// TODO

include "structures.mod";


// ------------------- Données Instances --------------------
// TODO 

string nomInstance = ...; 						// Chemin relatif vers ce fichier
int nbJours = ...;                              // Nombre de jours de l'emploi du temps
int nbCreneauxParJour = ...;                    // Nombre de créneaux par jour
int dureeCreneau = ...;                         // Durée d'un créneau (en mn)	
horaire horairePremierCreneau = ...;            // Horaire du premier créneau d'une journée
{filiere} filieresEdt = ...;					// Liste des  filieres
{parcour} parcoursEdt = ...;					// Liste des parcours
{cour} coursEdt  = ...;							// Liste des cours
{serie} seriesCours  = ...;						// Liste des series des cours
{salle} salles = ...;							// Liste des salles
{indisponible} indisponibilitesProfs = ...;		// Liste des indisponibilités des profs
{indisponible} indisponibilitesSalles = ...;	// Liste des indisponibilités des salles
{precedence} precedences = ...;					// Liste des precedences des cours
{memeHoraire} memesHoraires = ...;				// Liste des cours aux mêmes horaires
{creneauxFixe} creneauxFixes = ...;				// Liste des creneaux fixés pour des cours
int numeroCreneauAvantPauseMeridienne =  ...;	// Numero du creneau avant la pause meridienne
int dureePauseMeridienne =  ...;				// Duree de la pause meridienne



// -------------------- Pre-traitement ----------------------
// TODO 


// liste des id des cours
{string} coursId = union (c in coursEdt) {c.code};


// liste des id des parcours
{string} parcoursId = union (p in parcoursEdt) {p.id};
// index pour obtenir un parcour a partir de son id
parcour parcoursFromId[parcoursId] = [p.id : p | p in parcoursEdt];


// liste des noms des profs
{string} profs = union (c in coursEdt) {c.prof};
// matrice de boolean pour savoir quel prof fait quels cours
int coursFromProfs[profs][coursId];


// indisponibilitesProfs et indisponibilitesSalles apres pre-processing

// le creneau pour le debut de l'indisponibilité des indisponibilitesProfs
int getIndisponibilitesProfsDebut[indisponibilitesProfs];
// le creneau pour la fin de l'indisponibilité des indisponibilitesProfs
int getIndisponibilitesProfsFin[indisponibilitesProfs];


// liste des tailles de creneaux par chaque id de cours apres pre-processing
int creneauxSizes[coursId];


// Occurrence maximale pour n'importe quel cour apres pre-processing
int nbMaxOccurrence;
// Occurrence maximale des cours dans seriesCours
int nbMaxOccurrenceInSeriesCours = max (s in seriesCours) s.nbOccurences;


// Occurrence max de chaque cours apres pre-processing
int occurrenceMax[coursId];


// liste des seances pour les matrices des variables
range seances = 1..nbMaxOccurrence;
// liste des creneaux pour les variables intervalles
range creneaux = 0..nbCreneauxParJour;

// pre-processing
execute {
  
  // return la taille du creneau associé a la durée d'un cours
  function getCreneauSize(duree) {
      return Math.ceil(duree * 1.0 / dureeCreneau);
  }
  // rempli le tableau des tailles de créneaux pour chaque cours
  for( var c in coursEdt ) {
    creneauxSizes[c.code] = getCreneauSize(c.duree);
  }
    
    
  // le nombre maximum d'occurence possible pour un cour
	nbMaxOccurrence = Math.max(1,nbMaxOccurrenceInSeriesCours);
	
	
	// on suppose que si le cour a au moins 2 seances alors il sera forcement dans seriesCours (même si les 2 seances sont fixés)
	// donc on initialise tous les cours à 1 seance
	for( var c in coursEdt ) {
       occurrenceMax[c.code] = 1;
    }
    // puis on change pour ceux qui ont plus de seances
	for( var s in seriesCours ) {
       occurrenceMax[s.id] = s.nbOccurences;
    }
    
    
    // on initialise la matrice avec que des 0 (faux)
    for(var c in coursId){
      for(var p in profs){
        coursFromProfs[p][c] = 0;
      }
    }
    // puis pour chaque cours on met 1 au prof pour ce cour (vrai)
    for(var c in coursEdt) {
      coursFromProfs[c.prof][c.code] = 1;
    }
    
    
    // return le creneau - 1 mais en fonction de la pause meridienne pour l'horaire du debut
    function getCreneauDebut(hr){
      for(var cr in creneaux){
        if (cr <= numeroCreneauAvantPauseMeridienne ){
        	var h = horairePremierCreneau.heure + (cr) * dureeCreneau / 60;
           	var mn = horairePremierCreneau.minute + ((cr) * dureeCreneau) % 60;
       	} else {
            var h = Math.floor(horairePremierCreneau.heure + (cr) * dureeCreneau / 60 + dureePauseMeridienne / 60) ;
           	var mn = horairePremierCreneau.minute + ((cr) * dureeCreneau) % 60 + dureePauseMeridienne % 60 ;
            if (mn/60 > 0){
            	h += Math.floor(mn/60);
            	mn -= Math.floor(mn/60)*60;
            }
        }
        if (hr.heure < h){
          return cr-1;
        }
        if (hr.heure == h && hr.minute < mn){
          return cr-1;
        }
      }
      return nbCreneauxParJour;
    }
    
    
    // return le creneau - 1 mais en fonction de la pause meridienne pour l'horaire de fin
    function getCreneauFin(hr){
      for(var cr in creneaux){
        if (cr < numeroCreneauAvantPauseMeridienne ){
        	var h = horairePremierCreneau.heure + (cr) * dureeCreneau / 60;
           	var mn = horairePremierCreneau.minute + ((cr) * dureeCreneau) % 60;
       	} else {
            var h = Math.floor(horairePremierCreneau.heure + (cr) * dureeCreneau / 60 + dureePauseMeridienne / 60) ;
           	var mn = horairePremierCreneau.minute + ((cr) * dureeCreneau) % 60 + dureePauseMeridienne % 60 ;
            if (mn/60 > 0){
            	h += Math.floor(mn/60);
            	mn -= Math.floor(mn/60)*60;
            }
        }
        if (hr.heure < h){
          return cr-1;
        }
        if (hr.heure == h && hr.minute <= mn){
          return cr-1;
        }
      }
      return nbCreneauxParJour;
    }
    
    
    // rempli le tableau des creneaux qui represente le debut et la fin des horaires
    for(var ind in indisponibilitesProfs){
      getIndisponibilitesProfsDebut[ind] = getCreneauDebut(ind.debut);
      getIndisponibilitesProfsFin[ind] = getCreneauFin(ind.fin);
    }
    // print de debugging
    // utile si vous voulez comprendre pourquoi ca marche car c'est la partie la plus complexe
    //writeln(getIndisponibilitesProfsDebut)
  	//writeln(getIndisponibilitesProfsFin)
    
}



// ------------------------ Modèle --------------------------
// TODO 

// planning des cours et de leurs seances (donc des variables qui ne servent a rien)
// pour les jours avec 0 comme valeur poubelle (pour les seances ne devant pas avoir lieu)
dvar int planning_cours_jours[coursId][seances] in 0..nbJours;
// pour les creneaux avec des intervalles de bonne taille
dvar interval planning_cours_creneaux [c in coursId][seances] in creneaux size creneauxSizes[c];



subject to {
	
	
	// on ne doit pas avoir jour 0 pour les seances ayant vraiment lieu 
	forall(c in coursEdt){
	  forall(s in seances: (s <= occurrenceMax[c.code])){ // seances ayant lieux
	    planning_cours_jours[c.code][s] > 0;
	  }
	}
	// on doit avoir jour 0 pour les seances n'ayant pas vraiment lieu (donc valeur poubelle)
	forall(c in coursEdt){
	  forall(s in seances: (s > occurrenceMax[c.code])){ // seances en trop que l'on fixe a 0
		planning_cours_jours[c.code][s] == 0;
	  }
	}
	
	
	// pour les creneaux des seances qui n'ont pas lieu on n'y touche pas car pas necessaire
	
	
	// les cours doivent s'enchainer chronologiquement : cours1 avant cours2
	forall(c in coursEdt){
	  forall(s,k in seances: s<k && (s < occurrenceMax[c.code])){ // attention < et non <= car on regarde 1 pas plus loin !
	    planning_cours_jours[c.code][s] <= planning_cours_jours[c.code][k];
	  }
	}
	// les cours doivent s'enchainer chronologiquement : cours1 avant cours2 si le même jour
	forall(c in coursEdt){
	  forall(s,k in seances: s<k && (s < occurrenceMax[c.code])){ // attention < et non <= car on regarde 1 pas plus loin !
	    // (endBeforeStart)
	    endOf(planning_cours_creneaux[c.code][s]) * (planning_cours_jours[c.code][s] == planning_cours_jours[c.code][k]) <= startOf(planning_cours_creneaux[c.code][k]) * (planning_cours_jours[c.code][s] == planning_cours_jours[c.code][k]);
	  // pour l'appliquer seulement lorsque les seances sont le même jour on multiplie des 2 cotés par (planning_cours_jours[c][s] == planning_cours_jours[c][k])
	  }
	}
	
	
	// on ne peut pas avoir de cour qui commence avant la pause meridienne et fini apres
	forall(c in coursEdt){
	  forall(s in seances: (s <= occurrenceMax[c.code])){ // seances ayant lieux
	  	// les longueur des seances qui commencent avant la pause doivent etre egale ou moins longue que le nombre de creneaux restant avant la pause
	    (startOf(planning_cours_creneaux[c.code][s]) < numeroCreneauAvantPauseMeridienne) * creneauxSizes[c.code] <= (numeroCreneauAvantPauseMeridienne - startOf(planning_cours_creneaux[c.code][s])) * (startOf(planning_cours_creneaux[c.code][s]) < numeroCreneauAvantPauseMeridienne);
	  // pour l'appliquer seulement lorsque la seance commence avant la pause on multiplie des 2 cotés par (startOf(planning_cours_creneaux[c.code][s]) < numeroCreneauAvantPauseMeridienne)
	  }
	}
	
	
	// les cours d'un même parcours ne doivent pas avoir lieux en même temps
	forall(p in parcoursEdt){
	  forall(c1,c2 in p.cours: c1!=c2){ // tous les tuples de cours differents possibles
	    forall(s,k in seances: (s <= occurrenceMax[c1]) && (k <= occurrenceMax[c2])){ // seances ayant lieux
	      // SI les 2 cours ont lieux le même jour
	      // soit c1 fini avant que c2 commence OU c2 fini avant que c1 commence (noOverlap)
	      (planning_cours_jours[c1][s] == planning_cours_jours[c2][k]) * ((endOf(planning_cours_creneaux[c1][s]) <= startOf(planning_cours_creneaux[c2][k])) || (endOf(planning_cours_creneaux[c2][s]) <= startOf(planning_cours_creneaux[c1][k])) ) == (planning_cours_jours[c1][s] == planning_cours_jours[c2][k]) ;
	    // encore une autre technique avec (planning_cours_jours[c1][s] == planning_cours_jours[c2][k])
	    }
	  }
	}
	// les cours communs d'une filiere ne doivent pas avoir lieux en même temps que les cours des parcours de la filiere
	forall(f in filieresEdt){
	  forall(c1 in f.coursCommuns){ // pour chaque cours communs
	    forall(p in f.parcours){ // pour chaque parcours
	      forall(c2 in parcoursFromId[p].cours){ // tous les cours de ce parcour
		    forall(s,k in seances: (s <= occurrenceMax[c1]) && (k <= occurrenceMax[c2])){ // seances ayant lieux
		      // SI les 2 cours ont lieux le même jour
		      // soit c1 fini avant que c2 commence OU c2 fini avant que c1 commence (noOverlap)
		      (planning_cours_jours[c1][s] == planning_cours_jours[c2][k]) * ((endOf(planning_cours_creneaux[c1][s]) <= startOf(planning_cours_creneaux[c2][k])) || (endOf(planning_cours_creneaux[c2][s]) <= startOf(planning_cours_creneaux[c1][k])) ) == (planning_cours_jours[c1][s] == planning_cours_jours[c2][k]) ;
		    // même chose qu'au dessus
		    }
		  }
	    }
	  }
	}
	// les cours communs d'une filiere ne doivent pas avoir lieux en même temps que les autres cours communs de la filiere
	forall(f in filieresEdt){
	  forall(c1,c2 in f.coursCommuns: c1!=c2){ // pour chaque cours communs
		forall(s,k in seances: (s <= occurrenceMax[c1]) && (k <= occurrenceMax[c2])){ // seances ayant lieux
		   // SI les 2 cours ont lieux le même jour
		   // soit c1 fini avant que c2 commence OU c2 fini avant que c1 commence (noOverlap)
		   (planning_cours_jours[c1][s] == planning_cours_jours[c2][k]) * ((endOf(planning_cours_creneaux[c1][s]) <= startOf(planning_cours_creneaux[c2][k])) || (endOf(planning_cours_creneaux[c2][s]) <= startOf(planning_cours_creneaux[c1][k])) ) == (planning_cours_jours[c1][s] == planning_cours_jours[c2][k]) ;
		   // même chose qu'au dessus
		}
	  }
	}
	
	
	// les seances d'un même cour respectent l'ecart de jours
	forall(se in seriesCours){
	  forall(s in seances: s < occurrenceMax[se.id]){ // attention < et non <= car on regarde 1 pas plus loin !
	  	// le cour d'apres se trouve dans l'intervalle {j+ecartMin,j+ecartMax}
	    planning_cours_jours[se.id][s] + se.ecartMin <= planning_cours_jours[se.id][s+1] && planning_cours_jours[se.id][s] + se.ecartMax >= planning_cours_jours[se.id][s+1];
	  }
	}
	
	
	// les seances fixés
	forall(cr in creneauxFixes){
	  planning_cours_jours[cr.id][cr.seance] == cr.jour;  // on fixe le jour
	  startOf(planning_cours_creneaux[cr.id][cr.seance]) == cr.creneau-1; // on fixe creneau - 1 car l'indice du debut de l'intervalle
	}
	
	
	// les cours ayant les mêmes horaires (ont suppose le même nombre de seances et la même durée de cour)
	forall(mh in memesHoraires){
	  forall(s in seances: (s <= occurrenceMax[mh.cour1])){ // seances ayant lieux (juste pour 1 cour car c'est pareil pour les 2)
	    planning_cours_jours[mh.cour1][s] == planning_cours_jours[mh.cour2][s]; // même jour
	  	startOf(planning_cours_creneaux[mh.cour1][s]) == startOf(planning_cours_creneaux[mh.cour2][s]); // même debut
	  	endOf(planning_cours_creneaux[mh.cour1][s]) == endOf(planning_cours_creneaux[mh.cour2][s]); // même fin
	  }
	}
	
	
	// les cours qui doivent se preceder (ont suppose le même nombre de seances)
	forall(pr in precedences){
	  forall(s in seances: (s <= occurrenceMax[pr.avant])){ // seances ayant lieux
	    planning_cours_jours[pr.avant][s] <= planning_cours_jours[pr.apres][s]; // se precede en jours (même jour ou avec des jours d'ecart)
	    // si le même jour alors on rajoute la contrainte sur la precedence des intervalles pour les creneaux
	  	(planning_cours_jours[pr.avant][s] == planning_cours_jours[pr.apres][s]) * endOf(planning_cours_creneaux[pr.avant][s]) <= startOf(planning_cours_creneaux[pr.apres][s]) * (planning_cours_jours[pr.avant][s] == planning_cours_jours[pr.apres][s]);
	  // pour l'appliquer seulement lorsque les seances sont le même jour on multiplie des 2 cotés par (planning_cours_jours[c][s] == planning_cours_jours[c][k])
	  }
	}
	

	// gerer les indisponibilités des profs
	forall(ind in indisponibilitesProfs){
	  forall(c in coursEdt){ // pour chaque cours
	    forall(s in seances: (s <= occurrenceMax[c.code])){ // seances ayant lieux
	      // si ce n'est pas le bon prof (via coursFromProfs[ind.id][c.code] == 0) alors contrainte validé car directement 0 == 0
	      // sinon les seances ne doivent pas avoir lieux au jour indiqué et
	      // avoir l'intervalle qui fini apres le debut du premier creneau dans la plage d'indisponibilité
	      // alors que l'intervalle a commencé avant le dernier creneau dans la plage d'indisponibilité
	      // donc le seul moyen que la contrainte soit valider c'est si :
	      // 1- ce n'est pas le même jour
	      // 2- même jour mais l'intervalle est strictement avant la plage d'indisponibilité
	      // 3- même jour mais l'intervalle est strictement  la plage d'indisponibilité
	      ((coursFromProfs[ind.id][c.code] == 1) && (planning_cours_jours[c.code][s] == ind.jour) && (endOf(planning_cours_creneaux[c.code][s]) >= getIndisponibilitesProfsDebut[ind]+1) && (startOf(planning_cours_creneaux[c.code][s]) <= getIndisponibilitesProfsFin[ind])) == 0;
	    }
	  }
	}
	
	
	
	

}


// --------------------- Post-traitement --------------------
// TODO 

// la structure EdtCours
//tuple EdtCours {
    //string idCours;
    //int jour;
    //int creneauJour;
    //int h;
    //int mn;
    //string idSalle;
//}

// Écrire les résultats dans un fichier .dat
execute {
  
  // Extraire le chemin relatif et le nom de l'instance
  var instancePath = nomInstance.split("/");
  var instanceName = instancePath[instancePath.length - 1].split(".")[0];

  // Spécifier le répertoire de destination en fonction du chemin de l'instance
  var outputDirectory = "resultats/";
    
  // Ajouter le chemin relatif sans "data/" ni le nom de l'instance
  var cpt = 1;
  while(cpt < instancePath.length - 1){
    outputDirectory += instancePath[cpt] + "/";
    cpt++;
  }

  // Créer le nom de fichier en fonction du modèle utilisé (par exemple, edt_XXX)
  var modelName = "edt_simple"; // Remplacer XXX par le nom spécifique du modèle

  // Ouvrir le fichier en mode écriture dans le répertoire spécifié
  var file = new IloOplOutputFile(outputDirectory + instanceName + "_" + modelName + ".dat");

  // Écrire le chemin d'accès au fichier d'instance utilisé
  var cheminFichierInstance = nomInstance;
  file.writeln("nomInstance = " + cheminFichierInstance + ";");
  file.writeln();

	file.writeln("edt = {");
    // Écrire les résultats pour chaque cours
    for (var c in coursEdt) {
        for (var s in seances) {
            // Récupérer les informations du cours
            var idCours = c.code;
            var jour = planning_cours_jours[c.code][s];
            var creneauJour = Opl.startOf(planning_cours_creneaux[c.code][s]);
            if (creneauJour < numeroCreneauAvantPauseMeridienne ){
                var h = horairePremierCreneau.heure + (creneauJour) * dureeCreneau / 60;
            	var mn = horairePremierCreneau.minute + ((creneauJour) * dureeCreneau) % 60;
            } else {
                var h = Math.floor(horairePremierCreneau.heure + (creneauJour) * dureeCreneau / 60 + dureePauseMeridienne / 60) ;
            	var mn = horairePremierCreneau.minute + ((creneauJour) * dureeCreneau) % 60 + dureePauseMeridienne % 60 ;
            	if (mn/60 > 0){
            	  h += Math.floor(mn/60);
            	  mn -= Math.floor(mn/60)*60;
            	}
            }
            var idSalle = ""; // Ajoutez ici la logique pour récupérer l'ID de la salle
            // Écrire les informations du cours sous forme de tuple dans le fichier de sortie
            var tupleString = "   <\"" + idCours + "\", " + jour + ", " + (creneauJour+1) + ", " + h + ", " + mn + ", \"" + idSalle + "\">,";
            file.writeln(tupleString);
        }
    }
    file.writeln("};");

    // Fermer le fichier
    file.close();
}


execute {
  // affichage simple mais suffisant
  for(var c in coursEdt){
  	writeln("code : ",c.code);
    for(var s in seances){
     	if (s <= occurrenceMax[c.code]){
    		writeln("jour : ",planning_cours_jours[c.code][s]," creneau : ",planning_cours_creneaux[c.code][s]);
   		}    	
    }
    writeln("taille creneau : ",creneauxSizes[c.code]);
    writeln("occurence : ",occurrenceMax[c.code]);
    writeln("-----------");
  }
    
}