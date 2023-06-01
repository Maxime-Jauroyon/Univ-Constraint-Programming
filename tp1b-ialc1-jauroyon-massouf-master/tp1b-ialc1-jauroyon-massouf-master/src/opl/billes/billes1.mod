/*********************************************
 * Modèle OPL Pour le problème des billes
 *
 * Dans ce modèle; chaque variable doit être déclarée explicitement
 * avec son nom d'origine dans le modèle initial
 *
 *********************************************/
using CP;			/* Utilisation du solveur CP-Solver */

/* Déclarations domaines et variables */
range ages = 4..7;
dvar int Anne in ages;
dvar int Bernard in ages;
dvar int Claudine in ages;
dvar int Denis in ages;
dvar int Bleue in ages;
dvar int Jaune in ages;
dvar int Noire in ages;
dvar int Rouge in ages;
dvar int Parc in ages;
dvar int Jardin in ages;
dvar int Chambre in ages;
dvar int Salon in ages;

/* Anne = 7 signifie "Anne a 7 ans" 
   Bleue = 7 signifie "L'enfant qui joue avec les billes bleues a 7 ans" 
   Parc = 7 signifie "L'enfant qui joue dans le parc a 7 ans" */

   
/* Paramétrage du solveur */
execute {
    cp.param.searchType="DepthFirst";
    cp.param.workers=1;
}

/* Contraintes */
constraints {

    /* Contrainte de différences (ayant tous un âge différent) */
    Anne != Bernard; 
    Anne != Claudine; 
    Anne != Denis; 
    Bernard != Claudine;
    Bernard != Denis;
    Claudine != Denis;
    Bleue != Jaune; 
    Bleue != Noire; 
    Bleue != Rouge; 
    Jaune != Noire; 
    Jaune != Rouge; 
    Noire != Rouge;
    Parc != Jardin;
    Parc != Chambre;
    Parc != Salon;
    Jardin != Chambre;
    Jardin != Salon;
    Chambre != Salon;

    /* Denis joue dans le parc et n’a pas 4 ans, contrairement à l’enfant qui a des billes bleues. */

    Denis == Parc; 
    Denis != 4; 
    Bleue != Parc; 
    Bleue == 4;
    /* La fille de 6 ans a des billes jaunes. */

    Jaune == 6; 
    Denis != 6; 
    Bernard != 6;

    /* L’enfant qui joue avec des billes noires est plus âgé que l’enfant qui joue dans le jardin mais plus jeune que Anne. */

    Noire > Jardin;
    Noire < Anne;
    /* Anne, qui joue dans sa chambre, a 1 an de plus que l’enfant qui joue dans le salon. */

    Anne == Chambre;  
    Anne == (1 + Salon);
}
/* Post-traitement (Affichage Solution) */
// TODO 

execute {
    /* affichage de la solution trouvé */
    writeln("Solution : ");
    writeln("Anne = ", Anne);
    writeln("Bernard = ", Bernard);
    writeln("Claudine = ", Claudine);
    writeln("Denis = ", Denis);
    writeln("Bleue = ", Bleue);
    writeln("Jaune = ", Jaune);
    writeln("Noire = ", Noire);
    writeln("Rouge = ", Rouge);
    writeln("Parc = ", Parc);
    writeln("Jardin = ", Jardin);
    writeln("Chambre = ", Chambre);
    writeln("Salon = ", Salon);
}



