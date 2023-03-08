/*********************************************
 * OPL 22.1.1.0 Model
 * Author: maxim
 * Creation Date: 7 mars 2023 at 16:48:46
 *********************************************/
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