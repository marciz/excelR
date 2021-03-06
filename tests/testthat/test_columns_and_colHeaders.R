context("'columns' argument")

test_that("'columns' argument gives error if not a dataframe", {
    c <- c(1:10)
    testthat::expect_error(excelTable(columns = c), c("'columns' must be a dataframe, cannot be integer"))
})

test_that("valid 'columns' argument is passed to htmlwidget ", {
  c <-  data.frame(title=c('Model', 'Date', 'Availability'),
                   width= c(300, 300, 300),
                   type=c('text', 'calendar', 'checkbox'))
  testthat::expect_s3_class(suppressWarnings(excelTable(columns = c))$x$columns, "json")
})

test_that("'columns' argument gives error if number of column in 'data' is not equal to number of rows in
          'columns'", {
            d <- matrix(1:10, ncol = 2)
            c <- data.frame(x=c(1:4), y=c(1:4))
            testthat::expect_error(excelTable(data = d, columns = c),  "number of rows in 'columns' should be equal to number of columns in 'data', expected number of rows in 'columns' to be 2 but got 4")
          })

test_that("invalid 'columns' attributes should not be passed to htmlwidgets", {
  c <- data.frame(title=c('Model', 'Date', 'Availability'),
             length= c(300, 300, 300),
             type=c('text', 'calendar', 'checkbox'))
  testthat::expect_warning(excelTable(columns = c))
  testthat::expect_length(colnames(jsonlite::fromJSON(suppressWarnings(excelTable(columns = c)$x$columns))), 2)
})

test_that("all valid 'columns' attribute should be passed to htmlwidgets",{
  c <- data.frame(title = c(1), width = c(1), type = c(1), source = c(1), multiple =c(1), render = c(1))
  testthat::expect_length(colnames(jsonlite::fromJSON(excelTable(columns = c)$x$columns)), 6)
})


context("'colHeaders' argument")

test_that("'colHeaders' argument gives error if not a vector", {
  c <- data.frame()
  testthat::expect_error(excelTable(colHeaders = c), c("'colHeaders' must be a vector, cannot be data.frame"))
})

test_that("valid 'colHeaders' argument is passed to htmlwidget ", {
  c <-  c(1:10)
  testthat::expect_s3_class(suppressWarnings(excelTable(colHeaders = c))$x$colHeaders, "json")
})

test_that("'colHeaders' argument gives error if number of column in 'data' is not equal to length
          of 'colHeaders'", {
            d <- matrix(1:10, ncol = 2)
            c <- c(1:3)
            testthat::expect_error(excelTable(data = d, colHeaders = c))
          })


context("'colHeaders' and columns argument not specified")

test_that("there should be warning if both 'colHeaders' and 'title' attribute of 'column' argument is not specified",{
  d <- matrix(1:10, ncol = 2)
  testthat::expect_warning(excelTable(data=d))
})

















