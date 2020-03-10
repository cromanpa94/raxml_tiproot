library(ape)
library(geiger)
library(caper)

#Read the tree and dataset
data<-read.delim('lycophytes_PGLS.csv')
tree<-read.tree('lycophytes.newick')

##Check the match between the tree and dataset 
name.check(tree, data.names =  data$Code)

##Remove codes from the taxa names both in the dataset and tree
##This step is not requiered if the dataset matches the species in the tree (see my email)
data$Code<-as.character(data$Code)
data$Code<-substr(data$Code,1,nchar(data$Code)-6)
tree$tip.label<-substr(data$Code,1,nchar(tree$tip.label)-5)

##Check the matching again
name.check(tree, data.names =  data$Code)

##Fit a PGLS using CAPER (create a comparative.data object first and then fit the pgls)
cd <- comparative.data(tree, data, Code, vcv=TRUE, vcv.dim=3)
mod <- pgls(Percent ~ Ks, cd, lambda='ML')

##Get the summary
summary(mod)
