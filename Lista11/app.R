library(shiny)
library(tablerDash)

shiny::shinyApp(
    ui = tablerDashPage(
        enable_preloader = TRUE,
        loading_duration = 4,
        navbar = tablerDashNav(
            id = "myopia-menu",
            src = "https://i.dlpng.com/static/png/6521175_preview.png",
            navMenu = tablerNavMenu(
                tablerNavMenuItem(
                    tabName = "BancoDados",
                    icon = "home",
                    "Banco de dados"
                ),
                tablerNavMenuItem(
                    tabName = "Histograma",
                    icon = "box",
                    "Histograma"
                ),
                tablerNavMenuItem(
                    tabName = "Etc",
                    icon = "box",
                    "Etc"
                ),
            )
        ),
        footer = tablerDashFooter(
            copyrights = "Análise Myopia/Aplore3. @Aline Pinto & @Sofia Aguiar, 2021"
        ),
        title = "Myopia - Aplore3",
        ),
    
    server = function(input, output, session) {}
)

