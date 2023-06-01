/*********************************************
 * OPL 22.1.1.0 Model
 * Author: maxim
 * Creation Date: 7 mars 2023 at 16:57:23
 *********************************************/

execute{
    var f = cp.factory;
    cp.setSearchPhases(
    	f.searchPhase(t,
    				  f.selectSmallest(f.varIndex(t)),
    				  f.selectSmallest(f.value())
    	)
    );
}