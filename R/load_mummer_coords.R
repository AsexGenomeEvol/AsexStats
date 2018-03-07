#' Filter theta estimates
#'
#' This function can filter theta dataframe by coverage (depth), window size or both
#'
#' @param f a file that should be loaded
#'
#' @param lg a linkage group that will be loaded (all of the linkage groups if lg = NA), specifying lg will speed up loading about ten fold. Default : NA
#'
#' @param ord an order of scaffold that will be loaded, (all of the scaffolds groups if ord = NA). Specifying arguemtn has no effect on performance. Default : NA
#'
#' @importFrom sqldf sqldf
#' @export

load_mummer_coords <- function(f, lg = NA, ord = NA){
    grep_cmd <- paste0("grep ", ifelse(is.na(lg),
                                       "-v 'lgNA'",
                                       paste0("'", adjust_name(lg, 3) ,"'")))

    aln <- sqldf("select * from f", dbname = tempfile(),
                 file.format = list(sep = '\t', filter = grep_cmd))
    colnames(aln) <- c('r_start', 'r_end', 'q_start', 'q_end', 'r_aln_len', 'q_aln_len',
                       'identity', 'r_len', 'q_len', 'r_cov', 'q_cov', 'r_name', 'q_name')

    if( !is.na(ord) ){
        ord_grep <- adjust_name(ord, 4)
        aln <- aln[grepl(ord_grep, aln$r_name), ]
    }
    return(aln)
}
