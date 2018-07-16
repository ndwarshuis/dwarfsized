#' ggpub
#'
#' Exports a PDF of a plot with sane defaults for publications (eg
#' much smaller text and dimensions).
#'
#' @param filename string for the file to export (no expension)
#' @param width the width in mm
#' @param height the height in mm
#' @param plot the plot to export (last plot if NONE)
#' @param geoms list of geoms to change in the form list(geom1 = list(prop1 = val1), etc).
#' @param theme the theme to use
#' @return NONE
#' @export

ggpub <- function(filename, width, height, plot = last_plot(),
                 geoms = geom_pub, theme = theme_pub) {

    ## update the geoms to something more sane
    gnames <- names(geoms)
    old_defaults <- lapply(gnames, get_geom_defaults)
    names(old_defaults) <- gnames 
    lapply(gnames, function(x) update_geom_defaults(x, geoms[[x]]))

    ## save the plot with the new theme
    ggsave(paste(filename, ".pdf", sep = ""), plot = plot + theme,
           units = "mm", width = width, height = height, dev="pdf")

    ## reset geoms
    gnames <- names(geoms)
    invisible(lapply(gnames, function(x) update_geom_defaults(x, old_defaults[[x]])))
}
