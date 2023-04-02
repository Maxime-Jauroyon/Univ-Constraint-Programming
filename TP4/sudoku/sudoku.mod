
/**************************************************************
 * Modèle pour le problème du sudoku nxn
 * (à inclure dans  un modèle contenant le l'entête "using CP;" + paramétrage du solveur
 **************************************************************/
using CP;

// --- Données ---
int n = ...	;						// square order
range rsud = 1..n;
int instance[rsud][rsud] = ...;


// --- Pretraitement ---
// A FAIRE
int submatrix_length = ftoi(sqrt(n));

execute {
    cp.param.logVerbosity = "Quiet";
    /* recherche en profondeur et pas de parallélisme */
    cp.param.searchType = "DepthFirst";
    cp.param.workers = 1;
}

// --- Modèle ---
// A FAIRE
dvar int sudoku[rsud][rsud] in rsud;

constraints{

    // correspondance avec l'instance
    forall(x,y in rsud : instance[x][y] > 0) {
        sudoku[x][y] == instance[x][y];
    }

    // difference sur les lignes et colonnes 
    forall(x in rsud){
        allDifferent(all (y in rsud) sudoku[x][y]);
    }
    forall(y in rsud){
        allDifferent(all (x in rsud) sudoku[x][y]);
    }

    // difference sur les matrices
    forall(x,y in rsud : (x % submatrix_length) == 1 && (y % submatrix_length) == 1){
        allDifferent(all (i,j in 0..submatrix_length-1) sudoku[x+i][y+j]);
    }

}


// --- Main (pour trouver toutes les solution + statistiques) ---
// A FAIRE
main {
    thisOplModel.generate();
    cp.startNewSearch();
    var compteur = 0;
    while (cp.next()) {
        if (compteur > 0) {
            writeln("--------------------------------------------------");
        
        }
        writeln("Solution ", compteur, " : ");
        writeln("Solving time : ",cp.info.solveTime)
        writeln("Number of fails : ",cp.info.numberOfFails)
        thisOplModel.postProcess();
        compteur++;
    }
    writeln("Nombre de solutions : ", compteur);
}

// --- PostTraitement --- (affichage solution)
// A FAIRE
execute {
    writeln(" Solution :");
    write("       ");
    writeln(sudoku);
}
