/*
   Modèle utilisant des variables de décision entières
   et prenant en compte les contraintes de consommation
   (i.e. qui simule la contrainte globale par un ensemble de contraintes élémentaires)
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
dvar int allExecution[codes][0..dureeMax] in 0..1; // tableau de l'execution de chaque tache a un instant d

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


   // remplir le tableau d'executiion des taches a un instant d
   forall(d in 0..dureeMax){
      forall(c in codes){
         allExecution[c][d] == (debut_taches[c] <= d && fin_taches[c] > d);
      }
   }

   // ne pas depasser la consommation max 
   forall(d in 0..dureeMax){
      (sum (t in taches) allExecution[t.code][d] * t.puissance) <= puissanceMax;
   }

}	


//----------------------- Affichage Solution ---------------------------

execute {
     writeln("Solution : ");
    for(var t in taches){
      var c = 0;
      while (c < debut_taches[t.code]){
         write(" ");
         c = c + 1;
      }
      while (c < fin_taches[t.code]){
         write(t.code);
         c = c + 1;
      }
      writeln();
    }
}