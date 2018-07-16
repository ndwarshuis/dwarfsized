#' theme_pub
#'
#' theme for use in published figures
#' 
#' @export

theme_pub <- ggplot2::theme_classic() +
    ggplot2::theme(text = ggplot2::element_text(size = 7),
          line = ggplot2::element_line(size = 0.2),
          axis.line = ggplot2::element_line(size = 0.2),
          legend.box.spacing = ggplot2::unit(0.2, "cm"),
          legend.margin = ggplot2::margin(0.1, 0.1, 0.1, 0.1, "cm"),
          legend.key.size = ggplot2::unit(0.55, "lines"),
          legend.spacing = ggplot2::unit(0.15, "cm"))
