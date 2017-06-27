getIslandStats <- function(score_name){
	signatures <- read.csv(score_name, sep = ' ')

	islands <- c(F, signatures$Hurricane > 6);
	distinct = 0

	for(index in 2:length(islands)){
		if(islands[index-1] == F & islands[index] == T){
			distinct = distinct + 1;
		}
	}
	return(data.frame(scf = substr(score_name, 15,length(score_name)),
			   prop = mean(islands[-1]),
			   number = distinct))
}

