/*********************************************
 * OPL 22.1.1.0 Model
 * Author: maxim
 * Creation Date: 14 mars 2023 at 14:34:04
 *********************************************/
using CP;

/*** Données du problème  ***/
// TODO


/*** Variables et domaines  ***/
// TODO

range d = 0..99; // Domaine des variables = nombre de pieces
range sommes = 1..99; // sommes possibles < 1 euro
{int} valeurs = {1,2,5,10,20,50}; // valeurs des pieces
dvar int m[sommes, valeurs] in d; // m[2][1] = 2 signifie "pour faire la somme 2 il y a 2 pieces de 1 centime" */
dvar int maxPieceNumber[valeurs] in d; // nombre de pieces requis au maximum pour chaque valeur de pieces

/*** Contraintes  ***/
// TODO
minimize 
	// on minimise la somme du nombre maximum de pieces requise pour chaque valeurs
	sum(v in valeurs) maxPieceNumber[v];
  

subject to{
  	// somme de la ligne i est egal a la somme de ses pieces
    forall(s in sommes){
      s == (sum(v in valeurs)v*m[s][v]);
    }
    // le maximum requis d'une valeur est le maximum de sa colonne
    forall(v in valeurs){
      maxPieceNumber[v] == max(s in sommes)m[s][v];
    }
}

/*** Post-traitement  ***/
// TODO

execute {
    writeln("Solution :");
    for (var v in valeurs) {
        writeln(v," : ",maxPieceNumber[v]);
    }
}