#[macro_use] extern crate rocket;

use rocket_dyn_templates::{Template, context};


#[get("/")]
fn index() -> Template {
    Template::render("index", context! {
        hello: "world",
    })
}

#[launch]
fn rocket() -> _ {
    rocket::build().attach(Template::fairing()).mount("/", routes![index])
}