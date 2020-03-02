library(ape)

##########Function######
get_ingroup_TipRoot_distance<- function(tree, outgroupPattern='ppa', re_root=T){
  outgroup<-tree$tip.label[grep(outgroupPattern,tree$tip.label)]
  if(re_root ==T){ 
    cat('Rooting the tree using tips from the outgroup\n')
    tree<-root(tree, outgroup)  }
  ingroup<-drop.tip(tree, outgroup)
  rt_dist<-as.data.frame(diag(vcv.phylo(ingroup)))
  names(rt_dist)<-'distance'
  return(rt_dist)
}

#For a single tree
tree<-read.tree('OG0000135.fa.tre')
distance_single_tree<-get_ingroup_TipRoot_distance(tree)

distance_single_tree ##root-tip distances for each species in the ingroup

#For all .tre in the working directory

tree_names<-list.files(pattern = '.tre')
trees<-lapply(tree_names, read.tree)
distance_multiple_tree<-lapply(trees, get_ingroup_TipRoot_distance)
names(distance_multiple_tree)<-tree_names 

distance_multiple_tree ##Named list of root-tip distances for each species in the ingroup
