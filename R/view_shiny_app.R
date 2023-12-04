
#' Create shiny app to explore clinical trials data
#'
#' @returns A shiny app visualization with multiple tabs for explortation
#' @import shiny
#' @import dplyr
#' @import ggplot2
#' @export

view_shiny_app <- function(){
max_num_studies = 1000

# Define UI for application that draws a histogram
ui <- fluidPage(

  # Application title
  titlePanel("Clinical Trials Query"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      textInput("brief_title_kw", "Brief title keywords"),
      selectInput("source_class",
                  label = "Sponsor Type",
                  choices =  list("Federal"="FED",
                                  "Individual" = "INDIV",
                                  "Industry" = "INDUSTRY",
                                  "Network" = "NETWORK",
                                  "NIH" = "NIH",
                                  "Other" = "OTHER",
                                  "Other gov" = "OTHER_GOV",
                                  "Unknown" = "UNKNOWN"),
                  multiple = TRUE),
      selectInput("phase",
                  label = 'Phase',
                  choices = c('Early Phase 1', 'Phase 1', 'Phase 1/Phase 2',
                              'Phase 2', 'Phase 2/Phase 3', 'Phase 3', 'Phase 4',
                              'Not Applicable'),
                  multiple = TRUE),
      selectInput("study_type",
                  label = 'Study Type',
                  choices = c('Interventional', 'Observational',
                              'Observational [Patient Registry]', 'Expanded Access'),
                  multiple = TRUE)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        type = "tabs",
        tabPanel("Phase", plotOutput("phase_plot")),
        tabPanel("Concurrent", plotOutput("concurrent_plot")),
        tabPanel("Conditions", plotOutput("condition_plot")),
        tabPanel("Durations", plotOutput("duration_plot")),
        tabPanel("Map", plotOutput("map"))
      ),
      dataTableOutput("trial_table")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  # reactive: special shiny function that reacts to user input
  get_studies = reactive({
    if (input$brief_title_kw != "") {
      si = input$brief_title_kw |>
        strsplit(",") |>
        unlist() |>
        trimws()
      ret = query_kwds(studies, si, "brief_title", match_all = TRUE)
    } else {
      ret = studies
    }
    if (!is.null(input$source_class)){
      ret <- ret |> filter(source_class %in% !!input$source_class)
    }
    if (!is.null(input$phase)){
      ret <- ret |> filter(phase %in% !!input$phase)
    }
    if (!is.null(input$study_type)){
      ret <- ret |> filter(study_type %in% !!input$study_type)
    }
    ret |>
      head(max_num_studies)
  })

  output$phase_plot = renderPlot({
    get_studies() |>
      plot_phase_histogram()
  })

  output$concurrent_plot = renderPlot({
    get_studies() |>
      select(start_date, completion_date) |>
      get_concurrent_trials() |>
      ggplot(aes(x = date, y = count)) +
      geom_line() +
      xlab("Date") +
      ylab("Count") +
      theme_bw()
  })

  output$condition_plot = renderPlot({
    get_studies() |>
      plot_condition_histogram()
  })

  output$trial_table = renderDataTable({
    get_studies() |>
      select(nct_id, brief_title, start_date, completion_date) |>
      rename(`NCT ID` = nct_id, `Brief Title` = brief_title,
             `Start Date` = start_date, `Completion Date` = completion_date)
  }, selection = 'single')

  output$duration_plot = renderPlot({
    get_studies() |>
      plot_trial_durations()
  })

  output$map = renderPlot({
    get_studies() |>
      plot_map()
  })


  # Update search bar when keyword button is clicked
  observe({
    updateTextInput(inputId = 'brief_title_kw', value = input$kwButtons)
  })



  ## end
}

# Run the application
shinyApp(ui = ui, server = server)
}
