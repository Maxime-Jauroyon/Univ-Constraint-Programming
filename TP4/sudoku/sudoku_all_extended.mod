/**************************************************************
 * Modèle pour le problème du sudoku n x n
 * Propagation avancée avec la contrainte globale allDifferent
 **************************************************************/
using CP;

// --- Parametrage Solveur + niveau d'inférence alldiff---
// A FAIRE
execute {
    cp.param.allDiffInferenceLevel = "Extended";
}

// --- Modèle ---
include "sudoku.mod";

// --- Main (pour trouver toutes les solutions + statistiques) ---
// A INCLURE

