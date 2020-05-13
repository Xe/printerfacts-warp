use std::convert::Infallible;
use rand::prelude::*;
use warp::Filter;

mod facts;

async fn give_fact(facts: facts::Facts) -> Result<String, Infallible> {
    Ok(facts.choose(&mut thread_rng()).unwrap().clone())
}

#[tokio::main]
async fn main() {
    let facts = facts::make();

    let mw = warp::any().map(move || facts.clone());

    let fact_handler = warp::any()
        .and(mw)
        .and_then(give_fact);

    warp::serve(fact_handler)
        .run(([0, 0, 0, 0], 5000))
        .await;
}
