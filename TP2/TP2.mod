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
{int} valeurs = {1,2,5,10,20,50};
dvar int m[sommes, valeurs] in d; // m[2][1] = 2 signifie "pour faire la somme 2 il y a 2 pieces de 1 centime" */
dvar int maxPieceNumber[valeurs] in d;

/*** Contraintes  ***/
// TODO
minimize 
	sum(v in valeurs) maxPieceNumber[v];
  

subject to{
    forall(s in sommes){
      s == (sum(v in valeurs)v*m[s][v]);
    }
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