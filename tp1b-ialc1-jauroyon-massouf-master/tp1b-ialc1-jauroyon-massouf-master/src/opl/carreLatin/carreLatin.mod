/*********************************************
 * Modèle pour le problème du carré latin
 *
 * Binôme :   TP1B Maxime, Philippe
 *
 *********************************************/
using CP;

/*** Données du problème  ***/
// TODO

// Dimension du carré latin

/*** Variables et domaines  ***/
// TODO

range d = 1..4; // Domaine des variables
dvar int t[d, d] in d; // t[2][1] = 1 signifie "a la case de ligne 2 et la colonne 1 on trouve la valeur 1" */

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
    for (i in d) {
        for (j in d) {
            write(t[i][j], " ");
        }
        writeln();
    }
}
