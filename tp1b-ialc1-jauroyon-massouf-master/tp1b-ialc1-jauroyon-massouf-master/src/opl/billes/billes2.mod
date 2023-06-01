/*********************************************
 * Modèle OPL Pour le problème des billes
 *
 * Utiliser un (ou plusieurs) tableau(x) afin de regrouper les variables
 * dans des structures adéquates.
 * Cela doit permettre de simplifier l'énoncé de certaines contraintes
 * ainsi que l'affichage de la solution.
 *
 * Binôme :  TP1B Maxime, Philippe
 *
 *********************************************/
using CP;			/* Utilisation du solveur CP-Solver */

/* Déclarations domaines et variables */
// TODO

/* domaine représentant les ages*/
range da = 4..7;

/* variables */
tuple Individu{
    string nom;
    string sexe;
}

{Individu} prenoms = {<"Anne","F">, <"Bernard","H">, <"Claudine","F">, <"Denis","H">};
{string} couleurs = {"Bleue", "Jaune", "Noire", "Rouge"};
{string} lieux = {"Parc", "Jardin", "Chambre", "Salon"};

dvar int prenom[prenoms] in da;
dvar int couleur[couleurs] in da;
dvar int lieu[lieux] in da;

/*  prenom[<'Anne', 'F'>]= 7 signifie "Anne a 7 ans" 
    couleur['Bleue'] = 7 signifie "L'enfant qui joue avec les billes bleues a 7 ans" 
    lieu['Parc']= 7 signifie "L'enfant qui joue dans le parc a 7 ans" */


/* Paramétrage du solveur */
// TODO 

execute {
    /* recherche en profondeur et pas de parallélisme */
    cp.param.searchType = "DepthFirst";
    cp.param.workers = 1;
}


/* Contraintes */
// TODO 

constraints {

    /* Contrainte de différences (ayant tous un âge différent) */
    
    forall (i,j in prenoms: i.nom != j.nom && i.sexe != j.sexe) {
        prenom[i] != prenom[j];
    }
    forall (i,j in couleurs: i != j) {
        couleur[i] != couleur[j];
    }
    forall (i,j in lieux: i != j) {
        lieu[i] != lieu[j];
    }

    /* Denis joue dans le parc et n’a pas 4 ans, contrairement à l’enfant qui a des billes bleues. */
    prenom[<"Denis","H">] == lieu["Parc"];
    prenom[<"Denis","H">] != 4;
    couleur["Bleue"] != lieu["Parc"];
    couleur["Bleue"] == 4;

    /* La fille de 6 ans a des billes jaunes. */
    couleur["Jaune"] == 6;
    forall(i in prenoms: i.sexe == "H"){
        prenom[i] != 6;
    }

    /* L’enfant qui joue avec des billes noires est plus âgé que l’enfant qui joue dans le jardin mais plus jeune que Anne. */
    couleur["Noire"] > lieu["Jardin"];
    couleur["Noire"] < prenom[<"Anne","F">];

    /* Anne, qui joue dans sa chambre, a 1 an de plus que l’enfant qui joue dans le salon. */
    prenom[<"Anne","F">] == lieu["Chambre"];
    prenom[<"Anne","F">] == (1 + lieu["Salon"]);

}

/* Post-traitement (Affichage Solution) */
// TODO 

execute {
    /* affichage de la solution trouvé */
    writeln("Solution : ");
    for(i in prenoms){
        writeln(i.nom, " = ", prenom[i]);
    }
    for(i in couleurs){
        writeln(i, " = ", couleur[i]);
    }
    for(i in lieux){
        writeln(i, " = ", lieu[i]);
    }

}
