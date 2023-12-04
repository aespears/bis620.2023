#' @title Plot phase histogram
#' @description Plots bar chart showing the phases of studies in a query
#' @param d the database table.
#' @return ggplot bar graph showing phases
#' @importFrom dplyr select mutate distinct group_by summarize
#' @importFrom ggplot2 ggplot aes geom_col theme_bw xlab ylab
#' @export

plot_phase_histogram = function(d) {
  d$phase[is.na(d$phase)] = "NA"

  # Get all the possible phases so histogram is consistent
  phases <- studies |> select(phase) |>
    mutate(phase = ifelse(is.na(phase),'NA', phase)) |>
    distinct() |> unlist()

  d = d |>
    select(phase) |>
    group_by(phase) |>
    summarize(n = n())

  # Add phases missing from d back in
  if (length(dif <- setdiff(phases, d$phase)) > 0){
    d = d |> rbind(data.frame(phase = dif,
                              n = 0))
  }
  ggplot(d, aes(x = phase, y = n)) +
    geom_col() +
    theme_bw() +
    xlab("Phase") +
    ylab("Count")

}
