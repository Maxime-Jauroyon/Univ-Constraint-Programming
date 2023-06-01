/*********************************************
 * Modèle pour le problème du carré magique
 *
 * Les données de l'instance sont décrites dans un fichier .dat externe
 *
 * Binôme :   TP1B Maxime, Philippe
 *
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

dexpr int s_diag_1 = sum (i in n) t[i][i];

dexpr int s_diag_2 = sum (i in n) t[i][a-i+1];


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

    s_diag_1 == s_diag_2;

    /* les sommes des éléments situés sur chaque ligne sont toutes identiques aux sommes des diagonales */

    forall(i in n){
        (sum (j in n) t[i][j]) == s_diag_1;
    }

    /* les sommes des éléments situés sur chaque colonne sont toutes identiques aux sommes des diagonales */
    
    forall(j in n){
        (sum (i in n) t[i][j]) == s_diag_1;
    }


}


//----- Post-traitement -----
// TODO

execute {
    writeln("Solution :");
    writeln("       ", t);

}



