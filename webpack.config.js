const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const HtmlWebpackInjectPlugin = require("html-webpack-inject-plugin").default;
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const CssMinimizerPlugin = require("css-minimizer-webpack-plugin");
const TerserPlugin = require("terser-webpack-plugin");
const webpack = require("webpack");
const Dotenv = require("dotenv-webpack");

// const CopyPlugin = require("copy-webpack-plugin");

const MetaTags = { author: "Alexandr Selunin; selunin@dev.vtb.ru" };

module.exports = (env, argv) => ({
  context: __dirname + "/develop",
  target: "web",
  watchOptions: {
    poll: true,
  },
  devServer: {
    static: ".public/",
    historyApiFallback: {
      rewrites: [
        {
          from: /.*/,
          to: function (context) {
            return context.parsedUrl.pathname.match(/\.\w+$/)
              ? context.parsedUrl.pathname.replace(process.env.BASE_PATH, "/")
              : "/index.html";
          },
        },
      ],
    },
  },
  performance: {
    maxEntrypointSize: 3_145_728,
    maxAssetSize: 6_291_456,
  },
  plugins: [
    process.env.npm_lifecycle_event === "build"
      ? new Dotenv()
      : new webpack.DefinePlugin({
          "process.env": JSON.stringify({
            ...argv,
            ...Object.fromEntries(
              Object.entries(process.env).filter((item) =>
                item[0].match(/^[A-Z]/)
              )
            ),
          }),
        }),
    new HtmlWebpackPlugin({
      title: "Админ панель kod-admin-ui",
      favicon: "./favicon.ico",
      scriptLoading: "defer",
      base: process.env.BASE_PATH,
      minify: false,
      meta: Object.assign(
        { viewport: "width=device-width, initial-scale=1, shrink-to-fit=no" },
        MetaTags
      ),
    }),
    new HtmlWebpackPlugin({
      filename: "404.html",
      template: "./404.html",
      base: process.env.BASE_PATH,
      minify: false,
      inject: false,
    }),
    new MiniCssExtractPlugin({ filename: "styleshets/main.css" }),
    new webpack.SourceMapDevToolPlugin(),
    process.env.npm_lifecycle_event === "build" &&
      new HtmlWebpackInjectPlugin({
        externals: [
          {
            tagName: "script",
            attributes: {
              src: "javascripts/pseudoenv.js",
              type: "text/javascript",
            },
          },
        ],
        prepend: true,
      }),
  ].filter(Boolean),
  optimization: {
    mangleWasmImports: true,
    moduleIds: "deterministic",
    minimize: process.env.npm_lifecycle_event === "build",
    minimizer: [
      new CssMinimizerPlugin({
        minimizerOptions: {
          preset: ["default", { discardComments: { removeAll: true } }],
        },
      }),
      new TerserPlugin({ parallel: true }),
    ],
  },
  module: {
    rules: [
      {
        test: /\.md|\.html$/,
        type: "asset/source",
      },
      {
        test: /\.json$/,
        type: "asset/source",
      },
      {
        test: /\.m?js$/,
        exclude: /(node_modules|bower_components|javascripts)/,
        use: {
          loader: "babel-loader",
          options: {
            presets: ["@babel/preset-env"],
          },
        },
      },
      {
        test: /pseudoenv.js/i,
        type: "asset/resource",
      },
      {
        test: /fonts.+\.(woff(2)?|ttf|sfd|eot|svg|otf)([?#]+\w+)?$/,
        exclude: [__dirname + "/node_modules"],
        type: "asset/resource",
      },
      {
        test: /\.(jpe?g|png|gif|svg|ico)$/,
        type: "asset/source",
      },
      {
	test: /\.(jpe?g|png|gif|svg|ico)$/,
        resourceQuery: { not: [/source/] },
        type: "asset/resource",
      },
      {
        test: /\.styl$/i,
        use: [
          {
            loader: "source-map-loader",
          },
          {
            loader: MiniCssExtractPlugin.loader,
          },
          { loader: "css-loader", options: { sourceMap: true } },
          {
            loader: "postcss-loader",
            options: {
              postcssOptions: { plugins: ["postcss-preset-env"] },
              sourceMap: true,
            },
          },
          { loader: "stylus-loader", options: { sourceMap: true } },
        ],
      },
      {
        test: /\.css$/,
        use: [
          {
            loader: "source-map-loader",
          },
          {
            loader: MiniCssExtractPlugin.loader,
          },
          { loader: "css-loader", options: { sourceMap: true } },
          {
            loader: "postcss-loader",
            options: {
              postcssOptions: { plugins: ["postcss-preset-env"] },
              sourceMap: true,
            },
          },
        ],
      },
      {
        test: /\.imba$/,
        loader: "imba/loader",
      },
    ],
  },
  resolve: {
    alias: {
      path: require.resolve("path-browserify"),
    },
    modules: ["node_modules"],
    extensions: [".imba", ".js", ".json"],
    mainFiles: ["index"],
  },
  entry: "./index.imba",
  output: {
    path: __dirname + "/public",
    filename: "javascripts/application.js",
    assetModuleFilename: "assets/[hash][ext][query]",
  },
});
