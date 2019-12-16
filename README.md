# mybin

Notes, links, scripts, memories, recommendations, ghosts etc.

<!--ts-->
* [mybin](#mybin)
    * [Services and tools for business and productivity](#services-and-tools-for-business-and-productivity)
    * [finance/markets/trading](#financemarketstrading)
    * [causal inference, causal graphs, probabilistic programming](#causal-inference-causal-graphs-probabilistic-programming)
    * [people](#people)
    * [clustering, record linkage etc](#clustering-record-linkage-etc)
    * [backtesting/trading tools](#backtestingtrading-tools)
    * [viz/dashboarding/charts](#vizdashboardingcharts)
        * [Top candidates for generic analytics 2018:](#top-candidates-for-generic-analytics-2018)
        * [Viz for larger datasets](#viz-for-larger-datasets)
        * [Data exploration](#data-exploration)
    * [actual data & viz](#actual-data--viz)
    * [TODO](#todo)
    * [tech env notes](#tech-env-notes)
    * [distributed fs](#distributed-fs)
    * [data pipelines etc](#data-pipelines-etc)
    * [data quality](#data-quality)
    * [hardware](#hardware)
    * [privacy, security etc](#privacy-security-etc)
    * [links uncategorized](#links-uncategorized)
    * [ml, machine learning, rl, reinforcement learning](#ml-machine-learning-rl-reinforcement-learning)
        * https://github.com/StatMixedML/XGBoostLSS
        * https://github.com/Orcuslc/OrthNet
        * [sequence learning related](#sequence-learning-related)
        * [simulators](#simulators)
        * [factorization machines](#factorization-machines)
        * [distributed algos](#distributed-algos)
        * [nearest neighbor](#nearest-neighbor)
        * [density estimation](#density-estimation)
        * [mixture density network links](#mixture-density-network-links)
        * [lstm/rnn examples](#lstmrnn-examples)
        * [bayes opt](#bayes-opt)
        * [ml/rl environments](#mlrl-environments)
        * [GP](#gp)
        * [CV exploratory approaches](#cv-exploratory-approaches)
        * [sum product](#sum-product)
        * [custom objectives](#custom-objectives)
    * [hardware](#hardware)
    * [tax, spending, fiscal, gov etc](#tax-spending-fiscal-gov-etc)
    * [APIs](#apis)
    * [travel](#travel)
    * [engineering](#engineering)
    * [maybe useful libs to watch](#maybe-useful-libs-to-watch)
    * [historical](#historical)
    * [browser](#browser)
    * [web](#web)
    * [coursera](#coursera)
    * [DB](#db)
        * [object stores](#object-stores)
    * [messaging](#messaging)
* [data discovery and meta data etc](#data-discovery-and-meta-data-etc)
    * [semantic web and things I tend to ignore](#semantic-web-and-things-i-tend-to-ignore)
    * [articles and data](#articles-and-data)
    * [language data (dictionaries etc)](#language-data-dictionaries-etc)
    * [todo](#todo)
    * [GPG etc](#gpg-etc)
    * [drone](#drone)
    * [Concurrency](#concurrency)
<!--te-->

## Services and tools for business and productivity

Start with this list: https://github.com/cjbarber/ToolsOfTheTrade

Key value store:

* https://blog.dgraph.io/post/badger/

Misc

* https://github.com/PyO3/rust-numpy
* blackrock is involved in this: https://argoproj.github.io/argo
* https://gogs.io/ git service self hosted
* https://www.turaku.com/why

Time tracking:

* https://www.toggl.com/
* https://demo.kimai.org/
* https://clockify.me/tracker

## finance/markets/trading

Stochastic, math fin etc

* https://www.math.nyu.edu/faculty/goodman/teaching/StochCalc2012/notes/Week4.pdf
* https://wwwf.imperial.ac.uk/~ajacquie/index_files/GHJ%20-%20SABRGeometry.pdf
* https://www.stat.berkeley.edu/~aldous/205B/pitman_yor_guide_bm.pdf
* file:///home/cottrell/Downloads/risks-05-00061-v2%20(1).pdf
* http://www.eco.uc3m.es/~mkredler/ContTime/5ExitTimes.pdf
* https://www.newyorkfed.org/medialibrary/media/research/staff_reports/sr677.pdf
* realized vol options etc https://pdfs.semanticscholar.org/c092/c65551a77339c952becf8ccc93a13c98ece0.pdf

Trading, securities etc

* [entropy trading volumes futures](https://quantitativebrokers.com/wp-content/uploads/2017/05/entropy.pdf)
* [securitization process](http://www.accountingnotes.net/financial-management/debt-securitization/debt-securitization-meaning-and-process-financial-management/10920)
* [KG loans and shipping](https://www.tankershipping.com/news/view,german-tanker-operators-and-the-new-normal-of-mergers-and-acquisitions_53443.htm)

Regs for payment systems and retail bank-like entities (revolute):

* [The Electronic Money Regulations 2011](http://www.legislation.gov.uk/uksi/2011/99/contents/made)
* [The Payment Services Regulations 2009](http://www.legislation.gov.uk/uksi/2009/209/contents/made)


Elicitability, Quantiles, Expectiles etc

* https://freakonometrics.hypotheses.org/files/2017/05/erasmus-1.pdf

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

## viz/dashboarding/charts

### Top candidates for generic analytics 2018:

* vega (visualization grammar and associated tools)
    * vega/voyager (chart recommender system) https://vega.github.io/voyager2/
    * altair also built on vega and vega-lite
* holoviews based on bokeh. maybe easier within notebooks not sure
* superset
* metabase

### Viz for larger datasets and graphs

* [example with three.js and WebGL looks good](https://github.com/vasturiano/3d-force-graph)
* [glumpy](https://glumpy.github.io/)
* [vispy](http://vispy.org/) (high-level, depends on glumpy)
* [pyvis](https://pyvis.readthedocs.io/en/latest/)
* [mayavi](http://docs.enthought.com/mayavi/mayavi/) is still around but not sure how much it is used. Mostly for 3d.
* [gephi](https://gephi.org/) desktop app I think
* [this example](https://medium.com/neo4j/visualizing-graphs-in-3d-with-webgl-9adaaff6fe43) with 3d-force-render and neo4j looks interesting
* [paragraphl](https://nblintao.github.io/ParaGraphL/)
* [an example with three.js](https://github.com/davidpiegza/Graph-Visualization)
* [remember umap](https://github.com/lmcinnes/umap) as a newer alternative to t-sne and probably a good place to start looking for any new viz tools

* visidata  https://www.pythonpodcast.com/visidata-exploratory-data-analysis-episode-230/

### Other

* [see this list for graph drawing](https://github.com/anvaka/graph-drawing-libraries)
* https://nvd3.org
* https://github.com/keen/keen-dataviz.js
* https://github.com/metabase/metabase
* https://github.com/Shopify/dashing
* https://n3-charts.github.io/line-chart/#/home
* https://c3js.org
* good list: http://www.cssauthor.com/javascript-charting-libraries
* http://dimplejs.org
* https://d3plus.org/

### RPC/caching/dataframe Frameworks like dask and spark

* https://github.com/modin-project/modin
* ray-project
* ...

### Data exploration

* [openrefine](http://openrefine.org/) is still alive!?
* http://explorer.okfnlabs.org/#start 

## actual data & viz

* https://simfin.com/
* https://www.federalreserve.gov/monetarypolicy/bst_liquidityswaps.htm
* https://9fin.com/
* http://www.worldgovernmentbonds.com/country/argentina/
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
* https://www.cityfalcon.com/financial-news-api (real time financial news aggregator)
* https://www.ukdataservice.ac.uk/
* https://github.com/datasets
* https://www.getthedata.com/
* https://lobsterdata.com/
* datahub.io
* https://ckan.org/
* https://www.openml.org/
* https://www.sec.gov/edgar.shtml
* https://atlas.media.mit.edu/en/visualize/tree_map/hs92/export/prt/all/show/2016/
* https://propertydata.co.uk/price-per-square-foot
* http://visualizationuniverse.com/tools/?sortByPro=delta&sortDirPro=desc&sortByGen=volume&sortDirGen=desc
* https://developer.companieshouse.gov.uk/api/docs/
* http://visualizationuniverse.com/
* http://atlas.media.mit.edu/
* TrumpWorld data https://docs.google.com/spreadsheets/d/1Z5Vo5pbvxKJ5XpfALZXvCzW26Cl4we3OaN73K9Ae5Ss/edit#gid=634968401
* https://intrinio.com
* http://eqsift.com
* https://www.hackney.gov.uk/budget
* https://opendata.camden.gov.uk/browse
* https://dev.socrata.com/foundry/opendata.camden.gov.uk/ry6e-hbqy
* https://github.com/xmunoz/sodapy
* https://www.openbanking.org.uk/open-data-apis/
* https://www.doogal.co.uk/
* https://ons.maps.arcgis.com/home/search.html?t=content&q=tags%3AONS%20Postcode%20Directory&start=1&sortOrder=desc&sortField=relevance
* https://public.enigma.com/

## TODO

* https://dev.socrata.com/foundry/opendata.camden.gov.uk/ry6e-hbqy
* https://github.com/xmunoz/sodapy
* https://www.openbanking.org.uk/open-data-apis/
* ambari
* h2o.ai

## tech env notes

Until I get a good dotfiles and clean up the chaos.

* managing dotfiles https://github.com/RichiH/vcsh
* managing multiple repos https://github.com/joeyh/myrepos
* pathogen for vim https://github.com/tpope/vim-pathogen.
* screenrc tab emulation ... https://gist.github.com/cottrell/2de6b1076236b0b39071
* syncing etc https://livingthing.danmackinlay.name/synchronising_files.html

* https://gist.github.com/jboner/2841832

## distributed fs, syncing, data versioning etc

* https://osf.io/
* http://iopscience.iop.org/article/10.1088/1742-6596/513/4/042014/pdf
* https://www.quantcast.com/about-us/quantcast-file-system/
* glusterfs
* https://github.com/orbitdb/orbit-db
* dat project
* ipfs
* https://github.com/iterative/dvc/blob/e63bc01e53befe1a666b42c10330524c71d03af5/README.rst
* https://github.com/joshcc3/versioned-data-stores
* https://discuss.software-carpentry.narkive.com/txH4Lart/version-control-and-collaboration-with-large-datasets
* https://guix-devel.gnu.narkive.com/vs659vCf/use-guix-to-distribute-data-reproducible-data-science

## data pipelines etc

* https://www.slideshare.net/PoleSystematicParisRegion/building-a-highperformance-scalable-ml-nlp-platform-with-python-sheer-el-showk
* https://code.facebook.com/posts/1072626246134461/introducing-fblearner-flow-facebook-s-ai-backbone/

## data quality

* https://griffin.incubator.apache.org/
* https://datacleaner.github.io/

these

* http://apex.apache.org/
* http://ambari.apache.org/
* HDFS? https://cwiki.apache.org/confluence/display/AMBARI/Installation+Guide+for+Ambari+2.6.1
* TRY THIS: http://predictionio.apache.org/demo/tapster/

maybe not these

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


## ml, machine learning, rl, reinforcement learning

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

### bayes opt

* https://github.com/topics/bayesian-optimization
* https://scikit-optimize.github.io/
* https://github.com/SheffieldML/GPyOpt
* https://github.com/hyperopt/hyperopt
* https://github.com/fmfn/BayesianOptimization
* https://github.com/hawk31/pyGPGO

### ml/rl environments

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

## DB

Time-series 2019

* TimescaleDB
* Marketstore
* probably not influxdb

* https://github.com/mitdbg
* https://www.pipelinedb.com
* http://gun.js.org
* http://orientdb.com/ (http://orientdbleaks.blogspot.com/2016/06/one-year-of-orientdb-leaks.html)
* https://www.arangodb.com
* https://grakn.ai

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

	OntoSpy is a lightweight Python library and command line tool for inspecting and visualizing vocabularies encoded using W3C Semantic Web standards, that is, RDF or any of its dialects (RDFS, OWL, SKOS).

* http://wiki.dbpedia.org/
* https://pypi.python.org/pypi/ontospy
* https://pypi.python.org/pypi/python-skos
* http://librdf.org/

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
