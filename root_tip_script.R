library(ape)

##########Function######
get_ingroup_TipRoot_distance<- function(tree, outgroupPattern='ppa', 
                                        re_root=T, asVector=T){
  
  ##First, identify the outgroup (outgroupPattern)
  outgroup<-tree$tip.label[grep(outgroupPattern,tree$tip.label)]
  
  #Reroot if re_root == T usinf ape::root
  if(re_root ==T){ 
    cat('Rooting the tree using tips from the outgroup\n')
    tree<-root(tree, outgroup)  }
  
  ##drop the outgroup from the original tree
  ingroup<-drop.tip(tree, outgroup)
  ##Extract distances from root to tips
  distances<-diag(vcv.phylo(ingroup))
 
  return(if(asVector == F){  rt_dist<-as.data.frame(distances)
  names(rt_dist)<-'distance'
  rt_dist
  #Return a data.frame with a single column (distance) and tip.labels as row.names
  }else{distances}
  )
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
