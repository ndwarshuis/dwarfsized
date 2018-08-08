#' import_luminex
#' 
#' Imports luminex data from the multi-sheet output given
#' from the biorad luminex machine. All sheets are combined
#' into one output. The input is expected to be a .xlsx file
#'
#' @param filepath string for the file to import
#' @return tidy tibble with columns for sample number, well, analyte, and concentration. Note that standard curves are ignored
#' @export

import_luminex <- function(filepath) {
    ## only need the 96 well data for each sheet (column a just has the
    ## the analyte which is alreadyin the sheet name)
    ldata <- read_excel_sheets(filepath, range = "B9:J89")

    ## function to remove the standard curve, the "X" in front of
    ## the sample number, rename the column to the analyte name,
    ## and give back only the columns we care about
    trim_luminex <- function(x) {
        new_ldata <- ldata[[x]] %>%
            slice(-1:-8) %>%
            mutate(Type = as.numeric(str_sub(Type, 2)),
                   `Obs Conc` = as.character(`Obs Conc`)) %>%
            select(-3:-8)
        colnames(new_ldata) <- c("sample", "well", x)
        new_ldata
    }

    ## join all the lists into one happy dataset
    ## this is when r should be haskell
    list_join <- function(x) {
        ## ghetto pattern matching
        if (length(x) == 2) {
            suppressMessages(dplyr::inner_join(x[[1]], x[[2]]))
        } else {
            suppressMessages(dplyr::inner_join(x[[1]], list_join(x[-1])))
        }
    }

    list_join(lapply(names(ldata), trim_luminex)) %>%
        ## tidy the data
        gather(-1, -2, key = "cytokine", value = "conc") %>%
        ## no need for bead regions...spaces are evil
        mutate(cytokine = str_replace(cytokine, "\\ \\(.*\\)", ""),
               ## replace "-" with "_"
               cytokine = str_replace(cytokine, "-", "_"))
}
