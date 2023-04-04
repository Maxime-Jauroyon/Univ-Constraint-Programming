/*
   Modèle utilisant des variables de décision d'intervalle
   et prenant en compte les contraintes de consommation
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

Tache code_to_taches[codes] = [t.code : t | t in taches]; // index pour obtenir une tache a partir de son code

//----------------------- Modèle ---------------------------

// -- variables de décisions --
dvar interval planning [t in taches] in 0..dureeMax size t.duree; // tableau d'intervalle representant les taches

// -- variables de commodité --
cumulFunction allConsomation =  sum (t in taches) pulse(planning[t],t.puissance); // la consomation totale de l'usine reparti grace a une cumulFunction

// -- Critère d'optimisation --


minimize 
   // Objectif - A completer
   max (t in taches) endOf(planning[t]);

subject to {
    // Contraintes - A completer

    // chaque fin d'action doit respecter la precedence
    forall(c in cords) {
      endBeforeStart(planning[code_to_taches[c.avant]],planning[code_to_taches[c.apres]]);
    }
   

   // la consomation ne doit jamais depasser le max 
   allConsomation <= puissanceMax;
   
    
}	


//----------------------- Affichage Solution ---------------------------

execute {
   Opl.range
    writeln("Solution : ");
    for(var t in taches){
      var c = 0;
      while (c < (Opl.startOf(planning[t]))){
         write(" ");
         c = c + 1;
      }
      while (c < (Opl.endOf(planning[t]))){
         write(t.code);
         c = c + 1;
      }
      writeln();
    }
}