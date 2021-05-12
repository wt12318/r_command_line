#!/usr/bin/Rscript
if ("optparse" %in% installed.packages()){
  library("optparse")
}else{
  install.packages("optparse")
}


option_list <- list(
  make_option(c("-t", "--template"), action="store", default=NULL,
              help="File need to be changed"),
  make_option(c("-m", "--mapping"), action="store",default=NULL,
              help="Mapping file, each column corresponds to the values to replace"),
  make_option(c("-r", "--replace"), action="store", default=NULL,
              help="Character that need to be replaced, if there are more than 1 word, words should been splited by space"),
  make_option(c("-p", "--prefix"), action="store",default=NULL,
              help="Prefix of output files"),
  make_option(c("-s", "--suffix"), action="store",default=NULL,
              help="Suffix of output files"),
  make_option(c("-d", "--dir"), action="store",default=NULL,
              help="output dir")
)


opt <- parse_args(OptionParser(option_list=option_list))

a <- readLines(opt$template)

replace <- opt$replace
replace <- strsplit(replace,split = " ")[[1]]

map <- read.table(opt$mapping,sep = " ")
for (i in 1:nrow(map)){
  b <- a
  for (j in 1:length(replace)){
    b  <- gsub(replace[j],map[[j]][i],b)
  }
  outfcon <- file(paste0(opt$dir,opt$prefix,map$V1[i],".",opt$suffix), open="wt")
  writeLines(b, con=outfcon)
  close(outfcon) 
}

