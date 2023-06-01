/* Modèle utilisant des variables de décision entières
   et ne prenant pas en compte les contraintes de consommation
*/



using CP;

// ----- Structures de données pour décrire une instance de problème -----

// Modélisation des informations caractérisant une tâche
tuple Tache{
    string code;		// le code de la tache
    int duree;		    // la duree de la tache
    int puissance;		// la puissance consommee par la tache
}

// Modélisation des contraintes d'ordonnancement à respecter
tuple Ord{
   string avant;		// le code de la tache qui doit se derouler en premier
   string apres;		// le code de la tache qui doit se derouler en second 	
}

//----------------------- Données ---------------------------
{Tache} taches = ...;        // les taches du probleme
{Ord}   cords = ...;       // les contraintes d'ordonnancement entre taches
int	  puissanceMax = ...;   // la puissance maximale de l'usine

//----------------------- Pretraitement ---------------------------		
	    
// A compléter si nécessaire 
int dureeMax = sum (t in taches) t.duree; // duree max si ont execute toutes les taches les unes apres les autres
{string} codes = union (t in taches) {t.code}; // liste des codes des taches

//----------------------- Modèle ---------------------------

// -- variables de décisions --
dvar int debut_taches[codes] in 0..dureeMax; // tableau de la valeur de debut des taches
dvar int fin_taches[codes] in 0..dureeMax; // tableau de la valeur de fin des taches

// -- variables de commodité --

// -- Critère d'optimisation --


minimize 
   // Objectif - A completer
   max (c in codes) fin_taches[c];
subject to {
    // Contraintes - A completer

    // chaque fin d'action doit respecter la precedence
    forall(c in cords) {
      fin_taches[c.avant] < debut_taches[c.apres];
    }

   // chaque tache doit respecter sa durée
    forall(t in taches){
      debut_taches[t.code] + t.duree == fin_taches[t.code];
    }

   
    
}	


//----------------------- Affichage Solution ---------------------------

execute {
    write("Solution : ");
    for(var c in codes){
      write(c,"  | ")
    }
    writeln()
    write("debut :    ");
    for(var t in taches){
      write(debut_taches[t.code]," | ")
    }
    writeln()
    write("fin :      ")
    for(var t in taches){
      write(fin_taches[t.code]," | ")
    }
}