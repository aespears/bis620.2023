#' Get the durations of the studies in a query plotted as a histogram
#' @param d the studies to get the durations for for.
#' @return A histogram showing the duration in days of all the studies
#' @importFrom ggplot2 ggplot geom_histogram theme_bw xlab ylab
#' @importFrom dplyr mutate
#' @export
plot_trial_durations = function(d) {
  d |>
    mutate(duration = completion_date - start_date) |>
    ggplot(aes(x = duration)) +
    geom_histogram() +
    theme_bw() +
    xlab("Duration (days)") +
    ylab("Count")
}
