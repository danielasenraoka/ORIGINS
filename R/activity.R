#' Title
#'
#' @param expression_matrix Input expression matrix with cells as columns and genes as rows(matrix or data frame)
#' @param adjacency_edges Adjacency edges of the protein protein interaction network
#'
#' @return A vector with the differentiation activity values for each cell
#' @export
#'
#' @importFrom rlang .data
activity <- function(expression_matrix, adjacency_edges = .data$differentiation_edges) {

  cc.df <- data.frame(adjacency_edges)
  colnames(cc.df) <- c("node1", "node2")
  cc.df <- cc.df %>% dplyr::arrange((.data$node1))
  reduced.df <- data.frame(expression_matrix)
  reduced.df <- reduced.df %>% dplyr::arrange((row.names(reduced.df)))
  intersection_genes <- intersect(rownames(reduced.df), cc.df$node1)
  cc.df_reduced <- cc.df[cc.df$node1 %in% intersection_genes, ]
  cc.df_reduced <- cc.df_reduced[cc.df_reduced$node2 %in% intersection_genes, ]
  adjacency_list <- stats::aggregate(node1 ~ node2, cc.df_reduced, FUN = I)
  rownames(adjacency_list) <- adjacency_list[, 1]

  act <- numeric(ncol(reduced.df))

  for (cell in 1:ncol(reduced.df)) {
    sum_expression <- 0
    for (gene in 1:nrow(adjacency_list)) {
      gene_name <- adjacency_list[gene, 1]
      sum_expression <- sum_expression + (reduced.df[gene_name, cell] * sum(reduced.df[unlist(adjacency_list[gene_name, 2]), cell]))
    }
    act[cell] <- sum_expression
  }

  # activity scaling
  min_vf <- min(act)
  max_vf <- max(act)
  act_norm <- (act - min_vf) / (max_vf - min_vf)

  return(act_norm)
}
