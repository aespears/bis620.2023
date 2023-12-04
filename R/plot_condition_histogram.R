#' #' @title Plot condition histogram
#' @description Create a histogram of the conditions returned by a brief
#' title keyword search
#' @param d the database table.
#' @return ggplot bar graph showing top 15 conditions
#' @importFrom dplyr left_join select group_by summarise slice_max
#' @importFrom ggplot2 ggplot aes geom_col theme_bw xlab ylab theme
#' @export
plot_condition_histogram = function(d) {
  d = d |>
    left_join(conditions, by = 'nct_id', copy = T) |>
    select(name) |>
    group_by(name) |>
    summarise(n = n()) |>
    slice_max(n, n = 15)
  # Only get top 15 most common occurring conditions so screen isn't too full

  ggplot(d, aes(x = name, y = n)) +
    geom_col() +
    theme_bw() +
    xlab("Condition") +
    ylab("Count") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))
}
