#' read_excel_sheets
#'
#' reads all sheets from an excel file
#'
#' @param filepath to the file to be imported.
#' @param ... args to supply to read_excel
#' @return a list of tibbles with each index as the name of the imported sheet.
#' @export

read_excel_sheets <- function(filepath, ...) {
    sheetnames <- readxl::excel_sheets(filepath)
    workbook <- lapply(sheetnames, readxl::read_excel, path=filepath, ...)
    names(workbook) <- sheetnames
    workbook
}
