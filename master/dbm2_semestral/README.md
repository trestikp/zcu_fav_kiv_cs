```
|- data - data zabalena v ZIPu, buf ve formatu .csv a nebo upravena data ve formatu .arff
|---- 50k_dataset.csv.zip - dataset pro trenovani SMO algoritmu (SMO nebyl realne pouzit, protoze zabira hodne casu)
|---- full_dataset.csv.zip - plny dataset se cca 2.7M zaznamy
|---- full_dataset_removed_attributes.arff.zip - plny dataset, ale s nekterymi atributy odstranenymi (tyto atributy mely minimalni dopad/ zhorsovaly model)
|- data_preparation
|---- 50k_data_preparation.sql - sql script ktery selecti 50_000 zaznamu pro trenovani SMO modelu (vice dat nez 50_000 prodluzuje trenovani z minut na hodiny a desitky hodin). Script take zarizuje, ze v datech jsou zastupci vsech trid ktere ma model klasifikovat.
|---- full_data_preparation.sql - vyber vsech dat (vysledek je priblizne 111MB ve formatu .csv)
|- doc
|---- cela_dokumentace.pdf - komplet dokumentace - 10 stran se vsim vsudy, trochu omacky okolo
|---- vytah_dokumentace.pdf - pokus vytahnout nejdulezitejsi informace z kompletni dokumentace a co nejstrucneji - 4 strany
|- model
|---- nb.model - model NaiveBayes, ktery byl pouzit pro realizaci prace
|---- smo.model - model SMO, ktery mel byt pouzit jako sekundarni model k porovnani s NB, ale kvuli casove narocnosti model nebyl pouzit (pouze vytvoren)
```
