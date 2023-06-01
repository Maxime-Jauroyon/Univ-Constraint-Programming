/*********************************************
 * OPL 22.1.1.0 Model
 * Author: maxim
 * Creation Date: 12 mars 2023 at 20:05:44
 *********************************************/
using CP;

/*** Données du problème  ***/
// TODO

// Dimension du carré latin

/*** Variables et domaines  ***/
// TODO

range d = 1..4; // Domaine des variables
dvar int t[d, d] in d; // t[2][1] = 1 signifie "a la case de ligne 2 et la colonne 1 on trouve la valeur 1" */

/*** Pre-traitement  ***/
// TODO
include "shared/croissant_carreLatin.mod";

/*** Contraintes  ***/
// TODO

constraints {
    /* sont disposés de telle façon que chaque symbole apparaisse une fois et une seule sur chaque ligne et chaque colonne. */
	
	/* contrainte de différences sur les lignes */
    forall (i in d) {
        forall (j,k in d: j < k) {
            t[i,j] != t[i,k];
        }
    }

    /* contrainte de différences sur les colonnes */
    forall (j in d) {
        forall (i,k in d: i < k) {
            t[i,j] != t[k,j];
        }
    }
}

/*** Post-traitement  ***/
// TODO

execute {
    writeln("Solution :");
    for (var i in d) {
        for (var j in d) {
            write(t[i][j], " ");
        }
        writeln();
    }
}

include "shared/stat.mod";