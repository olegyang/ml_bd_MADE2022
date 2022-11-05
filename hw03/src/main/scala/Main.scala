import utils.io_preparator
import utils.LinearRegression

object Main {
  def main(args: Array[String]): Unit = {
    // path to data
    val (targetPath, dataPath, outPath) = (args(0), args(1), args(2))
    // hyperparameters
    val (nIter, learningRate) = (args(3).toInt, args(4).toDouble)
    // declare classes
    val (io_preparator, model) = (new io_preparator, new LinearRegression)

    // main pipeline: get data, fit & predict
    val (xTrain, yTrain, xTest, yTest) = io_preparator.readAndSplit(dataPath, targetPath)
    println(s"Successfully read and split data, ${xTrain.rows + xTest.rows} rows, ${xTrain.cols} columns")
    val (weights, bias) = model.fit(xTrain, yTrain, nIter, learningRate)
    println(s"Linear Regression fitted. \nweights: ${weights} \nbias: ${bias}")
    val yPred = model.predict(xTest, weights, bias)
    println(s"Got predictions. RMSE on validation dataset: ${model.RMSE(yTest, yPred)}")
    io_preparator.writePredictions(yPred, outPath)
    println(s"All done. Predictions are saved to: ${outPath}")
  }
}