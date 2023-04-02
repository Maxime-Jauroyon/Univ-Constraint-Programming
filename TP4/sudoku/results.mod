using CP;


{string} models = {"sudoku_all_naive.mod","sudoku_all_extended.mod"};
{string} instances = {"sudoku99.1.dat","sudoku99.2.dat","sudoku99.3.dat","sudoku99.4.dat","sudoku99.5.dat","sudoku99.6.dat","sudoku99.7.dat","sudoku99.8.dat","sudoku99.9.dat","sudoku99.10.dat","sudoku1616.1.dat"};
string repertoire = "instances/";



main {

    write("                      ")

    for (var m in thisOplModel.models){
        write(m, "      |      ")
    }

    writeln()


    for (var i in thisOplModel.instances){
        write(i);

        for (var m in thisOplModel.models){
            write("      |        ")

            var mainSrc = new IloOplModelSource(m);
            var mainModel = new IloOplModelDefinition(mainSrc);

            var mainCp = new IloCP();
            var mainOpl = new IloOplModel(mainModel,mainCp);

            var mainData = new IloOplDataSource(thisOplModel.repertoire+i);
            mainOpl.addDataSource(mainData);

            mainOpl.generate();
            mainCp.startNewSearch();
            // var totalSolveTime;
            // var totalNumberOfFail;
            while (mainCp.next()) {
                // totalSolveTime += mainCp.info.solveTime;
                // totalNumberOfFail += mainCp.info.numberOfFails;
                write(mainCp.info.solveTime," s, ",mainCp.info.numberOfFails," f")
            }
            // write(totalSolveTime," s, ",totalNumberOfFail," f")

            mainCp.endSearch();
            mainCp.clearModel();
            mainOpl.end();
            mainData.end();

        }

        writeln()

    }
    
}