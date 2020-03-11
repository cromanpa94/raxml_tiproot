library(ape)
library(geiger)

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

##get the contrasts
data_constrats<-cbind.data.frame('PIC_KS'=  pic(data[,2], tree), 'PIC_Percent'=pic(data[,3], tree))

##regression (PGLS)
summary(lm(data_constrats[,2] ~ data_constrats[,1]))

##Plot
plot(data_constrats[,1], data_constrats[,2], xlab='Ks (contrast)', ylab='Percent (contrast)')




