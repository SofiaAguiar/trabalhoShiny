library(shiny)
library(tablerDash)
library(shinyEffects)
library(echarts4r)
library(shinyWidgets)

library(ggplot2)
library(aplore3)
data('myopia')

shiny::shinyApp(
    ui = tablerDashPage(
        enable_preloader = TRUE,
        loading_duration = 4,
        navbar = tablerDashNav(
            id = "myopia-menu",
            src = "https://www.vista-laser.com/wp-content/uploads/2013/02/ojo-miopia.png",
            navMenu = tablerNavMenu(
                tablerNavMenuItem(
                    tabName = "BancoDados",
                    icon = "database",
                    "Banco de dados"
                ),
            )
        ),
        footer = tablerDashFooter(
            copyrights = "Análise Myopia/Aplore3. @Aline Pinto & @Sofia Aguiar, 2021"
        ),
        title = "Myopia - Aplore3",
        body = tablerDashBody(
            setZoom(class = "card"),
            tablerTabItems(
                tablerTabItem(
                    tabName = "BancoDados",
                    fluidRow(
                        column(
                            width = 12,
                            tablerCard(
                                title = "Descrição - myopia",
                                width = 12,
                                collapsed = TRUE,
                                closable = FALSE,
                                "myopia faz parte de um conjunto de dados da Orinda Longitudinal Study of Myopia (OLSM),
                                um estudo sobre o desenvolvimento do componente ocular e fatores de risco para o início da
                                miopia em crianças. A coleta de dados desse database foi iniciada durante o período escolar
                                de 1989–1990 e continuou anualmente até o ano escolar de 2000–2001 e contém não só dados sobre
                                a criança, mas também aspectos familiares. Os dados sobre as partes que compõem o olho da criança
                                (os componentes oculares) foram coletados durante exames em um dia escolar. Sobre a história familiar
                                e atividades visuais, os dados foram coletados anualmente em uma pesquisa respondida por um dos pais
                                ou responsável. Ao todo, 17 variáveis e 618 indivíduos compõem o banco de dados.",
                                
                                tablerTable(
                                    title = "Variáveis",
                                    tablerTableItem(
                                        left = tablerTag(name = "Id"),
                                        right = "Identificador de sujeito"
                                    ),
                                    tablerTableItem(
                                        left = tablerTag(name = "studyyear"),
                                        right = "Ano que entrou no estudo"
                                    ),
                                    tablerTableItem(
                                        left = tablerTag(name = "myopic"),
                                        right = "Se foi diagnosticado como míope nos cinco anos de acompanhamento"
                                    ),
                                    tablerTableItem(
                                        left = tablerTag(name = "age"),
                                        right = "Idade em anos na primeira visita"
                                    ),
                                    tablerTableItem(
                                        left = tablerTag(name = "gender"),
                                        right = "Sexo (Masculino ou Feminino)"
                                    ),
                                    tablerTableItem(
                                        left = tablerTag(name = "spheq"),
                                        right = "Refração equivalente esférica (dioptria)"
                                    ),
                                    tablerTableItem(
                                        left = tablerTag(name = "al"),
                                        right = "Comprimento axial (mm)"
                                    ),
                                    tablerTableItem(
                                        left = tablerTag(name = "acd"),
                                        right = "Profundidade da Câmara Anterior (mm)"
                                    ),
                                    tablerTableItem(
                                        left = tablerTag(name = "lt"),
                                        right = "Espessura da lente (mm)"
                                    ),
                                    tablerTableItem(
                                        left = tablerTag(name = "vdc"),
                                        right = "Profundidade da câmara vítrea (mm)"
                                    ),
                                    tablerTableItem(
                                        left = tablerTag(name = "sporthr"),
                                        right = "Horas por semana praticando esportes fora da escola"
                                    ),
                                    tablerTableItem(
                                        left = tablerTag(name = "readhr"),
                                        right = "Horas por semana lendo fora da escola"
                                    ),
                                    tablerTableItem(
                                        left = tablerTag(name = "comphr"),
                                        right = "Horas por semana usando computador fora da escola"
                                    ),
                                    tablerTableItem(
                                        left = tablerTag(name = "studyhr"),
                                        right = "Horas por semana estudando fora da escola"
                                    ),
                                    tablerTableItem(
                                        left = tablerTag(name = "tvhr"),
                                        right = "Horas por semana vendo televisão fora da escola"
                                    ),
                                    tablerTableItem(
                                        left = tablerTag(name = "diopterhr"),
                                        right = "Compósito de horas por semana praticando atividades similares a trabalho fora da escola"
                                    ),
                                    tablerTableItem(
                                        left = tablerTag(name = "mommy"),
                                        right = "Se a mãe do sujeito é míope"
                                    ),
                                    tablerTableItem(
                                        left = tablerTag(name = "dadmy"),
                                        right = "Se o pai do sujeito é míope"
                                    ),
                                )
                            ),
                        ),
                        column(
                            width = 12,
                            tablerCard(
                                title = "Banco de dados",
                                fluidRow(
                                    column(3,
                                           selectInput("myopic",
                                                       "Criança possui miopía:",
                                                       c("All",
                                                         unique(as.character(myopia$myopic))))
                                    ),
                                    column(3,
                                           selectInput("gender",
                                                       "Gêreno da criança:",
                                                       c("All",
                                                         unique(as.character(myopia$gender))))
                                    ),
                                    column(3,
                                           selectInput("mommy",
                                                       "Mãe possui miopía:",
                                                       c("All",
                                                         unique(as.character(myopia$mommy))))
                                    ),
                                    column(3,
                                           selectInput("dadmy",
                                                       "Pai possui miopía:",
                                                       c("All",
                                                         unique(as.character(myopia$dadmy))))
                                    )
                                ),
                                DT::dataTableOutput('data'),
                                width = 12,
                                overflow = TRUE,
                                collapsible = FALSE,
                                closable = FALSE
                            ),
                        )
                    )
                )
            )
        )
    ),
    server = function(input, output) {
        output$data <- DT::renderDataTable(DT::datatable({
            table <- myopia
            if (input$myopic != "All") {
                table <- table[table$myopic == input$myopic,]
            }
            if (input$gender != "All") {
                table <- table[table$gender == input$gender,]
            }
            if (input$mommy != "All") {
                table <- table[table$mommy == input$mommy,]
            }
            if (input$dadmy != "All") {
                table <- table[table$dadmy == input$dadmy,]
            }
            table
        }))
    }
)
