var webpack = require("webpack");

module.exports = {
  entry: './webapp/main/index.js',
  output: {
    path: __dirname + '/src/main/webapp/',
    filename: 'bundle.js'
  },
  devtool: 'eval',
  debug: true,
  module: {
    preLoaders: [
      {
        test: /\.tag$/,
        exclude: /node_modules/,
        loader: 'riotjs-loader',
        query: {
          type: 'babel'
        }
      }
    ],
    loaders: [
      {
        test: /\.js$|\.tag$/,
        exclude: /node_modules/,
        loader: 'babel-loader'
      }
    ]
  },
  resolve: {
    extensions: ['', '.js', '.tag']
  },
  plugins: [
    new webpack.optimize.UglifyJsPlugin()
  ]
}
