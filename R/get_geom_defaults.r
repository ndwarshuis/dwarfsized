#' get_geom_defaults
#'
#' Gets a list of defaults for any given ggplot geom
#' 
#' @param geom a string for any of the ggplot geoms
#' @return list of defaults
#' @export

get_geom_defaults <- function(geom) {
    ggplot2:::check_subclass(geom, "Geom", env = parent.frame())$default_aes
}
