/*********************************************
 * Modèle pour le problème des n-reines
 *
 * Binôme :   TP1B Maxime, Philippe
 *
 *********************************************/
using CP;

/*** Données du problème  ***/
// TODO

/*** Variables et domaines  ***/
// TODO

range d = 1..6; // Domaine des variables
dvar int t[d] in d; /*  t[2] = 3 signifie "dans la colonne 2 on trouve la reine a la ligne 3" */


/*** Contraintes  ***/
// TODO

constraints {
    /* deux reines (se déplaçant comme aux jeu des échecs) ne soient jamais en position de prise mututelle. */

	/* deux reines ne peuvent pas être sur la même colonne est deja satisfait car ce sont nos variables */

	/* deux reines ne peuvent pas être sur la même ligne */
    forall (j,k in d: j < k) {
        t[j] != t[k];
    }

	/* deux reines ne peuvent pas être sur la même diagonale */
    forall (j,k in d: j < k) {
        abs(j - k) != abs(t[j] - t[k]);
    }
	
}

/*** Post-traitement  ***/
// TODO

execute {
    writeln("Solution :");
    for (i in d) {
        write("  ");
        for (j in d) {
            if (t[j] == i){
                write("x ");
            } else {
                write("_ ");
            }
        }
        writeln();
    }
}