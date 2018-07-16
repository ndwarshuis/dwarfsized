#' theme_pub
#'
#' theme for use in published figures
#' 
#' @export

theme_pub <- theme_classic() +
    theme(text = element_text(size = 7),
          line = element_line(size = 0.2),
          axis.line = element_line(size = 0.2),
          legend.box.spacing = unit(0.2, "cm"),
          legend.margin = margin(0.1, 0.1, 0.1, 0.1, "cm"),
          legend.key.size = unit(0.55, "lines"),
          legend.spacing = unit(0.15, "cm"))
