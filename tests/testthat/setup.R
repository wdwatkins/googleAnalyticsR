library(testthat)
library(googleAnalyticsR)

options(googleAuthR.scopes.selected = 
          c("https://www.googleapis.com/auth/analytics",
            "https://www.googleapis.com/auth/analytics.edit",
            "https://www.googleapis.com/auth/analytics.manage.users",
            "https://www.googleapis.com/auth/analytics.user.deletion",
            "https://www.googleapis.com/auth/drive"))

# auth cache with custom project creds
if(Sys.getenv("GAR_CLIENT_JSON") != ""){
  googleAuthR::gar_set_client()
  dir.create("cache/")
  ga_cache_call("cache/")
}


if(file.exists("/workspace/auth.json")){
  message("Auth on Cloud Build")
  ga_auth(json_file = "/workspace/auth.json")
}


accountId <- 54019251
webPropId <- "UA-54019251-4"
ga_id <- 106249469

accountId2 <- 47480439
webPropId2 <- "UA-47480439-2"
ga_id2 <- 81416156

test_that("Correct authentication", {
  skip_on_travis()
  skip_on_cran()
  
  al <- ga_account_list()
  expect_true(accountId %in% al$accountId)
  expect_true(accountId2 %in% al$accountId)
  expect_true(ga_id %in% al$viewId)
  expect_true(ga_id2 %in% al$viewId)
})