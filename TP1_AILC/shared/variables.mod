/*********************************************
 * OPL 22.1.1.0 Model
 * Author: maxim
 * Creation Date: 7 mars 2023 at 16:48:29
 *********************************************/
/*** Données du problème  ***/
// TODO

/*** Variables et domaines  ***/
// TODO

int number_of_queen = ...;
range d = 1..number_of_queen; // Domaine des variables
dvar int t[d] in d; /*  t[2] = 3 signifie "dans la colonne 2 on trouve la reine a la ligne 3" */