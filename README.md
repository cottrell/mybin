# mybin

Notes, links, scripts, memories, recommendations, ghosts etc.

state:
* `did` chron log
* latex notes.tex -> notes.pdf math
* mybin/README.me dumping ground
* github notebooks sandbox code

shadow state:
* Google Keep
* misc bookmark collections in chrome
* misc spread sheets


[See here to regenerate the TOC](https://github.com/Chris3606/TOC-Generator.git)

<!--ts-->
* [mybin](#mybin)
    * [Managing notes, ideas, search](#managing-notes-ideas-search)
    * [services and tools for business and productivity](#services-and-tools-for-business-and-productivity)
    * [finance/markets/trading](#financemarketstrading)
        * [Bregman etc](#bregman-etc)
    * [causal inference, causal graphs, probabilistic programming](#causal-inference-causal-graphs-probabilistic-programming)
    * [people](#people)
    * [clustering, record linkage etc](#clustering-record-linkage-etc)
    * [backtesting/trading tools](#backtestingtrading-tools)
    * [Top candidates for generic analytics and viz](#top-candidates-for-generic-analytics-and-viz)
    * [Decentralized data networks?](#decentralized-data-networks)
    * [platforms](#platforms)
        * [Dataframes, data ingestion](#dataframes-data-ingestion)
        * [Research:](#research)
        * [Analytics/Viz:](#analyticsviz)
            * [Other lists](#other-lists)
            * [js dataframes](#js-dataframes)
        * [Viz for larger datasets and graphs](#viz-for-larger-datasets-and-graphs)
        * [Other](#other)
        * [Data exploration](#data-exploration)
    * [Actual data & viz](#actual-data--viz)
        * [Markets](#markets)
        * [Non-Markets](#non-markets)
    * [Tech env](#tech-env)
    * [task queues](#task-queues)
    * [decentralized finance whatever that means](#decentralized-finance-whatever-that-means)
    * [prediction markets](#prediction-markets)
    * [Interesting protocols](#interesting-protocols)
    * [decentralized data, research, distributed fs, syncing, data versioning etc](#decentralized-data-research-distributed-fs-syncing-data-versioning-etc)
        * [RPC/caching/dataframe Frameworks like dask and spark](#rpccachingdataframe-frameworks-like-dask-and-spark)
    * [bitemporal stuff](#bitemporal-stuff)
    * [Time Series DB analytics etc](#time-series-db-analytics-etc)
    * [Immutable db etc](#immutable-db-etc)
    * [stream processing etc](#stream-processing-etc)
    * [merkle tree](#merkle-tree)
    * [merkle db](#merkle-db)
    * [workflow, dag stuff etc](#workflow-dag-stuff-etc)
    * [data pipelines, streaming etc](#data-pipelines-streaming-etc)
    * [data quality](#data-quality)
    * [hardware](#hardware)
    * [privacy, security etc](#privacy-security-etc)
    * [links uncategorized](#links-uncategorized)
    * [maths, probability, stochastic etc](#maths-probability-stochastic-etc)
    * [feature stores](#feature-stores)
    * [ml, machine learning, rl, reinforcement learning](#ml-machine-learning-rl-reinforcement-learning)
    * [dimensional analysis](#dimensional-analysis)
        * [sequence learning related](#sequence-learning-related)
        * [simulators](#simulators)
        * [factorization machines](#factorization-machines)
        * [distributed algos](#distributed-algos)
        * [nearest neighbor](#nearest-neighbor)
        * [Normalizing Flows and Density Estimation](#normalizing-flows-and-density-estimation)
        * [mixture density network links](#mixture-density-network-links)
        * [lstm/rnn examples](#lstmrnn-examples)
        * [hyper param opt](#hyper-param-opt)
            * [other lists](#other-lists-1)
        * [ml/rl environments](#mlrl-environments)
        * [GP](#gp)
        * [CV exploratory approaches](#cv-exploratory-approaches)
        * [sum product](#sum-product)
        * [custom objectives](#custom-objectives)
    * [hardware](#hardware-1)
    * [tax, spending, fiscal, gov etc](#tax-spending-fiscal-gov-etc)
    * [APIs](#apis)
    * [travel](#travel)
    * [engineering](#engineering)
    * [maybe useful libs to watch](#maybe-useful-libs-to-watch)
    * [historical](#historical)
    * [browser](#browser)
    * [web](#web)
    * [coursera](#coursera)
    * [DB and analytics](#db-and-analytics)
        * [object stores](#object-stores)
    * [messaging](#messaging)
* [data discovery and meta data etc](#data-discovery-and-meta-data-etc)
    * [semantic web and things I tend to ignore](#semantic-web-and-things-i-tend-to-ignore)
        * [Semantic web search engines?](#semantic-web-search-engines)
    * [articles and data](#articles-and-data)
    * [language data (dictionaries etc)](#language-data-dictionaries-etc)
    * [todo](#todo)
    * [GPG etc](#gpg-etc)
    * [drone](#drone)
    * [Concurrency](#concurrency)
* [Monoclonal Antibodies](#monoclonal-antibodies)
* [Alternatives to medium](#alternatives-to-medium)
* [Automated Theorem Proving](#automated-theorem-proving)
* [stack 2020](#stack-2020)
* [voting](#voting)
* [fast distance matrix calculations](#fast-distance-matrix-calculations)
<!--te-->

## Managing notes, ideas, search

* https://github.com/nikitavoloboev/alfred-my-mind (search)
* https://my.mindnode.com/
* https://www.mindnode.com/
* https://www.notion.so/
* https://www.2doapp.com/

## services and tools for business and productivity

Start with this list: https://github.com/cjbarber/ToolsOfTheTrade

Tech

* https://www.infoq.com/presentations/lmax-trading-architecture/
* lstopo
* https://code.tools/man/1/cset-set/
* https://medium.com/mvp-workshop/a-closer-look-to-the-inter-planetary-file-system-b3f3af31a3c7

hft, markets

* http://orion.towson.edu/~karne/teaching/projdb2/stockdata.pdf
* https://github.com/OpenHFT/Chronicle-Queue#design Micro second messaging that stores everything to disk

Key value store:

* https://blog.dgraph.io/post/badger/

Misc

* https://github.com/PyO3/rust-numpy
* proxy: https://askubuntu.com/questions/112177/how-do-i-tunnel-and-browse-the-server-webpage-on-my-laptop
* blackrock is involved in this: https://argoproj.github.io/argo
* https://gogs.io/ git service self hosted
* https://www.turaku.com/why

Time tracking:

* https://www.toggl.com/
* https://demo.kimai.org/
* https://clockify.me/tracker

## finance/markets/trading

Misc quant projects

* https://github.com/jindaxiang/akshare/tree/master/akshare
* https://github.com/wilsonfreitas/awesome-quant#python
* https://github.com/cuemacro/findatapy
* https://github.com/foolcage/fooltrader

Stochastic, math fin etc

* websim by worldquant https://onlinelibrary.wiley.com/doi/abs/10.1002/9781119571278.ch31
* https://www.math.nyu.edu/faculty/goodman/teaching/StochCalc2012/notes/Week4.pdf
* https://wwwf.imperial.ac.uk/~ajacquie/index_files/GHJ%20-%20SABRGeometry.pdf
* https://www.stat.berkeley.edu/~aldous/205B/pitman_yor_guide_bm.pdf
* file:///home/cottrell/Downloads/risks-05-00061-v2%20(1).pdf
* http://www.eco.uc3m.es/~mkredler/ContTime/5ExitTimes.pdf
* https://www.newyorkfed.org/medialibrary/media/research/staff_reports/sr677.pdf
* realized vol options etc https://pdfs.semanticscholar.org/c092/c65551a77339c952becf8ccc93a13c98ece0.pdf

Brokers or MD providers with reasonable apis

* IB (Interactive Brokers)
* Saxo
* darwinex (name I can never remember)
* deribit
* alpaca?
* alphavantage?
* quantitativebrokers?


Trading, securities etc

* [entropy trading volumes futures](https://quantitativebrokers.com/wp-content/uploads/2017/05/entropy.pdf)
* [securitization process](http://www.accountingnotes.net/financial-management/debt-securitization/debt-securitization-meaning-and-process-financial-management/10920)
* [KG loans and shipping](https://www.tankershipping.com/news/view,german-tanker-operators-and-the-new-normal-of-mergers-and-acquisitions_53443.htm)

mulitcharts info

fx is free but other feeds are through your broker or other data provider. See below for supported lists.

* https://www.multicharts.com/features/brokers/
* https://www.multicharts.com/features/data-feeds/
* https://www.multicharts.com/trading-software/index.php/Supported_security_types


Regs for payment systems and retail bank-like entities (revolute):

* [The Electronic Money Regulations 2011](http://www.legislation.gov.uk/uksi/2011/99/contents/made)
* [The Payment Services Regulations 2009](http://www.legislation.gov.uk/uksi/2009/209/contents/made)


Elicitability, Quantiles, Expectiles etc

* https://freakonometrics.hypotheses.org/files/2017/05/erasmus-1.pdf

### Bregman etc

* http://gcoe-mi.jp/temp/publish/3d079baa66570bfabd11590a3c20ff34.pdf
* http://reports-archive.adm.cs.cmu.edu/anon/2001/CMU-CS-01-109R.pdf
* http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.135.1357&rep=rep1&type=pdf
* https://github.com/RagibZaman/mathematical-optimisation/blob/master/bregman_optimisation/bregman_optimisation.pdf
* https://arxiv.org/abs/1004.3814
* https://github.com/RagibZaman/mathematical-optimisation/tree/master/bregman_optimisation/BregmanLR_demo
* https://people.ok.ubc.ca/bauschke/Research/07.pdf
* http://www.cs.jhu.edu/~ayuille/courses/Stat238-Winter12/Pietra.pdf
* http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.33.1529&rep=rep1&type=pdf
* https://www.aclweb.org/anthology/J96-1002.pdf
* https://arxiv.org/abs/1905.11545
* https://arxiv.org/pdf/1808.08271.pdf
* https://www.inference.vc/grosses-challenge/
* https://github.com/fhuszar/thesis/tree/master/submitted

Same thing but copy pastable into "Copy All URLs for Google Chrome" app:

    http://gcoe-mi.jp/temp/publish/3d079baa66570bfabd11590a3c20ff34.pdf
    http://reports-archive.adm.cs.cmu.edu/anon/2001/CMU-CS-01-109R.pdf
    http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.135.1357&rep=rep1&type=pdf
    https://github.com/RagibZaman/mathematical-optimisation/blob/master/bregman_optimisation/bregman_optimisation.pdf
    https://arxiv.org/abs/1004.3814
    https://github.com/RagibZaman/mathematical-optimisation/tree/master/bregman_optimisation/BregmanLR_demo
    https://people.ok.ubc.ca/bauschke/Research/07.pdf
    http://www.cs.jhu.edu/~ayuille/courses/Stat238-Winter12/Pietra.pdf
    http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.33.1529&rep=rep1&type=pdf
    https://www.aclweb.org/anthology/J96-1002.pdf
    https://arxiv.org/abs/1905.11545
    https://arxiv.org/pdf/1808.08271.pdf
    https://www.inference.vc/grosses-challenge/
    https://github.com/fhuszar/thesis/tree/master/submitted

## causal inference, causal graphs, probabilistic programming

NOTE on D-separation:
    X is d-separated from Y given Z (in G) iff all undirected paths between X and Y are inactive relative to Z.
    An undirected path is inactive relative to Z iff ANY (at least one) node on the path is inactive relative to Z.
    A node is inactive relative to Z iff
        a) it is a non-collider in Z
        OR
        b) is a collider not in Z and has no descendents in Z

Strong ignorability says that, conditional on the confounders, the assigned causes are independent
of the potential outcomes,

Possibly good toolkits

* tensorflow.probability and pyro
* [Deep Probabilistic Programming](https://arxiv.org/pdf/1701.03757.pdf)
* https://github.com/bd2kccd/py-causal
* https://github.com/Diviyan-Kalainathan/CausalDiscoveryToolbox (has some graph search capabilities)
* https://github.com/akelleh/causality (has some graph search capabilities)
* https://github.com/Microsoft/dowhy
* https://www.ccd.pitt.edu/tools/

Other tools and articles

* [Causal Inference & Deep Learning, MIT IAP 2018](https://github.com/maxwshen/iap-cidl)
* [Comparison of strategies for scalable causal discovery of latent variable models from mixed data](https://link.springer.com/content/pdf/10.1007%2Fs41060-018-0104-3.pdf)
* [The Blessings of Multiple Causes](https://arxiv.org/pdf/1805.06826.pdf)
* HERE FOR DISCUSSION: http://www.alexdamour.com/blog/public/2018/05/18/non-identification-in-latent-confounder-models/
* https://github.com/ijmbarr/causalgraphicalmodels (no learning of graphs though so useless)
* http://www.phil.cmu.edu/projects/tetrad/ (painful and limited to categorical or linear I think)
* https://github.com/AMLab-Amsterdam/CEVAE
* "Counting and Uniform Sampling from Markov Equivalent DAGs"
* https://arxiv.org/abs/1806.00811v1 Causal infernece with noisy and missing covariates via matrix fact
* merging joing distributions via causal models: https://arxiv.org/abs/1804.03206
* https://medium.com/@akelleh/causal-inference-with-pandas-dataframes-fc3e64fce5d
* http://dagitty.net/
* https://www.youtube.com/channel/UCBWDYSwPbUMmRWZHuGJcJ5g

## people

* (blog uk house data) https://www.philiposbornedata.com/2018/03/07/uk-house-price-analysis-part-2/
* https://www.amazon.co.uk/Capital-Without-Borders-Managers-Percent/dp/0674743806 Brooke Harrington
* jason sharman https://www.economist.com/finance-and-economics/2009/03/26/haven-hypocrisy

## clustering, record linkage etc

* https://github.com/larisahax/awc
* https://github.com/shivam5992/dupandas
* https://github.com/RobinL/fuzzymatcher
* http://recordlinkage.readthedocs.io/en/latest/about.html

## backtesting/trading tools

* pyalgotrade
* zipline
* pyfolio
* backtrader

## Top candidates for generic analytics and viz

See this list https://wiki.nikitavoloboev.xyz/data-science/data-processing
* https://github.com/memgraph/memgraph

## Decentralized data networks?

Look at these 2022
* https://developers.ceramic.network/learn/welcome/
* https://timeflow.systems/

## platforms

* snowflake
* lakehouse
* azure ml
* qwak

### Dataframes, data ingestion

* https://pola-rs.github.io/polars-book/api-python/polars/io.html  compare to cylon?
* https://github.com/sfu-db/connector-x

### Research:

* https://github.com/iodide-project/pyodide/ (notebook in the browser! I mean it is *in* the browser)
* https://github.com/microsoft/tensorwatch (for training in notebooks)

### Analytics/Viz:

* https://echarts.apache.org/examples/en/editor.html?c=scatter3d-scatter&gl=1 ... kick the tires on this.
* https://dash.plot.ly plotly
* https://observablehq.com/@observablehq/plot ... is this one usable outside of observable?
* https://count.co/ ... another notebook style thing, worth checking out more.
* https://github.com/finos/perspective
* https://vega.github.io/
* https://github.com/tiangolo/fastapi (for backend)
* https://www.streamlit.io/
* https://pair-code.github.io/facets/
* https://github.com/uwdata/falcon brushing and linking
* https://robinhood.engineering/faust-stream-processing-for-python-a66d3a51212d (featuers)
* https://altair-viz.github.io/ (also built on vega and vega-lite)
* https://idl.cs.washington.edu/projects/lyra/
* holoviews based on bokeh. maybe easier within notebooks not sure
* superset
* https://github.com/metabase/metabase
* dtale (see the charts, I did not see before http://alphatechadmin.pythonanywhere.com/dtale/charts/4?chart_type=3d_scatter&query=&x=date&z=Col0&agg=raw&cpg=false&y=%5B%22security_id%22%5D )
* observable? Plot? https://observablehq.com/@observablehq/plot-marks some javascript notebook thing

vega observable related
* https://observablehq.com/@uwdata/introduction-to-vega-lite
* https://observablehq.com/collection/@vega/vega-lite-api
* https://observablehq.com/collection/@observablehq/observable-for-vega-lite
* https://vega.github.io/vega-lite-api/


#### Other lists

* https://danmackinlay.name/notebook/data_dashboards.html
* https://danmackinlay.name/notebook/plotting_in_python.html
* http://www.cssauthor.com/javascript-charting-libraries


#### js dataframes

2021-12: keep messing around with observable as it allows state caching notebook style. See here for "recommended" libraries https://observablehq.com/@observablehq/recommended-libraries

2021-05: If there is some fast serializing to danfo it looks good. Look for arrow danfo interactions. See arquero.

* danfo.js https://blog.tensorflow.org/2020/08/introducing-danfo-js-pandas-like-library-in-javascripbbt.html
* zebras https://observablehq.com/@cedrickchee/intro-to-zebras-python-pandas-for-javascript
* arquero https://observablehq.com/@uwdata/arquero-and-apache-arrow
* see this list: https://stackoverflow.com/questions/30610675/python-pandas-equivalent-in-javascript
* see this discussion https://github.com/apache/arrow/issues/2189
* some portal thing I do not understand https://github.com/datopian/portal.js (frictionless data related?)
* See these arrow-js posts in observable. Maybe that is where to experiment.
* http://www.data-forge-js.com/ might be good for js pipelines
* dataframe-js https://gmousse.gitbooks.io/dataframe-js/content/#dataframe-js seems very df like. Nw


### Viz for larger datasets and graphs

* https://github.com/vasturiano/3d-force-graph
* https://lightningchart.com/lightningchart-js-interactive-examples/examples/lcjs-example-0016-largeScatterChartXY.html
* https://www.highcharts.com/demo/scatter-boost/brand-light
* https://www.scichart.com/blog/javascript-chart-performance-plotting-10-million-datapoints-in-under-25ms/
* https://github.com/flekschas/regl-scatterplot
* https://github.com/nomic-ai/deepscatter
* https://echarts.apache.org/examples/en/index.html


* [echarts](https://echarts.apache.org/examples/en/editor.html?c=scatter3d-scatter&gl=1)? How large?
* visidata  https://www.pythonpodcast.com/visidata-exploratory-data-analysis-episode-230/
* [example with three.js and WebGL looks good](https://github.com/vasturiano/3d-force-graph)
* [glumpy](https://glumpy.github.io/)
* [vispy](http://vispy.org/) (high-level, depends on glumpy)
* [pyvis](https://pyvis.readthedocs.io/en/latest/)
* [mayavi](http://docs.enthought.com/mayavi/mayavi/) is still around but not sure how much it is used. Mostly for 3d.
* [gephi](https://gephi.org/) desktop app I think
* [this example](https://medium.com/neo4j/visualizing-graphs-in-3d-with-webgl-9adaaff6fe43) with 3d-force-render and neo4j looks interesting
* [paragraphl](https://nblintao.github.io/ParaGraphL/)
* [an example with three.js](https://github.com/davidpiegza/Graph-Visualization)


### Other

* [see this list for graph drawing](https://github.com/anvaka/graph-drawing-libraries)
* https://nvd3.org
* https://github.com/keen/keen-dataviz.js
* https://github.com/Shopify/dashing
* https://n3-charts.github.io/line-chart/#/home
* https://c3js.org
* http://dimplejs.org
* https://d3plus.org/

### Data exploration

* [openrefine](http://openrefine.org/) is still alive!?
* http://explorer.okfnlabs.org/#start 

## Actual data & viz

### Markets

* https://www.trismegistos.org/ldab/about.php
* https://www.hkma.gov.hk/eng/data-publications-and-research/data-and-statistics/monthly-statistical-bulletin/table/
* https://simfin.com/
* https://www.federalreserve.gov/monetarypolicy/bst_liquidityswaps.htm
* https://9fin.com/
* https://intrinio.com
* sentieo
* http://eqsift.com
* https://www.cityfalcon.com/financial-news-api (real time financial news aggregator)
* https://quotes.wsj.com/CA/S/financials/annual/balance-sheet
* https://www.kaggle.com/usfundamentals/us-stocks-fundamentals
* https://quickfs.net/company/AAPL
* https://www.screener.in/
* https://www.sec.gov/edgar.shtml
* https://lobsterdata.com/
* http://www.worldgovernmentbonds.com/country/argentina/
* ftp://ftp.cmegroup.com/
* https://rtdata.dtcc.com/gtr/dashboard.do
* https://www.statista.com/
* https://www.macrotrends.net
* https://canalyst.com/ (fundamentals)

### Non-Markets

* https://ourworldindata.org/books
* https://sentinel.esa.int/web/sentinel/sentinel-data-access
* http://datahelp.imf.org/knowledgebase/articles/536209-where-do-i-find-data-on-sovereign-debt
* github.com/datasets
* https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1010014701
* https://stats.oecd.org/Index.aspx?DataSetCode=REVCAN
* https://cps.ipums.org/cps-action/variables/INCTOT#comparability_section
* https://www.bankofengland.co.uk/research
* https://angel.co/salaries/london nice simple ui and design
* https://case.law/
* https://www.statista.com/
* https://www.ukdataservice.ac.uk/
* https://github.com/datasets
* https://www.getthedata.com/
* datahub.io
* https://ckan.org/
* https://www.openml.org/
* https://atlas.media.mit.edu/en/visualize/tree_map/hs92/export/prt/all/show/2016/
* https://propertydata.co.uk/price-per-square-foot
* http://visualizationuniverse.com/tools/?sortByPro=delta&sortDirPro=desc&sortByGen=volume&sortDirGen=desc
* https://developer.companieshouse.gov.uk/api/docs/
* http://visualizationuniverse.com/
* http://atlas.media.mit.edu/
* TrumpWorld data https://docs.google.com/spreadsheets/d/1Z5Vo5pbvxKJ5XpfALZXvCzW26Cl4we3OaN73K9Ae5Ss/edit#gid=634968401
* https://www.hackney.gov.uk/budget
* https://opendata.camden.gov.uk/browse
* https://dev.socrata.com/foundry/opendata.camden.gov.uk/ry6e-hbqy
* https://github.com/xmunoz/sodapy
* https://www.openbanking.org.uk/open-data-apis/
* https://www.doogal.co.uk/
* https://ons.maps.arcgis.com/home/search.html?t=content&q=tags%3AONS%20Postcode%20Directory&start=1&sortOrder=desc&sortField=relevance
* https://public.enigma.com/
* https://dev.socrata.com/foundry/opendata.camden.gov.uk/ry6e-hbqy
* https://github.com/xmunoz/sodapy
* https://www.openbanking.org.uk/open-data-apis/

## Tech env

* managing dotfiles https://github.com/RichiH/vcsh
* managing multiple repos https://github.com/joeyh/myrepos
* pathogen for vim https://github.com/tpope/vim-pathogen.
* screenrc tab emulation ... https://gist.github.com/cottrell/2de6b1076236b0b39071
* [Overview of syncthing, dat, etc ... still very good](https://livingthing.danmackinlay.name/synchronising_files.html)
* [Latency Numbers Every Programmer Should Know](https://gist.github.com/jboner/2841832)
* [More Napkin math, latency numbers](https://github.com/sirupsen/napkin-math)

## task queues

* https://taskqueues.com/
* celery
* https://dramatiq.io/
* https://huey.readthedocs.io/en/latest/
* https://python-rq.org/

## decentralized finance whatever that means

* https://aave.com/

## prediction markets

* https://mantic.markets/

## Interesting protocols

* https://minaprotocol.com/
* https://spacemesh.io/protocol/

## decentralized data, research, distributed fs, syncing, data versioning etc

Current top of the list

* https://academictorrents.com/ TODO 2022 ... not live though.
* https://github.com/zenodo/zenodo is decentralized? on top of https://github.com/inveniosoftware/invenio
* https://dvid.io/
* https://qri.io
* ipfs ipdb ipdl
* https://blog.textile.io/announcing-the-textile-protocol-hub/
* datproject
* https://streamr.network/
* https://livepeer.org/
* https://siasky.net/ skynet
* orbitdb
* bigchaindb
* https://osf.io/
* http://axon.science/
* https://oceanprotocol.com/

CALM and logical monotonicity:

* http://bloom-lang.net/calm/
* https://rise.cs.berkeley.edu/blog/an-overview-of-the-calm-theorem/
* https://arxiv.org/abs/1901.01930

From Alaric:

* [clustered analytic db](http://www.snell-pym.org.uk/archives/2016/12/11/cool-things-i-have-worked-on-clustered-analytic-database/)
* [low latency nosql datasore](http://www.snell-pym.org.uk/archives/2016/11/22/cool-things-i-have-worked-on-low-latency-highly-available-nosql-data-store/)

paxos notes https://martinfowler.com/articles/patterns-of-distributed-systems/paxos.html

Other notes

* dvc
* pachyderm
* http://iopscience.iop.org/article/10.1088/1742-6596/513/4/042014/pdf
* https://www.quantcast.com/about-us/quantcast-file-system/
* glusterfs
* https://github.com/orbitdb/orbit-db
* https://github.com/iterative/dvc/blob/e63bc01e53befe1a666b42c10330524c71d03af5/README.rst
* https://github.com/joshcc3/versioned-data-stores
* https://discuss.software-carpentry.narkive.com/txH4Lart/version-control-and-collaboration-with-large-datasets
* https://guix-devel.gnu.narkive.com/vs659vCf/use-guix-to-distribute-data-reproducible-data-science
* https://blog.oceanprotocol.com/blockchains-for-big-data-from-data-audit-trails-to-a-universal-data-exchange-cf9956ec58ea
* Interledger
* http://btrdb.io/about.html time series tree database uses capnproto
* https://github.com/RTradeLtd/Temporal
* https://discuss.ipfs.io/t/large-files-long-term-storage/4447
* https://slides.com/cosminp/storage-opts#/


Deterministic DB

* http://www.cs.umd.edu/~abadi/papers/abadi-cacm2018.pdf

Betting, smart contracts etc

* https://forecastfoundation.org/

### RPC/caching/dataframe Frameworks like dask and spark

* https://github.com/modin-project/modin
* ray-project
* https://github.com/ranaroussi/pystore
* https://github.com/cylondata/cylon ... has this been compared to polars? ... is distributed I think so a bit diff.

## bitemporal stuff

Search for bitemporal streaming or some such thing.

* https://opencrux.com/docs
* https://juxt.pro/blog/posts/case-study-bitemporal-store.html
* https://about.sourcegraph.com/strange-loop/strange-loop-2019-temporal-databases-for-streaming-architectures
* https://www.youtube.com/watch?v=YjAVsvYGbuU
* https://www.youtube.com/watch?v=ykbYNBE-V3k see 25:00 ish for https://en.wikipedia.org/wiki/Z-order_curve
* https://www.marklogic.com/blog/bitemporal/

Sort of related: "A Broadcast-Only Communication Model Based on Replicated Append-Only Logs" https://ccronline.sigcomm.org/wp-content/uploads/2019/05/acmdl19-295.pdf

## Time Series DB analytics etc

* https://quasardb.net/
* duckdb


## dedupe archival db related

Note there is something called "upsert" in deltalake

* https://www.databricks.com/blog/2019/10/03/simple-reliable-upserts-and-deletes-on-delta-lake-tables-using-python-apis.html
* https://github.com/dedupeio/dedupe
* https://borgbackup.readthedocs.io/en/stable/internals/data-structures.html


## Immutable db etc

* https://www.bigchaindb.com/
* https://github.com/codenotary/immudb

## stream processing etc

* https://www.ververica.com/platform (from flink people)

## merkle tree

* https://github.com/mafintosh/merkle-tree-stream https://datprotocol.github.io/book/ch02-02-merkle-tree-stream.html
* https://www.vldb.org/conf/2007/papers/research/p147-li.pdf whitepaper tumbling merkle
* container application https://arxiv.org/pdf/2104.02158.pdf
* go hobby project https://golangrepo.com/repo/cbergoon-merkletree-go-data-structures
* list https://www.findbestopensource.com/tagged/merkle-tree
* go https://pkg.go.dev/github.com/musalbas/smt?utm_source=godoc sparse merkle tree key value ...
* python prototype by vitalin here: https://ethresear.ch/t/data-availability-proof-friendly-state-tree-transitions/1453/5
* https://github.com/codenotary/immudb
* https://www.theqrl.org/
* https://datprotocol.github.io/how-dat-works/
* https://pypi.org/project/merkle-tree-stream/ https://github.com/hyperpy/merkle-tree-stream



## merkle db

* https://github.com/hoytech/quadrable (https://ethresear.ch/t/quadrable-sparse-merkle-tree-database-in-c-and-solidity-git-like-command-line-tool/8082)
* https://cljdoc.org/d/merkle-db/merkle-db/0.2.0/doc/readme (https://github.com/greglook/merkle-db)
* https://docs.aws.amazon.com/qldb/latest/developerguide/verification.html

## workflow, dag stuff etc

* https://github.com/common-workflow-language/common-workflow-language/wiki/Existing-Workflow-systems
* airflow luigi dask etc

## data pipelines, streaming etc

* some paper on "differential dataflow" which is more of the usual https://github.com/timelydataflow/differential-dataflow/blob/master/differentialdataflow.pdf ... incremental data processing
* https://github.com/grailbio/reflow incremental data proccessing ... seems scientific1G
* https://github.com/flyteorg/flyte I have yet to dig into flyte yet. Seems TODO 2022
* https://delta.io/sharing/ this is data sharing *protocol* ... i.e. for between orgs or something. ... wasn't there another platform called delta lake? Or is this same thing but transformed? Yes I think "delta lake" is the broader product https://delta.io/
* https://github.com/ozontech/file.d maybe try 2022
* https://www.slideshare.net/PoleSystematicParisRegion/building-a-highperformance-scalable-ml-nlp-platform-with-python-sheer-el-showk
* https://code.facebook.com/posts/1072626246134461/introducing-fblearner-flow-facebook-s-ai-backbone/
* faust
* https://github.com/pipelinedb/pipelinedb

want kafka but hate kafka

* https://news.ycombinator.com/item?id=20921572 (seems redis might be enough)
* https://github.com/xorlev/slogd


## data quality

* https://griffin.incubator.apache.org/
* https://datacleaner.github.io/

Maybe these:

* http://apex.apache.org/
* http://ambari.apache.org/
* HDFS? https://cwiki.apache.org/confluence/display/AMBARI/Installation+Guide+for+Ambari+2.6.1
* TRY THIS: http://predictionio.apache.org/demo/tapster/

Maybe not these:

* https://fluo.apache.org//docs/fluo/1.2/getting-started/design
* https://incubator.apache.org/projects/accumulo.html
* https://research.google.com/pubs/pub36726.html
* https://fluo.apache.org//docs/fluo/1.2/getting-started/design
* https://incubator.apache.org/projects/gearpump.html
* https://projects.apache.org/project.html?vxquery XML query

## hardware

* https://apple.stackexchange.com/questions/277356/machine-learning-on-external-gpu-with-cuda-and-late-mbp-2016

## privacy, security etc

* https://github.com/sobolevn/git-secret

## links uncategorized

* http://www.ml4aad.org/ meta-algorithmics
* nice ml blog :https://haohanwang.tumblr.com/post/166276833528/prototyping-6-8pm-bitcoin-prices-predictions
* http://selection.datavisualization.ch
* http://irods.org
* https://github.com/transmart
* http://datatables.net
* http://www.wanghailuo.com/deeplearning/deep-learning-resources
* http://www.ke.tu-darmstadt.de/lehre/arbeiten/studien/2015/Dong_Ying.pdf (beating Kaggle the easy way)
* useful hashing tricks in python https://discussions.udacity.com/t/assignment-1-problem-5/45657/59
* http://www.samim.io deep dream etc
* nmap examples http://security.stackexchange.com/questions/36198/how-to-find-live-hosts-on-my-network
* https://git.codemadness.org/stagit/
* https://blockstack.org
* https://abikogailmonxlzl.onion.casa/
* https://hashtags.chat/
* https://www.freerobotcollective.com/
* https://www.productchart.co.uk # shopping
* http://next.openspending.org/
* https://okfn.org/

## maths, probability, stochastic etc

SGD, Langevin, batch-size etc

* https://arxiv.org/pdf/1707.06618.pdf
* https://arxiv.org/pdf/1806.09597.pdf
* https://openreview.net/pdf?id=B1Yy1BxCZ
* https://arxiv.org/pdf/1711.04623.pdf

Stochastic Duality

* https://arxiv.org/pdf/1805.01318.pdf

Interacting Particle Systems (and duality)

* ligget http://users.ictp.it/~pub_off/lectures/lns017/Liggett/Liggett.pdf
* swart https://arxiv.org/pdf/1703.10007.pdf

## feature stores

* https://euclidesdb.readthedocs.io/en/latest/ (ml featurestore)
* https://medium.com/riselab/feature-stores-the-data-side-of-ml-pipelines-7083d69bff1c

## ml, machine learning, rl, reinforcement learning

* reproducible research platform? https://github.com/allenai/beaker
* https://github.com/ekzhu/datasketch (LSH etc)
* 30 years http://www-isl.stanford.edu/~widrow/papers/j199030years.pdf
* https://www.libspn.org/
* https://github.com/SPFlow/SPFlow
* quantile regression https://freakonometrics.hypotheses.org/files/2017/05/erasmus-1.pdf
* Powell (Approximate Dynamic Programming)
* ADP w Gaussian Proc http://mlg.eng.cam.ac.uk/pub/pdf/DeiPetRas08.pdf and on a budget: https://papers.nips.cc/paper/6188-bayesian-optimization-with-a-finite-budget-an-approximate-dynamic-programming-approach.pdf
* https://quid.com/feed/how-quid-uses-deep-learning-with-small-data
* https://github.com/thu-ml/zhusuan
* http://jaberg.github.io/skdata/
* https://pair-code.github.io/facets/
* https://pair-code.github.io/deeplearnjs/
* https://hioptimus.com/ (https://nbviewer.jupyter.org/github/ironmussa/Optimus/blob/master/examples/Optimus_Example.ipynb)
* https://www.linkedin.com/pulse/data-cleansing-exploration-new-era-optimus-favio-v%C3%A1zquez
* (vectorflow) https://medium.com/@NetflixTechBlog/introducing-vectorflow-fe10d7f126b8
* http://mlwave.com/kaggle-ensembling-guide
* http://fastml.com/toy-store
* BIDMach ... supposed to be fast
* http://playground.tensorflow.org/#activation=tanh&batchSize=10&dataset=spiral&regDataset=reg-plane&learningRate=0.03&regularizationRate=0&noise=0&networkShape=8,8&seed=0.81233&showTestData=false&discretize=false&percTrainData=50&x=true&y=true&xTimesY=false&xSquared=true&ySquared=true&cosX=false&sinX=false&cosY=false&sinY=false&collectStats=false&problem=classification
* http://rail.eecs.berkeley.edu/deeprlcourse/index.html
* http://ai.berkeley.edu/home.html
* https://www.biorxiv.org/content/biorxiv/early/2017/08/25/180471.full.pdf?%3Fcollection= (https://medium.com/@jaiyamsharma/efficient-nearest-neighbors-inspired-by-the-fruit-fly-brain-6ef8fed416ee)
* https://github.com/lmcinnes/umap
* https://www.featuretools.com/

## dimensional analysis

* https://github.com/AndrewChap/symdim
* https://pypi.org/project/numericalunits/
* https://causlayer.orgs.hk/saadgroup/BuckinghamPy
* https://pint.readthedocs.io/en/0.10.1/index.html
* https://pubs.acs.org/doi/abs/10.1021/acs.chemmater.8b02837
* https://advances.sciencemag.org/content/6/16/eaay2631
* https://www.researchgate.net/profile/Stephan_Rudolph5/publication/2625410_On_the_Context_of_Dimensional_Analysis_in_Artificial_Intelligence/links/54f0a5870cf2b36214aac529/On-the-Context-of-Dimensional-Analysis-in-Artificial-Intelligence.pdf
* http://web.mit.edu/2.25/www/pdf/DA_unified.pdf
* https://arxiv.org/abs/1708.04303


### sequence learning related

* [Pervasive Attention: 2D Convolutional Neural Networks
for Sequence-to-Sequence Prediction](https://arxiv.org/pdf/1808.03867.pdf)
* [The fall of RNN / LSTM](https://towardsdatascience.com/the-fall-of-rnn-lstm-2d1594c74ce0)
* https://medium.com/datathings/the-magic-of-lstm-neural-networks-6775e8b540cd
* https://devblogs.nvidia.com/introduction-neural-machine-translation-with-gpus/
* https://devblogs.nvidia.com/introduction-neural-machine-translation-gpus-part-2/
* https://devblogs.nvidia.com/introduction-neural-machine-translation-gpus-part-3/

### simulators
* https://dartsim.github.io/
* https://github.com/openai/roboschool
* pybullet

### factorization machines

* This is a good example with tf: https://getstream.io/blog/factorization-recommendation-systems/
* Spark based implementation: https://github.com/Intel-bigdata/imllib-spark
* [Robust Factorization Machines for User Response Prediction](http://delivery.acm.org/10.1145/3190000/3186148/p669-punjabi.pdf?ip=146.199.120.140&id=3186148&acc=OPEN&key=4D4702B0C3E38B35%2E4D4702B0C3E38B35%2E4D4702B0C3E38B35%2E6D218144511F3437&__acm__=1536927968_beae87bad8012b6415eb183e813fc0b7)
    * iterative parameter mixing for distributed SGD (for factorization machines "averaging" the model probably really means just averaging params?)
    * use hashing trick on the high-dim feature space

### distributed algos


### nearest neighbor

* https://github.com/ekzhu/datasketch (sort of) LSH etc fast prob data structures
* https://github.com/erikbern/ann-benchmarks
* https://github.com/spotify/annoy
* http://www.cs.ubc.ca/research/flann
* https://github.com/FALCONN-LIB/FALCONN

### Normalizing Flows and Density Estimation

* https://blog.evjang.com/2018/01/nf1.html
* http://akosiorek.github.io/ml/2018/04/03/norm_flows.html
* autoregressors (masked autoregressive flows): https://arxiv.org/pdf/1705.07057.pdf and https://github.com/gpapamak/maf
* autoencoder
	* http://arxiv.org/pdf/1502.03509v2.pdf
	* https://github.com/mgermain/MADE (distrubtion estimation http://arxiv.org/pdf/1502.03509v2.pdf)

### mixture density network links

* http://gitxiv.com/posts/KPQqJzafhQ5uyZcMP/mixture-density-networks
* https://github.com/fchollet/keras/issues/1061
* https://github.com/karpathy/randomfun/blob/master/MixtureDensityNets.ipynb
* http://blog.otoro.net/2015/06/14/mixture-density-networks
* http://blog.otoro.net/2015/11/24/mixture-density-networks-with-tensorflow

### lstm/rnn examples

* http://machinelearningmastery.com/memory-in-a-long-short-term-memory-network/
* http://philipperemy.github.io/keras-stateful-lstm/

### hyper param opt

* https://ray.readthedocs.io/en/latest/tune-usage.html
* https://ray.readthedocs.io/en/latest/walkthrough.html
* https://github.com/topics/bayesian-optimization
* https://scikit-optimize.github.io/
* https://github.com/SheffieldML/GPyOpt
* https://github.com/hyperopt/hyperopt
* https://github.com/fmfn/BayesianOptimization
* https://github.com/hawk31/pyGPGO

#### other lists

* https://danmackinlay.name/notebook/hyperparam_opt.html

### ml/rl environments

* https://stanfordnlp.github.io/stanza/ (NLP)
* https://gym.openai.com/envs#parameter_tuning
* https://github.com/facebookresearch/CommAI-env
* https://github.com/Evolving-AI-Lab

### GP

* http://dan.iel.fm/george/current
* http://arxiv.org/abs/1403.6015

### CV exploratory approaches

* https://www.kaggle.com/selfishgene/santander-customer-satisfaction/advanced-feature-exploration

### sum product

* https://github.com/arranger1044/spyn # this one seems more used
* https://github.com/ilyakava/sumproduct
* http://libra.cs.uoregon.edu/ (OCaml)
* http://turing.cs.washington.edu/papers/uai11-poon.pdf

### custom objectives

* https://github.com/fchollet/keras/blob/master/keras/objectives.py
* https://github.com/tqchen/xgboost/blob/master/demo/guide-python/custom_objective.py
* https://github.com/Microsoft/LightGBM/blob/master/examples/python-guide/advanced_example.py

## hardware

* https://puri.sm/store
* https://github.com/tqchen/xgboost/blob/master/demo/guide-python/custom_objective.py

## tax, spending, fiscal, gov etc

* https://www.step.org/conferences/1 estate tax etc
* https://openspending.org/
* https://github.com/openspending/gobble
* https://github.com/hmrc/paye-estimator
* https://www.aesinternational.com/education-centre/taxes-for-expats/canada

## APIs

* https://newsapi.org/

## travel

* https://travel.stackexchange.com/questions/73709/flight-search-from-anywhere-to-a-specific-destination?newreg=44cfd17228e6460b9b5b62e76dac2459
* natural language queries on http://adioso.com ... but does not work
* https://www.quora.com/Are-there-any-free-APIs-for-flight-fare-search
* https://github.com/jpatokal/openflights
* https://www.airhob.com/developers
* http://www.tripsta.co.uk/faqs/Flights

## engineering

* [Google Cloud ML setup 2018](https://blog.kovalevskyi.com/deep-learning-images-for-google-cloud-engine-the-definitive-guide-bc74f5fb02bc)
* https://blog.twitter.com/2015/building-distributedlog-twitter-s-high-performance-replicated-log-service
* https://blog.twitter.com/2014/manhattan-our-real-time-multi-tenant-distributed-database-for-twitter-scale
* https://aws.amazon.com/datapipeline
* (fb) https://fbcdn-dragon-a.akamaihd.net/hphotos-ak-xpt1/t39.2365-6/13331599_975087972607457_1796386216_n/Realtime_Data_Processing_at_Facebook.pdf
* http://techblog.netflix.com/2016/03/caching-for-global-netflix.html
* https://engineering.linkedin.com/distributed-systems/log-what-every-software-engineer-should-know-about-real-time-datas-unifying
* https://cloud.google.com/blog/big-data/2017/05/after-lambda-exactly-once-processing-in-google-cloud-dataflow-part-1

## maybe useful libs to watch

* https://github.com/wiseio/paratext

## historical

* http://projecteuclid.org/download/pdf_1/euclid.ss/1009213726

## browser

* beaker
* brave
* epic
* vivaldi
* tor

## web

* http://stackoverflow.com/questions/21198977/difference-between-grunt-npm-and-bower-package-json-vs-bower-json
* https://github.com/valor-software/angular2-quickstart.git

## coursera

* https://www.coursera.org/specializations/jhu-data-science
* https://www.coursera.org/specializations/computer-fundamentals
* https://www.coursera.org/specializations/project-management
* https://www.coursera.org/specializations/wharton-business-foundations
* https://www.coursera.org/specializations/interaction-design
* https://www.coursera.org/specializations/data-science-python
* https://www.coursera.org/specializations/genomic-data-science
* https://www.coursera.org/specializations/machine-learning
* https://www.coursera.org/specializations/power-electronics
* https://www.coursera.org/specializations/cyber-security
* https://www.coursera.org/specializations/investment-management
* https://www.coursera.org/specializations/wharton-entrepreneurship
* https://www.coursera.org/specializations/big-data
* https://www.coursera.org/specializations/probabilistic-graphical-models
* https://www.coursera.org/specializations/data-science
* https://www.coursera.org/specializations/learn-finance
* https://www.coursera.org/specializations/business-strategy
* https://www.coursera.org/specializations/systems-biology
* https://www.coursera.org/specializations/data-structures-algorithms
* https://www.coursera.org/specializations/strategic-leadership
* https://www.coursera.org/specializations/bioinformatics
* https://www.coursera.org/specializations/trading-strategy
* https://www.coursera.org/specializations/startup-valuation
* https://www.coursera.org/specializations/recommender-systems
* https://www.coursera.org/specializations/hsk-learn-chinese
* https://www.coursera.org/learn/learn-chinese
* https://www.coursera.org/learn/cryptocurrency
* https://www.coursera.org/learn/medical-neuroscience
* https://www.coursera.org/learn/python-machine-learning
* https://www.coursera.org/learn/java-data-structures-algorithms-2
* https://www.coursera.org/learn/comparch
* https://www.coursera.org/learn/probability-intro
* https://www.coursera.org/learn/crypto

## DB and analytics

Time-series 2019

* TimescaleDB
* Marketstore
* probably not influxdb
* https://github.com/OpenHFT/Chronicle-Queue#design Micro second messaging that stores everything to disk
* https://dbdb.io/db/lmdb lightning memory map database, local simple

* https://github.com/mitdbg
* https://www.pipelinedb.com
* http://gun.js.org
* http://orientdb.com/ (http://orientdbleaks.blogspot.com/2016/06/one-year-of-orientdb-leaks.html)
* https://www.arangodb.com
* https://grakn.ai

Misc 2021

* https://github.com/vaexio/vaex (pandas)
* https://euclidesdb.readthedocs.io/en/latest/ (ml featurestore)
* https://hiddentao.github.io/squel/ (js query builder)
* https://docs.temporal.io/docs/get-started/ (seems more orchestration)
* https://github.com/adamerose/pandasgui

### object stores

* Minio
* GlusterFS
* Cephs

## messaging

* https://ricochet.im
* https://github.com/agl/pond
* https://otr.cypherpunks.ca
* https://whispersystems.org

# data discovery and meta data etc

* https://github.com/linkedin/WhereHows/wiki
* https://github.com/mitdbg/aurum-datadiscovery
* https://github.com/redglue/redsense # sensitive data handler? probably awful

## semantic web and things I tend to ignore

* OntoSpy: a lightweight Python library and command line tool for inspecting and visualizing vocabularies encoded using W3C Semantic Web standards, that is, RDF or any of its dialects (RDFS, OWL, SKOS).
* http://wiki.dbpedia.org/
* https://pypi.python.org/pypi/ontospy
* https://pypi.python.org/pypi/python-skos
* http://librdf.org/

### Semantic web search engines?
* https://www.w3.org/wiki/Search_engines

## articles and data

* https://www.bankofengland.co.uk/working-paper/2017/eight-centuries-of-the-risk-free-rate-bond-market-reversals-from-the-venetians-to-the-var-shock

## language data (dictionaries etc)

* https://www.skishore.me/makemeahanzi/
* https://nlp.stanford.edu/projects/glove/
* https://github.com/facebookresearch/fastText/blob/master/pretrained-vectors.md

## todo

* apache tika
* apache solr
* https://github.com/datasets
* https://github.com/frictionlessdata/datapackage-py
* https://github.com/frictionlessdata
* https://github.com/mitdbg/modeldb
* does IPE still exist (that drawing tool?) what is alternative now

## GPG etc

	gpg --gen-key
	gpg --list-secret-keys --keyid-format LONG
	gpg --armor --export <id>

## drone

* http://www.starlino.com/power2thrust.html

## Concurrency

* http://masnun.rocks/2016/10/06/async-python-the-different-forms-of-concurrency/
* https://www.reddit.com/r/learnpython/comments/72a8ek/why_bother_using_asyncio_when/

# Monoclonal Antibodies

A very quick read and summary through some links.

Quick view from Forbes: https://www.forbes.com/sites/williamhaseltine/2020/04/23/promising-new-drugs-to-treat-and-prevent-covid-19/#44c1d0b145bf
> How soon will drugs be available? My guess, within three to four months for the first approvals.
>
> It may take several weeks to demonstrate effectiveness in animals.  Human safety studies can be done with no more than 30 people in about a month. These drugs are generally known to be safe though more testing for safety will be required.  Tests of the drugs’ effect in reducing the viral load in infected patients should take no longer than a month.  Most time consuming will be large scale manufacturing of the drugs, once approved.

Mostly focused on details of production. Figure 3 for production/approval pipeline ... https://jbiomedsci.biomedcentral.com/articles/10.1186/s12929-019-0592-z
Two methods:
  * phage display, wherein diverse exogenous genes are incorporated into filamentous bacteriophages to compose a library. The library proteins are then presented on the phage surface as fusions with a phage coat protein, allowing the selection of specific binders and affinity characteristics.
  * Transgenic animals represent another technology for obtaining fully human mAbs.
> The recent development of bispecific antibodies offers attractive new opportunities for the design of novel protein therapeutics. A bispecific antibody can be generated by utilizing protein engineering techniques to link two antigen binding domains (such as Fabs or scFvs), allowing a single antibody to simultaneously bind different antigens.

> The mAb market enjoys a healthy pipeline and is expected to grow at an increasing pace, with a current valuation of $115.2 billion in 2018 [44]. Despite this high growth potential, new companies are unlikely to take over large shares of the market, which is currently dominated by seven companies: 
>  * Genentech (30.8%)
>  * Abbvie (20.0%)
>  * Johnson & Johnson (13.6%)
>  * Bristol-Myers Squibb (6.5%)
>  * Merck Sharp & Dohme (5.6%)
>  * Novartis (5.5%)
>  * Amgen (4.9%)
>  * with other companies comprising the remaining 13% [44].

This is good for market and timelines, probably longer than would happen now: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4622599/
> Based on a review of historical success and turnover rates (i.e., the length of time required for a product to move from one stage of development to the next) of biopharmaceutical product development candidates, ∼26% of the monoclonal antibody products entering Phase 2 human clinical trials in recent years will ultimately achieve market approval with an average time from the start of Phase 2 clinical trials to approval of ∼ seven years.5-7 

Another one mostly on details of production: https://www.intechopen.com/books/fermentation-processes/production-processes-for-monoclonal-antibodies
> In general, a process of commercial production of mAb begins with the generation of an mAb by immunizing an animal or by molecular biology methods involving the identification and optimization of the coding DNA sequence and the construction and identification of a stable high-producing clone. Improvements in cultivation are similar to those applied in other bioproducts that rely on culturing microorganisms or cells, requiring the development of a well-designed culturing process comprising the full range of control and associated operations that will support technical evaluations

This one has some timelineshttps://www.researchgate.net/publication/23656557_Monoclonal_Antibodies_as_Innovative_Therapeutics/figures?lo=1

This one is just a snippet but apparently short half life is an issue?
> 10.3 Drawbacks of Monoclonal Antibodies Monoclonal antibodies (mAbs) are extensively used in the areas of diagnostics and healthcare. Despite their extensive use, mAbs present several disadvantages, namely, they are very expensive and difficult to produce. Additionally, their large molecular size (150 kDa) limits their tissue and tumor penetration, thus limiting their biodistribution and efficacy. Moreover, they can also induce immune reactions, which further limits their long-term application. Lastly, mAbs have a half-life of several days, which leads to high background signals when used for molecular imaging.


Other links:

* https://www.uptodate.com/contents/overview-of-therapeutic-monoclonal-antibodies
* https://en.wikipedia.org/wiki/Monoclonal_antibody_therapy
* https://www.nuventra.com/resources/blog/monoclonal-antibodies-past-present-and-future/
* https://considerations.bmj.com/content/1/1/3
* https://mrc.ukri.org/news/blog/from-tool-to-therapy-a-timeline-of-monoclonal-antibody-technology/

# Alternatives to medium

See [here](https://ethical.net/ethical/ethical-alternatives-to-medium/#:~:text=Other%20ethical%20alternatives%20to%20Medium,of%20a%20built%2Din%20community.)

* https://joinplu.me/
* https://writefreely.org/
* https://www.squarespace.com/
* https://wordpress.com/
* https://ghost.org/
* https://anchorcms.com/
* https://www.sigle.io/
* https://imprint.to/

# Automated Theorem Proving

* https://leanprover.github.io/

# stack 2020

* replace argh with typer?

# voting

* https://github.com/mdipierro/evote
* https://github.com/CitizensFoundation/open-active-voting
* https://github.com/microsoft/electionguard
* https://github.com/cryptoballot/cryptoballot
* https://github.blog/2020-10-22-vote-and-contribute-to-democracy-through-open-source/
* http://votosocial.github.io/

# fast distance matrix calculations

* https://numba.discourse.group/t/fastest-numba-code-for-computing-euclideandistance-between-a-vector-and-every-row-of-a-matrix/190
* https://scikit-learn.org/stable/modules/generated/sklearn.metrics.pairwise_distances.html
* https://github.com/talboger/fastdist/blob/master/fastdist/fastdist.py

Also see:
* https://stanczakdominik.github.io/posts/distance-matrix-numba/
* https://people.duke.edu/~ccc14/sta-663/Optimization_Bakeoff.html
* https://www.kaggle.com/cpmpml/ultra-fast-distance-matrix-computation
* https://stackoverflow.com/questions/60015409/speeding-up-numba-distance-calculation
