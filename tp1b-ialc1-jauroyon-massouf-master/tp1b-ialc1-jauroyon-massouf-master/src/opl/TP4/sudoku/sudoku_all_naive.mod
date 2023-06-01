
/**************************************************************
 * Modèle pour le problème du sudoku nxn
 * Modèle naif
 **************************************************************/
using CP;

// --- Parametrage Solveur ---
// A FAIRE
execute {
    cp.param.allDiffInferenceLevel = "Basic";
}

// --- Modèle ---
include "sudoku.mod";

// --- Main (pour trouver toutes les solutions + statistiques) ---
// A INCLURE

