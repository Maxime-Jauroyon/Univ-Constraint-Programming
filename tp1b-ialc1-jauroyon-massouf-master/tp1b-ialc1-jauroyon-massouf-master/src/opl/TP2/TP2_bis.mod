/*********************************************
 * OPL 22.1.1.0 Model
 * Author: maxim
 * Creation Date: 14 mars 2023 at 15:15:09
 *********************************************/
using CP;

/*** Données du problème  ***/
// TODO

/*** Variables et domaines  ***/
// TODO

int dim = 8; // nombre de reines maximum et taille de l'echiquier
range d = 1..dim; // Taille de l'échiquier
dvar int t[d,d] in 0..1; // Echiquier
/*  t[2,2] = 1 signifie "dans la colonne 2 et ligne 2 on trouve une reine" */
/*  t[2,2] = 0 signifie "dans la colonne 2 et ligne 2 on trouve pas de reine" */
dvar int number_of_queen; // nombre de reines sur l'echiquier

/*** Contraintes  ***/
// TODO
minimize
  // on minimise le nombre de reines 
  number_of_queen;
  
subject to{
  	// on calcule le nombre de reines sur l'echiquier
  	number_of_queen == sum (j,k in d) t[j][k];
  	
  	// on ne doit pas avoir plus de reines que la taille de l'echiquier car le probleme devient trivial 
  	// (dim reines sur la premiere ligne par exemple)
    number_of_queen < dim;

	// pour chaque case il y a au moins 1 reine sur sa ligne ou colonne ou une de ses diagonales
    forall (j,k in d) {
        (sum (k2 in d) t[j][k2]) +
        (sum (j2 in d) t[j2][k]) + 
        (sum(d1 in d:(j-d1 in d) && (k-d1 in d))t[j-d1][k-d1]) +
        (sum(d2 in d:(j+d2 in d) && (k+d2 in d))t[j+d2][k+d2]) +
        (sum(d3 in d:(j-d3 in d) && (k+d3 in d))t[j-d3][k+d3]) +
        (sum(d4 in d:(j+d4 in d) && (k-d4 in d))t[j+d4][k-d4]) > 0;
    }

	
}

/*** Post-traitement  ***/
// TODO

execute {
    writeln("Solution :");
    for (var j in d) {
      	for (var k in d){
      	  write(t[j][k], " ");
      	}
        writeln();
    }
    writeln();
}