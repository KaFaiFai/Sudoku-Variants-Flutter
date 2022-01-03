import '../dao/sudoku_puzzle_dao.dart';
import '../model/sudoku_puzzle.dart';
import '../model/sudoku_variation.dart';

class SudokuPuzzleRepository {
  final sudokuPuzzleDao = SudokuPuzzleDao();

  Future getAll({SudokuVariation? variation}) =>
      sudokuPuzzleDao.getAllPuzzles(variation: variation);

  Future insert(SudokuPuzzle puzzle) => sudokuPuzzleDao.create(puzzle);

  Future update(SudokuPuzzle puzzle) => sudokuPuzzleDao.update(puzzle);

  Future deleteById(int id) => sudokuPuzzleDao.delete(id);
}
