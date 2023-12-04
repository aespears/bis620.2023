#' Maps the location of the studies on a world map (colored according to number)
#' @param d the studies to get the countries for for.
#' @return A histogram showing the countries represented in the study
#' @importFrom tidyr left_join
#' @importFrom dplyr group_by summarise mutate arrange
#' @importFrom ggplot2 ggplot aes geom_polygon theme_minimal map_data
#' @export
plot_map = function(d){
  d |>
    left_join(countries, by = 'nct_id', copy = T) |>
    group_by(name) |>
    summarise(n = n()) |>
    mutate(name = ifelse(name == "United States", "USA", name),
           name = ifelse(name == "United Kingdom", "UK", name)) |>
    merge(map_data('world'), by.x = 'name', by.y = 'region', all = T) |>
    arrange(order) |>
    ggplot(aes(x = long, y = lat, group = group, fill = log(n))) +
    geom_polygon(color = 'black', linewidth = 0.5) +
    theme_minimal()
}
