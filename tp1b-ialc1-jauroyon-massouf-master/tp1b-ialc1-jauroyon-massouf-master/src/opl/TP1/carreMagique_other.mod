/*********************************************
 * OPL 22.1.1.0 Model
 * Author: maxim
 * Creation Date: 12 mars 2023 at 22:17:30
 *********************************************/
using CP;

//----- Parametrage Solveur -----
// TODO

execute {

    cp.param.logVerbosity = "Quiet";
}


//----- Données du problème -----
// TODO

int a = ...;
int a2 = a*a;

//----- Variables et domaines -----
// TODO

range n = 1..a; // longueur d'un côté
range d = 1..a2; //domaine
dvar int t[n, n] in d; // t[2][1] = 1 signifie "a la case de ligne 2 et la colonne 1 on trouve la valeur 1" */

//----- Contraintes -----
// TODO

/* les sommes des éléments situés sur chacune des deux diagonales du carré */

int s = ftoi(a*(a2+1)/2);

/*** Pre-traitement  ***/
// TODO
include "shared/other_carreMagique.mod";

constraints {
    /* chaque case contient un entier compris entre 1 et n^2. */
	
    forall (i in n) {
        forall (j in n) {
            forall (h in n) {
                forall (k in n) {
                    if(i != h || j != k){
                        t[i][j] != t[h][k];
                    }    
                }
            }
        }
    }

    

    /* les sommes des éléments situés sur chacune des deux diagonales du carré sont identiques */

    (sum (i in n) t[i][i]) == s;

    (sum (i in n) t[i][a-i+1]) == s;

    /* les sommes des éléments situés sur chaque ligne sont toutes identiques aux sommes des diagonales */

    forall(i in n){
        (sum (j in n) t[i][j]) == s;
    }

    /* les sommes des éléments situés sur chaque colonne sont toutes identiques aux sommes des diagonales */
    
    forall(j in n){
        (sum (i in n) t[i][j]) == s;
    }


}


//----- Post-traitement -----
// TODO

execute {
    writeln("Solution :");
    writeln("       ", t);

}

include "shared/stat.mod";