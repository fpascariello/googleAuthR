#' googleSignIn UI
#'
#' Shiny Module for use with \link{googleSignIn}. If you just want a login to a Shiny app, without API tokens.
#' 
#' @param id Shiny id
#' 
#' @author Based on original code by David Kulp
#' 
#' @seealso \url{https://github.com/dkulp2/Google-Sign-In}
#'
#' @return Shiny UI
#' @export
googleSignInUI <- function(id){

  ns <- shiny::NS(id)
  
  shiny::tagList(
    shiny::tags$head(
      shiny::tags$meta(name="google-signin-scope", content="profile email"),
      shiny::tags$meta(name="google-signin-client_id", content=getOption("googleAuthR.webapp.client_id")),
      shiny::HTML('<script src="https://apis.google.com/js/platform.js?onload=init"></script>')
    ),
    shiny::div(id=ns("signin"), class="g-signin2", "data-onsuccess"="onSignIn"),
    shiny::tags$button(id = ns("signout"), "Sign Out", onclick="signOut();", class="btn-danger"),
    load_js_template(system.file("js/signin-top.js", package = "googleAuthR"),
                     ns("signin"), ns("signout") ,ns("g_id"), ns("g_name"), ns("g_image"), ns("g_email")),
    load_js_template(system.file("js/signin-bottom.js", package = "googleAuthR"),
                     ns("g_id"), ns("g_name"), ns("g_image"), ns("g_email"))
  )
}



#' googleSignIn
#'
#' Shiny Module for use with \link{googleSignInUI}
#'
#' Call via \code{shiny::callModule(googleSignIn, "your_id")}
#'
#' @param input shiny input
#' @param output shiny output
#' @param session shiny session
#'
#' @return A reactive list with values $g_id, $g_name, $g_email and $g_image
#' @export
googleSignIn <- function(input, output, session){
  check_package_loaded("shiny")

  ns <- session$ns

  signed_in <- shiny::reactive({
    
    shiny::req(input$g_id)

    list(
      id = input$g_id,
      name = input$g_name,
      email = input$g_email,
      image = input$g_image
    )
    
  })
  
  return(signed_in)
  
}