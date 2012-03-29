package controllers

import play.api._
import play.api.mvc._

object Application extends Controller {
  
  def index = Action {
    Ok(views.html.index("Your new application is ready."))
  }

  def board = Action {
  	Ok(views.html.board())
  }

  def coffeebone = Action {
  	Ok(views.html.coffeebone())
  }
  
}