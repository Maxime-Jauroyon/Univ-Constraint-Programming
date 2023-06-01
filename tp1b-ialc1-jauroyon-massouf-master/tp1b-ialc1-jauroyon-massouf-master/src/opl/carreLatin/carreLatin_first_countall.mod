/*********************************************
 * Modèle pour le problème du carré latin
 *
 * Affiche uniquement la première solution trouvée
 * ainsi que le nombre total de solutions.
 *
 * Binôme :   TP1B Maxime, Philippe
 *
*********************************************/
using CP;

/*** Données du problème  ***/
// TODO

/*** Variables et domaines  ***/
// TODO

range d = 1..4;
dvar int t[d, d] in d; // t[2][1] = 1 signifie "a la case de ligne 2 et la colonne 1 on trouve la valeur 1" */


/* Paramétrage du solveur */
// TODO 

execute {

    cp.param.logVerbosity = "Quiet";
  
    
}
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

/*** Contrôle de flux  ***/
// TODO

include "../shared/displayFirstAndCountSolutions.mod";

/*** Post-traitement  ***/
// TODO

execute {
    writeln("Solution :");
    writeln("       ", t);

}