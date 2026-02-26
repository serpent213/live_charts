import Config

if Mix.env() == :dev do
  esbuild = fn entrypoint, args ->
    [
      args: [entrypoint, "--bundle"] ++ args,
      cd: Path.expand("../assets", __DIR__),
      env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
    ]
  end

  config :esbuild,
    version: "0.17.11",
    module:
      esbuild.(
        "./js/live_charts",
        ~w(--format=esm --sourcemap --outfile=../priv/static/live_charts.esm.js)
      ),
    main:
      esbuild.(
        "./js/live_charts",
        ~w(--format=cjs --sourcemap --outfile=../priv/static/live_charts.cjs.js)
      ),
    apex_module:
      esbuild.(
        "./js/live_charts.apex",
        ~w(--format=esm --sourcemap --outfile=../priv/static/live_charts.apex.esm.js)
      ),
    apex_main:
      esbuild.(
        "./js/live_charts.apex",
        ~w(--format=cjs --sourcemap --outfile=../priv/static/live_charts.apex.cjs.js)
      ),
    echarts_module:
      esbuild.(
        "./js/live_charts.echarts",
        ~w(--format=esm --sourcemap --outfile=../priv/static/live_charts.echarts.esm.js)
      ),
    echarts_main:
      esbuild.(
        "./js/live_charts.echarts",
        ~w(--format=cjs --sourcemap --outfile=../priv/static/live_charts.echarts.cjs.js)
      ),
    cdn:
      esbuild.(
        "./js/live_charts",
        ~w(--format=iife --target=es2016 --global-name=LiveCharts --outfile=../priv/static/live_charts.js)
      ),
    cdn_min:
      esbuild.(
        "./js/live_charts",
        ~w(--format=iife --target=es2016 --global-name=LiveCharts --minify --outfile=../priv/static/live_charts.min.js)
      )
end
